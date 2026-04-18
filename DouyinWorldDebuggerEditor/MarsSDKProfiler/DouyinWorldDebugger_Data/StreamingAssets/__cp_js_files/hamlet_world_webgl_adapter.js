(function (factory) {
    typeof define === 'function' && define.amd ? define(factory) :
        factory();
})((function () { 'use strict';

    let stringToUTF8;
    let lengthBytesUTF8;
    let UTF8ToString;
    let _malloc;
    let _free;
    let dynCall;
    let Module;
    function inject(wasm) {
        stringToUTF8 = wasm.stringToUTF8;
        lengthBytesUTF8 = wasm.lengthBytesUTF8;
        UTF8ToString = wasm.UTF8ToString;
        _malloc = wasm._malloc;
        _free = wasm._free;
        dynCall = wasm.dynCall;
        Module = wasm.Module;
    }
    function strToPtr(str) {
        const length = lengthBytesUTF8(str) + 1;
        const ptr = _malloc(length);
        stringToUTF8(str, ptr, length);
        return ptr;
    }
    function strFromPtr(ptr) {
        return UTF8ToString(ptr);
    }
    function u8ArrayToPtr(array, ptrOrNull) {
        const length = array.byteLength;
        const ptr = ptrOrNull || _malloc(length);
        Module.HEAPU8.set(array, ptr);
        return ptr;
    }
    function u8ArrayFromPtr(ptr, length, copy) {
        const array = Module.HEAPU8.subarray(ptr, ptr + length);
        if (copy) {
            return array.slice();
        }
        return array;
    }
    function makeDynCaller(sig, ptr, args) {
        return dynCall(sig, ptr, args);
    }
    function free(ptr) {
        _free(ptr);
    }
    const wasmUtils = {
        strToPtr,
        strFromPtr,
        u8ArrayToPtr,
        u8ArrayFromPtr,
        makeDynCaller,
        free,
        inject,
    };

    function writeImageBytesSync(dataPtr, length, typePtr) {
        // 将类型指针转换为 JS 字符串
        const imageType = wasmUtils.strFromPtr(typePtr);
        // 从 WASM 内存中截取并复制字节数组
        const array = wasmUtils.u8ArrayFromPtr(dataPtr, length, true);
        let resultPath;
        try {
            const result = __game_dock_extra__.innerGameApi.invokeBufferSync("hamletSaveImageSync", {
                data: array.buffer,
                type: imageType,
            });
            resultPath = result.path;
        }
        catch (e) {
            console.error("Error calling external API (hamletSaveImageSync):", e);
            resultPath = "";
        }
        const buffer = wasmUtils.strToPtr(resultPath); // 分配 WASM 内存
        return buffer; // 返回指向结果字符串的指针
    }
    // jsblib 调用create后会将返回的对象挂到window的hamlet对象上。
    function createHamletBridge(wasm) {
        wasmUtils.inject(wasm);
        window.hamlet.didInit = true;
    }
    function hamletReportGameException(name, reason, stacktrace) {
        if (window.webkit &&
            window.webkit.messageHandlers &&
            window.webkit.messageHandlers.unityExceptionHandler) {
            window.webkit.messageHandlers.unityExceptionHandler.postMessage({
                name: name,
                reason: reason,
                stacktrace: stacktrace,
            });
        }
    }
    // 将这个工厂函数暴露给全局 window 对象，等待 JSLIB 调用
    window.hamlet = {
        createHamletBridge: createHamletBridge,
        reportGameException: hamletReportGameException,
        writeImageBytesSync: writeImageBytesSync,
        didInit: false,
    };

}));

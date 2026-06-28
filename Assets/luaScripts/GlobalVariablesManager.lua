--对话配置文件
---@var GlobalVariablesScript :DouyinScript
---@var NPCDataConfig :DouyinScript
---@var DialogueData :DouyinScript[]
---@var infoText :UnityEngine.UI.Text
---@var ShowBtn :UnityEngine.UI.Button
---@var searchInput :UnityEngine.UI.InputField
---@var searchBtn :UnityEngine.UI.Button
---@end

local globalVariables = {}

-- 从 Inspector 引用的 DouyinScript 加载全局变量配置，初始化所有变量（bool=false, int=1）
local function LoadGlobalVariablesFromFile()
    if not GlobalVariablesScript or not GlobalVariablesScript.script then
        print("[GlobalVariables] GlobalVariablesScript 引用未设置")
        return
    end

    local data = GlobalVariablesScript.script.GlobalVariables
    if data == nil then
        print("[GlobalVariables] 数据为空")
        return
    end

    for _, item in ipairs(data) do
        if item.name and item.type then
            if item.type == "bool" then
                globalVariables[item.name] = { type = "bool", value = false }
            else
                globalVariables[item.name] = { type = "int", value = 1 }
            end
        end
    end
    print("[GlobalVariables] 通过 Inspector 引用加载完成")
end

-- 获取指定全局变量的当前值
function GetGlobalVar(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].value
end

-- 设置全局变量的值（不存在则自动创建，默认 bool 类型）
function SetGlobalVar(varName, value, varType)
    if varName == nil or varName == "" then return end
    varType = varType or "bool"

    if globalVariables[varName] == nil then
        if varType == "bool" then
            globalVariables[varName] = { type = "bool", value = false }
        else
            globalVariables[varName] = { type = "int", value = 0 }
        end
    end

    if varType == "bool" then
        globalVariables[varName].value = (value == true or value == "true" or value == 1)
    else
        globalVariables[varName].value = tonumber(value) or 0
    end

    print("[GlobalVariables] 设置变量: " .. varName .. " = " .. tostring(globalVariables[varName].value))
end

-- 获取指定全局变量的类型（"bool" 或 "int"）
function GetGlobalVarType(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].type
end

-- 通过名称在 Canvas 下查找 UI 组件（Inspector 未赋值时的兜底查找）
local function FindUIComponentByName(name, componentType)
    local canvas = UnityEngine.GameObject.Find("Canvas")
    if not canvas then
        print("[GlobalVariables] 未找到 Canvas")
        return nil
    end

    local child = canvas.transform:Find(name)
    if not child then
        print("[GlobalVariables] 未找到子对象: " .. name)
        return nil
    end

    local component = child:GetComponent(typeof(componentType))
    if not component then
        print("[GlobalVariables] 子对象 " .. name .. " 没有 " .. componentType.Name .. " 组件")
        return nil
    end

    return component
end

-- 显示按钮回调：在 infoText 上展示所有全局变量的实时值
local function OnShowBtnClick()
    print("[GlobalVariables] OnShowBtnClick 被调用")

    if not infoText then
        print("[GlobalVariables] infoText 为空")
        return
    end

    local result = "=== 全局变量实时值 ===\n\n"

    if not GlobalVariablesScript or not GlobalVariablesScript.script then
        infoText.text = "GlobalVariablesScript 引用未设置"
        return
    end

    local data = GlobalVariablesScript.script.GlobalVariables

    if data then
        local line = ""
        local colCount = 0
        local displayIndex = 0
        for _, item in ipairs(data) do
            if item.name then
                displayIndex = displayIndex + 1
                colCount = colCount + 1
                local runtimeValue = GetGlobalVar(item.name)
                local displayValue = "nil"
                if runtimeValue ~= nil then
                    displayValue = tostring(runtimeValue)
                else
                    displayValue = "文件值: " .. tostring(item.value)
                end

                local varText = string.format("%d. %s=%s", displayIndex, item.name, displayValue)

                if line == "" then
                    line = varText
                else
                    line = line .. " | " .. varText
                end

                if colCount % 5 == 0 then
                    result = result .. line .. "\n"
                    line = ""
                end
            end
        end

        if line ~= "" then
            result = result .. line .. "\n"
        end
    end

    infoText.text = result
end

-- 搜索按钮回调：根据关键字模糊搜索全局变量名
local function OnSearchBtnClick()
    print("[GlobalVariables] OnSearchBtnClick 被调用")

    if not searchInput then
        print("[GlobalVariables] searchInput 为空")
        if infoText then
            infoText.text = "错误：searchInput 未赋值"
        end
        return
    end

    local keyword = searchInput.text
    if keyword == nil or keyword == "" then
        print("[GlobalVariables] 搜索关键字为空")
        if infoText then
            infoText.text = "请输入要查询的变量名"
        end
        return
    end

    print("[GlobalVariables] 搜索关键字: " .. keyword)

    local result = "=== 搜索结果: " .. keyword .. " ===\n\n"
    local found = false

    for name, var in pairs(globalVariables) do
        if string.find(name, keyword, 1, true) then
            found = true
            local displayValue = tostring(var.value)
            result = result .. string.format("%s = %s (%s)\n", name, displayValue, var.type)
        end
    end

    if not found then
        result = result .. "未找到匹配的变量"
    end

    if infoText then
        infoText.text = result
    end

    print("[GlobalVariables] 搜索结果: " .. result)
end

-- 将所有 NPC 的 currentBranchId 重置为 1，用于每次启动时恢复默认分支
function ResetAllNPCBranchesToStart()
    if not NPCDataConfig or not NPCDataConfig.script then
        print("[GlobalVariables] NPCDataConfig 引用未设置")
        return
    end

    local data = NPCDataConfig.script.NPCData
    if data and data.npcList then
        for _, npc in ipairs(data.npcList) do
            if npc.currentBranchId then
                npc.currentBranchId = 1
            end
        end
        print("[GlobalVariables] NPCData_Config 所有分支已重置为 1")
    end
end

-- Unity 启动入口：加载全局变量、重置NPC分支、注册全局函数、绑定 UI 按钮
function Start()
    LoadGlobalVariablesFromFile()
    ResetAllNPCBranchesToStart()
    _G["_GlobalVariables"] = globalVariables
    _G["GetGlobalVar"] = GetGlobalVar
    _G["SetGlobalVar"] = SetGlobalVar
    _G["GetGlobalVarType"] = GetGlobalVarType
    if NPCDataConfig and NPCDataConfig.script then
        _G["_NPCDataConfig"] = NPCDataConfig.script.NPCData
    end

    local count = 0
    for _ in pairs(globalVariables) do count = count + 1 end
    print("[GlobalVariables] 初始化完成，共 " .. count .. " 个变量")

    if not infoText then
        print("[GlobalVariables] infoText 为空，尝试通过名称查找")
        infoText = FindUIComponentByName("InfoText", UnityEngine.UI.Text)
    end

    if not ShowBtn then
        print("[GlobalVariables] ShowBtn 为空，尝试通过名称查找")
        ShowBtn = FindUIComponentByName("ShowBtn", UnityEngine.UI.Button)
    end

    if not searchInput then
        print("[GlobalVariables] searchInput 为空，尝试通过名称查找")
        searchInput = FindUIComponentByName("SearchInput", UnityEngine.UI.InputField)
    end

    if not searchBtn then
        print("[GlobalVariables] searchBtn 为空，尝试通过名称查找")
        searchBtn = FindUIComponentByName("SearchBtn", UnityEngine.UI.Button)
    end

    print("[GlobalVariables] ShowBtn: " .. tostring(ShowBtn))
    print("[GlobalVariables] searchBtn: " .. tostring(searchBtn))
    print("[GlobalVariables] infoText: " .. tostring(infoText))
    print("[GlobalVariables] searchInput: " .. tostring(searchInput))

    if ShowBtn then
        ShowBtn.onClick:AddListener(OnShowBtnClick)
        print("[GlobalVariables] ShowBtn 绑定成功")
    else
        print("[GlobalVariables] 警告：ShowBtn 未赋值")
    end

    if searchBtn then
        searchBtn.onClick:AddListener(OnSearchBtnClick)
        print("[GlobalVariables] searchBtn 绑定成功")
    else
        print("[GlobalVariables] 警告：searchBtn 未赋值")
    end
end


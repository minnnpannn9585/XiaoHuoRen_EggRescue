--开始对话的ID
---@var ID :int
---@var npcname :string
---@end

local loadedNPCScripts = {}

-- Unity 启动入口：检查 DialogueManager 是否存在
function Start()
    if _G["_DialogueManager"] == nil then
        logError("场景中缺少DialogueManager预制件")
    end
end

-- 从全局 _NPCDataConfig 加载 NPC 配置，构建 byId/byName 索引表
function LoadNPCConfig()
    local data = _G["_NPCDataConfig"]
    if not data or not data.npcList then
        logError("NPC: _NPCDataConfig 数据为空")
        return
    end

    _NPCConfigs = { byId = {}, byName = {} }
    for _, npc in ipairs(data.npcList) do
        if npc.id then _NPCConfigs.byId[npc.id] = npc end
        if npc.name then _NPCConfigs.byName[npc.name] = npc end
    end
    print("NPC " .. #data.npcList .. " ")
end

-- 标准化对话数据格式：支持 DouyinScript.script.DialogueConfig、直接 DialogueConfig、数字 key 表三种格式
function NormalizeDialogueData(rawData)
    if rawData == nil then
        return nil
    end

    if rawData.script and rawData.script.DialogueConfig then
        return rawData.script.DialogueConfig
    end

    if rawData.DialogueConfig then
        return rawData.DialogueConfig
    end

    local hasNumberKey = false
    for k, v in pairs(rawData) do
        if type(k) == "number" and type(v) == "table" and (v.Dialogue or v.NpcName or v.Type) then
            hasNumberKey = true
            break
        end
    end
    if hasNumberKey then
        return rawData
    end

    return nil
end

-- 根据 NPC 名称加载对应分支的对话脚本，从场景中 DialogueData 物体下查找 DouyinScript 读取数据
function LoadNPCScript(npcName)
    if not npcName or npcName == "" then
        logError("NPC")
        return nil
    end

    -- 懒加载：首次调用时如果 _NPCConfigs 未初始化，尝试加载
    if not _NPCConfigs and _G["_NPCDataConfig"] and _G["_NPCDataConfig"].npcList then
        LoadNPCConfig()
    end

    -- 从全局 _NPCDataConfig 查找 NPC 配置
    local npcConfig = nil
    local data = _G["_NPCDataConfig"]
    if not data then
        logError("NPC [" .. npcName .. "]: _NPCDataConfig 全局变量未设置")
        return nil
    end
    if not data.npcList then
        logError("NPC [" .. npcName .. "]: _NPCDataConfig.npcList 为空")
        return nil
    end
    for _, npc in ipairs(data.npcList) do
        if npc.name == npcName then
            npcConfig = npc
            break
        end
    end

    if not npcConfig then
        logError("NPC [" .. npcName .. "]: 在 npcList 中未找到")
        return nil
    end

    local currentBranchId = npcConfig.currentBranchId or 1
    local luaAssetPath = nil

    if npcConfig.storyGraphs then
        for _, graph in ipairs(npcConfig.storyGraphs) do
            if graph.branchId == currentBranchId then
                luaAssetPath = graph.luaAssetPath
                break
            end
        end
        -- 旧 UnlockBranches 可能把 currentBranchId 切到已删除的分支，回退到可用分支
        if (not luaAssetPath or luaAssetPath == "") and #npcConfig.storyGraphs > 0 then
            local fallbackId = currentBranchId
            for _, graph in ipairs(npcConfig.storyGraphs) do
                if graph.branchId == 1 and graph.luaAssetPath and graph.luaAssetPath ~= "" then
                    luaAssetPath = graph.luaAssetPath
                    fallbackId = 1
                    break
                end
            end
            if not luaAssetPath or luaAssetPath == "" then
                local g = npcConfig.storyGraphs[1]
                luaAssetPath = g.luaAssetPath
                fallbackId = g.branchId or 1
            end
            if fallbackId ~= currentBranchId then
                print(string.format(
                    "[DialogueLoad] NPC %s branch %d 无 Lua，回退到 branch %d",
                    npcName, currentBranchId, fallbackId))
                npcConfig.currentBranchId = fallbackId
                currentBranchId = fallbackId
            end
        end
    end

    if not luaAssetPath or luaAssetPath == "" then
        logError("NPC " .. npcName .. " " .. currentBranchId .. " Lua")
        return nil
    end

    local cacheKey = npcName .. "_b" .. currentBranchId

    -- 从 luaAssetPath 提取文件名（不含扩展名），如 "Assets/Editor/DialogueData/miaosu.lua" → "miaosu"
    local scriptName = luaAssetPath:match("([^/\\]+)%.lua$")
    if not scriptName then
        scriptName = luaAssetPath:match("([^/\\]+)$")
    end

    -- 在场景中查找 DialogueData 父物体
    local dialogueDataGo = CS.UnityEngine.GameObject.Find("DialogueData")
    if not dialogueDataGo then
        logError("NPC [" .. npcName .. "]: 场景中未找到 DialogueData 物体")
        return nil
    end

    -- 查找对应名称的子物体
    local childTransform = dialogueDataGo.transform:Find(scriptName)
    if not childTransform then
        logError("NPC [" .. npcName .. "]: DialogueData 下未找到子物体: " .. scriptName)
        return nil
    end

    -- 获取子物体上的 DouyinScript 组件
    local douyinScript = childTransform:GetComponent("DouyinScript")
    if not douyinScript then
        logError("NPC [" .. npcName .. "]: " .. scriptName .. " 上未找到 DouyinScript 组件")
        return nil
    end

    -- 通过 DouyinScript 组件标准化数据
    local normalizedData = NormalizeDialogueData(douyinScript)
    if normalizedData == nil then
        logError("NPC " .. npcName .. " 对话数据为空")
        return nil
    end

    loadedNPCScripts[cacheKey] = normalizedData
    print(string.format(
        "[DialogueLoad] npc=%s branchId=%d script=%s path=%s",
        npcName, currentBranchId, scriptName, luaAssetPath))
    return normalizedData
end

-- 开始对话：如果有 npcname 则加载 NPC 脚本并传入，否则直接用 ID 触发
function StartDialogue()
    if npcname and npcname ~= "" then
        local npcScript = LoadNPCScript(npcname)
        if npcScript then
            print(string.format("[DialogueLoad] start npc=%s startID=%s", npcname, tostring(ID)))
            _G["_DialogueManager"].StartDialogueWithData(npcScript, ID)
            return
        end
    end
    print(string.format("[DialogueLoad] start directID=%s", tostring(ID)))
    _G["_DialogueManager"].StartDialogue(ID)
end

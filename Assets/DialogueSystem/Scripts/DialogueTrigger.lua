--开始对话的ID
---@var ID :int
---@var npcname :string
---@end

local loadedNPCScripts = {}

function Start()
    if _G["_DialogueManager"]==nil then
        logError("场景中缺少DialogueManager预制件")
    end
    LoadNPCConfig()
end

function GetProjectPath()
    local dataPath = CS.UnityEngine.Application.dataPath
    local projectPath = dataPath
    
    if dataPath:find("DouyinWorldDebugger") or dataPath:find("_Data") then
        local parts = {}
        for part in dataPath:gmatch("[^/\\]+") do
            table.insert(parts, part)
        end
        if #parts >= 2 then
            local newParts = {}
            for i = 1, #parts - 2 do
                table.insert(newParts, parts[i])
            end
            projectPath = table.concat(newParts, "/")
        else
            projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../../")
        end
    else
        projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../")
    end
    
    return projectPath
end

function LoadNPCConfig()
    local projectPath = GetProjectPath()
    local configPath = CS.System.IO.Path.Combine(projectPath, "Assets/Editor/EidtData/NPCData_Config.lua")
    
    print("=== NPC ===")
    print("ProjectPath: " .. projectPath)
    print("ConfigPath: " .. configPath)
    
    local success, data = pcall(function()
        if not CS.System.IO.File.Exists(configPath) then
            error("file not found: " .. configPath)
        end
        local content = CS.System.IO.File.ReadAllText(configPath)
        local func = load(content)
        return func()
    end)
    
    if not success then
        logError("NPC: " .. tostring(data))
        return
    end
    
    _NPCConfigs = { byId = {}, byName = {} }
    if data and data.npcList then
        for _, npc in ipairs(data.npcList) do
            if npc.id then _NPCConfigs.byId[npc.id] = npc end
            if npc.name then _NPCConfigs.byName[npc.name] = npc end
        end
        print("NPC " .. #data.npcList .. " ")
    end
end

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

function ExecuteLuaFile(content)
    local result = nil
    local loadedGlobal = nil
    local oldDialogueConfig = DialogueConfig
    
    local func = load(content)
    result = func()
    
    if _G["DialogueConfig"] ~= nil and _G["DialogueConfig"] ~= oldDialogueConfig then
        loadedGlobal = _G["DialogueConfig"]
    end
    
    if result ~= nil then
        return result
    end
    return loadedGlobal
end

function LoadNPCScript(npcName)
    if not npcName or npcName == "" then
        logError("NPC")
        return nil
    end

    -- ===== 改动：每次都重新读取 NPC 配置文件，确保拿到最新的 currentBranchId =====
    local projectPath = GetProjectPath()
    local configPath = CS.System.IO.Path.Combine(projectPath, "Assets/Editor/EidtData/NPCData_Config.lua")

    local npcConfig = nil
    local cfgSuccess, cfgResult = pcall(function()
        if not CS.System.IO.File.Exists(configPath) then
            error("file not found: " .. configPath)
        end
        local content = CS.System.IO.File.ReadAllText(configPath)
        local func = load(content)
        local data = func()
        if data and data.npcList then
            for _, npc in ipairs(data.npcList) do
                if npc.name == npcName then
                    return npc
                end
            end
        end
        return nil
    end)

    if not cfgSuccess or not cfgResult then
        logError("NPC [" .. npcName .. "]: " .. tostring(cfgResult))
        return nil
    end

    npcConfig = cfgResult

    local currentBranchId = npcConfig.currentBranchId or 1
    local luaAssetPath = nil

    if npcConfig.storyGraphs then
        for _, graph in ipairs(npcConfig.storyGraphs) do
            if graph.branchId == currentBranchId then
                luaAssetPath = graph.luaAssetPath
                break
            end
        end
    end

    if not luaAssetPath or luaAssetPath == "" then
        logError("NPC " .. npcName .. " " .. currentBranchId .. " Lua")
        return nil
    end

    -- 缓存 key 同时包含 NPC 名和 branchId，切换分支时自动走新缓存
    local cacheKey = npcName .. "_b" .. currentBranchId
    if loadedNPCScripts[cacheKey] then
        print("NPC: " .. npcName .. " ( " .. currentBranchId .. ")")
        return loadedNPCScripts[cacheKey]
    end

    print("=== NPC ===")
    print("NPC: " .. npcName)
    print("Branch: " .. currentBranchId)
    print("LuaPath: " .. luaAssetPath)

    local fullPath = CS.System.IO.Path.Combine(projectPath, luaAssetPath)
    print("FullPath: " .. fullPath)

    local success, scriptData = pcall(function()
        if not CS.System.IO.File.Exists(fullPath) then
            error("file not found: " .. fullPath)
        end
        local content = CS.System.IO.File.ReadAllText(fullPath)
        return ExecuteLuaFile(content)
    end)

    if not success then
        logError("NPC [" .. npcName .. "]: " .. tostring(scriptData))
        return nil
    end

    local normalizedData = NormalizeDialogueData(scriptData)
    if normalizedData == nil then
        logError("NPC " .. npcName .. " ")
        return nil
    end

    loadedNPCScripts[cacheKey] = normalizedData
    print("NPC: " .. npcName .. " ( " .. currentBranchId .. ")")

    return normalizedData
end

function StartDialogue()
    if npcname and npcname ~= "" then
        local npcScript = LoadNPCScript(npcname)
        if npcScript then
            print("NPC: " .. npcname)
            _G["_DialogueManager"].StartDialogueWithData(npcScript, ID)
            return
        end
    end
    _G["_DialogueManager"].StartDialogue(ID)
end

function UnloadNPCScript(npcName)
    loadedNPCScripts[npcName] = nil
    print("NPC: " .. npcName)
end

function ClearAllLoadedScripts()
    loadedNPCScripts = {}
    print("NPC")
end

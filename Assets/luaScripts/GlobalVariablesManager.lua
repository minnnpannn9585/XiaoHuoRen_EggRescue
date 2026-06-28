---@var infoText :UnityEngine.UI.Text
---@var ShowBtn :UnityEngine.UI.Button
---@var searchInput :UnityEngine.UI.InputField
---@var searchBtn :UnityEngine.UI.Button
---@end

local globalVariables = {}
local globalVariablesPath = "Assets/Editor/EidtData/GlobalVariables.lua"

local function GetProjectPath()
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

local function LoadGlobalVariablesFromFile()
    local projectPath = GetProjectPath()
    local fullPath = CS.System.IO.Path.Combine(projectPath, globalVariablesPath)

    if not CS.System.IO.File.Exists(fullPath) then
        print("[GlobalVariables] 文件不存在: " .. fullPath)
        return
    end

    local success, err = pcall(function()
        local content = CS.System.IO.File.ReadAllText(fullPath)
        local func = load(content)
        if not func then
            print("[GlobalVariables] 加载文件失败")
            return
        end

        local data = func()
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
    end)

    if not success then
        print("[GlobalVariables] 读取失败: " .. tostring(err))
    end
end

function GetGlobalVar(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].value
end

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

function GetGlobalVarType(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].type
end

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

local function OnShowBtnClick()
    print("[GlobalVariables] OnShowBtnClick 被调用")

    if not infoText then
        print("[GlobalVariables] infoText 为空")
        return
    end

    local result = "=== 全局变量实时值 ===\n\n"

    local projectPath = GetProjectPath()
    local fullPath = CS.System.IO.Path.Combine(projectPath, globalVariablesPath)

    if CS.System.IO.File.Exists(fullPath) then
        local content = CS.System.IO.File.ReadAllText(fullPath)
        local func = load(content)
        if func then
            local data = func()
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
        end
    end

    infoText.text = result
end

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

function ResetAllNPCBranchesToStart()
    local projectPath = GetProjectPath()
    local configPath = CS.System.IO.Path.Combine(projectPath, "Assets/Editor/EidtData/NPCData_Config.lua")

    local success, err = pcall(function()
        if not CS.System.IO.File.Exists(configPath) then
            print("[GlobalVariables] NPCData_Config 文件不存在，跳过重置")
            return
        end
        local content = CS.System.IO.File.ReadAllText(configPath)
        local func = load(content)
        local data = func()
        if data and data.npcList then
            local changed = false
            for _, npc in ipairs(data.npcList) do
                if npc.currentBranchId and npc.currentBranchId ~= 1 then
                    npc.currentBranchId = 1
                    changed = true
                end
            end
            if changed then
                -- 序列化并写回文件
                local newContent = SerializeNPCConfigForReset(data.npcList)
                if newContent then
                    CS.System.IO.File.WriteAllText(configPath, newContent)
                    print("[GlobalVariables] NPCData_Config 所有分支已重置为 1")
                end
            end
        end
    end)

    if not success then
        print("[GlobalVariables] 重置 NPC 分支失败: " .. tostring(err))
    end
end

function SerializeNPCConfigForReset(npcList)
    if not npcList then return nil end
    local sb = {}
    table.insert(sb, "local NPCData = {")
    table.insert(sb, "    npcList = {")
    for i, npc in ipairs(npcList) do
        table.insert(sb, "        {")
        table.insert(sb, '            id = "' .. tostring(npc.id or "") .. '",')
        table.insert(sb, '            name = "' .. tostring(npc.name or "") .. '",')
        table.insert(sb, '            avatarPath = "' .. tostring(npc.avatarPath or "") .. '",')
        table.insert(sb, "            currentBranchId = " .. tostring(npc.currentBranchId or 1) .. ",")
        table.insert(sb, "            isFolded = " .. tostring(npc.isFolded ~= false) .. ",")
        if npc.storyGraphs and #npc.storyGraphs > 0 then
            table.insert(sb, "            storyGraphs = {")
            for j, graph in ipairs(npc.storyGraphs) do
                table.insert(sb, "                {")
                table.insert(sb, "                    branchId = " .. tostring(graph.branchId or 1) .. ",")
                table.insert(sb, '                    storyDescription = "' .. tostring(graph.storyDescription or "") .. '",')
                table.insert(sb, '                    luaModuleName = "' .. tostring(graph.luaModuleName or "") .. '",')
                table.insert(sb, '                    luaAssetPath = "' .. tostring(graph.luaAssetPath or "") .. '"')
                table.insert(sb, "                }" .. (j < #npc.storyGraphs and "," or ""))
            end
            table.insert(sb, "            }")
        else
            table.insert(sb, "            storyGraphs = {")
            table.insert(sb, "            }")
        end
        table.insert(sb, "        }" .. (i < #npcList and "," or ""))
    end
    table.insert(sb, "    }")
    table.insert(sb, "}")
    table.insert(sb, "return NPCData")
    return table.concat(sb, "\n")
end

function Start()
    LoadGlobalVariablesFromFile()
    ResetAllNPCBranchesToStart()
    _G["_GlobalVariables"] = globalVariables
    _G["GetGlobalVar"] = GetGlobalVar
    _G["SetGlobalVar"] = SetGlobalVar
    _G["GetGlobalVarType"] = GetGlobalVarType

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

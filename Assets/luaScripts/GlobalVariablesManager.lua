---@var infoText :UnityEngine.UI.Text
---@var ShowBtn :UnityEngine.UI.Button
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
                if globalVariables[item.name] == nil then
                    if item.type == "bool" then
                        globalVariables[item.name] = { type = "bool", value = (item.value == true or item.value == "true" or item.value == 1) }
                    else
                        globalVariables[item.name] = { type = "int", value = tonumber(item.value) or 0 }
                    end
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

function Start()
    LoadGlobalVariablesFromFile()
    _G["_GlobalVariables"] = globalVariables
    _G["GetGlobalVar"] = GetGlobalVar
    _G["SetGlobalVar"] = SetGlobalVar
    _G["GetGlobalVarType"] = GetGlobalVarType
    print("[GlobalVariables] 初始化完成，共 " .. #globalVariables .. " 个变量")
end

local function OnShowBtnClick()
    local result = "=== 全局变量实时值 ===\n\n"
    
    local projectPath = GetProjectPath()
    local fullPath = CS.System.IO.Path.Combine(projectPath, globalVariablesPath)
    
    if CS.System.IO.File.Exists(fullPath) then
        local content = CS.System.IO.File.ReadAllText(fullPath)
        local func = load(content)
        if func then
            local data = func()
            if data then
                for i, item in ipairs(data) do
                    if item.name then
                        local runtimeValue = GetGlobalVar(item.name)
                        local displayValue = "nil"
                        if runtimeValue ~= nil then
                            displayValue = tostring(runtimeValue)
                        else
                            displayValue = "文件值: " .. tostring(item.value)
                        end
                        
                        if item.type == "bool" then
                            result = result .. string.format("%d. %s = %s (bool)\n", i, item.name, displayValue)
                        else
                            result = result .. string.format("%d. %s = %s (int)\n", i, item.name, displayValue)
                        end
                    end
                end
            end
        end
    end
    
    infoText.text = result
end

ShowBtn.onClick:AddListener(OnShowBtnClick)
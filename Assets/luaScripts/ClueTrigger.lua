--线索解锁脚本
---@var name :string
---@var value :bool
---@end

function Awake()
     -- 每次启动游戏，把所有 bool 变量重置为 false（不保留上次解锁状态）
    ResetAllBoolVariablesToFalse()
end

-- Start is called before the first frame update
function Start()
    
end

function SetClue()
    if name == nil or name == "" then
        print("[ClueTrigger] name 为空，跳过")
        return
    end
    UpdateGlobalVariableInFile(name, value)
end

-- 将 GlobalVariables.lua 中所有 bool 类型的变量重置为 false（int 变量不变）
function ResetAllBoolVariablesToFalse()
    local projectPath = GetProjectPath()
    local filePath = CS.System.IO.Path.Combine(projectPath, "Assets/Editor/EidtData/GlobalVariables.lua")

    local success, result = pcall(function()
        if not CS.System.IO.File.Exists(filePath) then
            return false
        end

        local content = CS.System.IO.File.ReadAllText(filePath)
        local func = load(content)
        if not func then
            return false
        end
        local data = func()
        if data == nil then
            return false
        end

        -- 重置所有 bool 变量为 false
        for _, item in ipairs(data) do
            if item.type == nil or item.type == "bool" then
                item.value = false
            end
        end

        -- 重新序列化到 GlobalVariables.lua
        local sb = {}
        table.insert(sb, "local GlobalVariables = {")
        for i, item in ipairs(data) do
            local vType = item.type or "bool"
            local vStr = FormatLuaValue(item.value, vType)
            if i < #data then
                table.insert(sb, string.format('    { name = "%s", type = "%s", value = %s },',
                    tostring(item.name), vType, vStr))
            else
                table.insert(sb, string.format('    { name = "%s", type = "%s", value = %s }',
                    tostring(item.name), vType, vStr))
            end
        end
        table.insert(sb, "}")
        table.insert(sb, "return GlobalVariables")
        table.insert(sb, "")

        local newContent = table.concat(sb, "\n")
        CS.System.IO.File.WriteAllText(filePath, newContent)
        print("[ClueTrigger] ✓ 已重置所有 bool 变量为 false")
        return true
    end)

    if not success then
        print("[ClueTrigger] 重置 bool 变量失败: " .. tostring(result))
        return false
    end
    return result
end


-- 获取项目根目录（与 DialogueTrigger 保持一致）
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

-- 将值格式化为 Lua 字面量（bool 用 true/false，int 用数字）
function FormatLuaValue(val, varType)
    if varType == "bool" then
        return (val == true or val == "true" or val == 1 or val == "1") and "true" or "false"
    end
    return tostring(tonumber(val) or 0)
end

-- 根据 name 更新 GlobalVariables.lua 中对应条目的 value
-- @param varName 全局变量名（对应 GlobalVariables.lua 中的 name 字段）
-- @param newValue 新值（bool 或 int 都可以，自动根据原有 type 格式化）
-- @return 是否更新成功
function UpdateGlobalVariableInFile(varName, newValue)
    if varName == nil or varName == "" then
        print("[ClueTrigger] 变量名不能为空")
        return false
    end

    local projectPath = GetProjectPath()
    local filePath = CS.System.IO.Path.Combine(projectPath, "Assets/Editor/EidtData/GlobalVariables.lua")

    local success, result = pcall(function()
        if not CS.System.IO.File.Exists(filePath) then
            error("文件不存在: " .. filePath)
        end

        local content = CS.System.IO.File.ReadAllText(filePath)
        local func = load(content)
        if not func then
            error("GlobalVariables.lua 无法解析")
        end
        local data = func()

        if data == nil then
            error("GlobalVariables.lua 返回空数据")
        end

        -- 查找并更新对应 name 的条目
        local found = false
        for _, item in ipairs(data) do
            if item.name == varName then
                local varType = item.type or "bool"
                item.value = newValue
                found = true
                break
            end
        end

        if not found then
            error("未找到变量: " .. varName)
        end

        -- 重新序列化到 GlobalVariables.lua 格式
        local sb = {}
        table.insert(sb, "local GlobalVariables = {")
        for i, item in ipairs(data) do
            local vType = item.type or "bool"
            local vStr = FormatLuaValue(item.value, vType)
            if i < #data then
                table.insert(sb, string.format('    { name = "%s", type = "%s", value = %s },',
                    tostring(item.name), vType, vStr))
            else
                table.insert(sb, string.format('    { name = "%s", type = "%s", value = %s }',
                    tostring(item.name), vType, vStr))
            end
        end
        table.insert(sb, "}")
        table.insert(sb, "return GlobalVariables")
        table.insert(sb, "")

        local newContent = table.concat(sb, "\n")
        CS.System.IO.File.WriteAllText(filePath, newContent)
        print("[ClueTrigger] ✓ 已更新 GlobalVariables.lua  -> " .. varName .. " = " .. tostring(newValue))
        return true
    end)

    if not success then
        print("[ClueTrigger] 更新失败: " .. tostring(result))
        return false
    end
    return result
end

--线索解锁脚本
---@var name :string
---@var value :bool
---@end

function Awake()
    ResetAllBoolVariablesToFalse()
end

function Start()
end

function SetClue()
    if name == nil or name == "" then
        print("[ClueTrigger] name 为空，跳过")
        return
    end
    
    local setFunc = _G["SetGlobalVar"]
    if setFunc then
        local varType = _G["GetGlobalVarType"] and _G["GetGlobalVarType"](name) or "bool"
        setFunc(name, value, varType)
        print("[ClueTrigger] ✓ 设置线索: " .. name .. " = " .. tostring(value))
    else
        print("[ClueTrigger] ✗ SetGlobalVar 不存在，请确保 GlobalVariablesManager 已初始化")
    end
end

function ResetAllBoolVariablesToFalse()
    local vars = _G["_GlobalVariables"]
    if vars then
        local setFunc = _G["SetGlobalVar"]
        for varName, varData in pairs(vars) do
            if varData.type == "bool" then
                if setFunc then
                    setFunc(varName, false, "bool")
                else
                    varData.value = false
                end
            end
        end
        print("[ClueTrigger] ✓ 已重置所有 bool 变量为 false")
    else
        print("[ClueTrigger] ✗ _GlobalVariables 不存在，请确保 GlobalVariablesManager 已初始化")
    end
end
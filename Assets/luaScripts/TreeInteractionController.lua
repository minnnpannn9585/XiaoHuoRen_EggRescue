-- 大树双阶段交互：ForceZone(1-A) / ClickZone(1-B) 按全局变量切换
---@var forceZone :UnityEngine.GameObject
---@var clickZone :UnityEngine.GameObject
---@end

local lastForceEnabled = nil
local lastClickEnabled = nil

local function GetGlobalBool(name)
    local getFunc = _G["GetGlobalVar"] or _G["GetGlobalVariable"]
    if getFunc then
        return getFunc(name) == true
    end
    local vars = _G["_GlobalVariables"]
    if vars and vars[name] then
        return vars[name].value == true
    end
    return false
end

local function GetClickInteractorScript()
    if not clickZone then
        return nil
    end
    local scripts = clickZone:GetComponents(typeof(DouyinScript))
    if scripts then
        for i = 0, scripts.Length - 1 do
            local ds = scripts[i]
            if ds and ds.script and ds.script.ButtonConfigs then
                return ds.script
            end
        end
    end
    return nil
end

-- Range 交互靠 SphereCollider + OnPlayerTriggerEnter，只关 Collider 无法撤按钮；须 DisableInteraction + SetActive(false)
local function SetClickInteractionEnabled(enabled)
    if not clickZone then
        return
    end

    if enabled then
        if not clickZone.activeSelf then
            clickZone:SetActive(true)
        end
        return
    end

    if clickZone.activeSelf then
        local interactor = GetClickInteractorScript()
        if interactor and interactor.DisableInteraction then
            interactor.DisableInteraction()
        end
        clickZone:SetActive(false)
    end
end

local function SetForceZoneEnabled(enabled)
    if not forceZone then
        return
    end
    if forceZone.activeSelf ~= enabled then
        forceZone:SetActive(enabled)
    end
end

function RefreshTreeInteraction(force)
    local summoned = GetGlobalBool("Dog_BlackCatSummoned")
    local treeHardShown = GetGlobalBool("BlackCat_TreeHardShown")

    local forceEnabled = (not summoned) and (not treeHardShown)
    local clickEnabled = (not summoned) and treeHardShown

    if not force and lastForceEnabled == forceEnabled and lastClickEnabled == clickEnabled then
        return
    end
    lastForceEnabled = forceEnabled
    lastClickEnabled = clickEnabled

    -- 先关 Click（避免与 Force 重叠时弹出「大树对话」键）
    SetClickInteractionEnabled(clickEnabled)
    SetForceZoneEnabled(forceEnabled)

    print(string.format(
        "[TreeInteraction] force=%s click=%s (TreeHardShown=%s Summoned=%s)",
        tostring(forceEnabled), tostring(clickEnabled),
        tostring(treeHardShown), tostring(summoned)))
end

function Awake()
    RefreshTreeInteraction(true)
end

function Start()
    RefreshTreeInteraction(true)
end

function Update()
    RefreshTreeInteraction(false)
end

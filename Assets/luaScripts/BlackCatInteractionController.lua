-- 黑猫显隐与可点：摇树前不可交互，摇树后可点（entry#0）
---@var catModel :UnityEngine.GameObject
---@end

local lastInteractionEnabled = nil

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

local function GetDouyinInteractorScript()
    local comp = self:GetDouyinScript("DouyinInteractor")
    if comp and comp.script then
        return comp.script
    end
    local ds = self.gameObject:GetComponent(typeof(DouyinScript))
    if ds and ds.script and ds.script.ButtonConfigs then
        return ds.script
    end
    return nil
end

local function SetInteractionEnabled(enabled)
    local interactorScript = GetDouyinInteractorScript()

    if enabled then
        if interactorScript and interactorScript.InteractionArea then
            interactorScript.InteractionArea.enabled = true
        end
        local colliders = self.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Collider))
        if colliders then
            for i = 0, colliders.Length - 1 do
                colliders[i].enabled = true
            end
        end
        if interactorScript and interactorScript.EnableInteraction then
            interactorScript.EnableInteraction()
        end
    else
        if interactorScript and interactorScript.DisableInteraction then
            interactorScript.DisableInteraction()
        end
        local colliders = self.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Collider))
        if colliders then
            for i = 0, colliders.Length - 1 do
                colliders[i].enabled = false
            end
        end
    end

    if catModel then
        catModel:SetActive(enabled)
    end
end

function RefreshBlackCatInteraction(force)
    local summoned = GetGlobalBool("Dog_BlackCatSummoned")
    local interactionEnabled = summoned

    if not force and lastInteractionEnabled == interactionEnabled then
        return
    end
    lastInteractionEnabled = interactionEnabled

    SetInteractionEnabled(interactionEnabled)
    print(string.format("[BlackCatInteraction] enabled=%s (Summoned=%s)", tostring(interactionEnabled), tostring(summoned)))
end

function Start()
    if catModel == nil and self.transform.childCount > 0 then
        catModel = self.transform:GetChild(0).gameObject
    end
    RefreshBlackCatInteraction(true)
end

function Update()
    RefreshBlackCatInteraction(false)
end

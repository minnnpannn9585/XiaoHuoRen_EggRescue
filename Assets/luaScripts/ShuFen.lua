---@var henModel :UnityEngine.GameObject
---@var gateBlockCollider :UnityEngine.Collider
---@end

-- 委托前「淑芬」与委托后「淑芬2」：Shufen_CommissionDone 切换交互点

local lastSpotEnabled = nil
local lastCommissionDone = nil

local function IsHubSpot()
    return self.gameObject.name == "淑芬2"
end

local function GetCommissionDone()
    local getFunc = _G["GetGlobalVar"] or _G["GetGlobalVariable"]
    if getFunc then
        return getFunc("Shufen_CommissionDone") == true
    end
    local globalVars = _G["_GlobalVariables"]
    if globalVars and globalVars["Shufen_CommissionDone"] then
        return globalVars["Shufen_CommissionDone"].value == true
    end
    return false
end

local function GetDouyinInteractorScript()
    local comp = self:GetDouyinScript("DouyinInteractor")
    if comp and comp.script then
        return comp.script
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

        local playParticle = _G["PlayParticle"]
        if playParticle then
            playParticle("vfx_characterChange", self.transform.position)
        end
    end

    if henModel then
        henModel:SetActive(enabled)
    end
end

local function UpdateGateBlockCollider(commissionDone)
    if not gateBlockCollider then
        return
    end
    gateBlockCollider.enabled = not commissionDone
end

function CheckShufenState()
    local commissionDone = GetCommissionDone()
    local hubSpot = IsHubSpot()
    local spotEnabled = hubSpot and commissionDone or (not hubSpot and not commissionDone)

    if lastCommissionDone ~= commissionDone then
        lastCommissionDone = commissionDone
        UpdateGateBlockCollider(commissionDone)
    end

    if lastSpotEnabled == spotEnabled then
        return
    end
    lastSpotEnabled = spotEnabled

    SetInteractionEnabled(spotEnabled)
end

function Start()
    if henModel == nil and self.transform.childCount > 0 then
        henModel = self.transform:GetChild(0).gameObject
    end
    CheckShufenState()
end

function Update()
    CheckShufenState()
end

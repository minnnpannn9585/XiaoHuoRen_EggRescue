---@var sleepDog :UnityEngine.GameObject
---@var soberDog :UnityEngine.GameObject
---@end

-- 谷仓「大黄」与红顶「大黄 2」：DogStatus 控制睡/醒模型；DogStatus>=4 切换交互点

local lastSpotEnabled = nil
local lastAwake = nil

local function IsRedRoofSpot()
    return self.gameObject.name == "大黄 2"
end

local function GetDogStatus()
    local getFunc = _G["GetGlobalVar"] or _G["GetGlobalVariable"]
    if getFunc then
        return tonumber(getFunc("DogStatus")) or 1
    end
    local globalVars = _G["_GlobalVariables"]
    if globalVars and globalVars["DogStatus"] then
        return tonumber(globalVars["DogStatus"].value) or 1
    end
    return 1
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
    end
end

local function ApplyAwakeModels(isAwake)
    if sleepDog then
        sleepDog:SetActive(not isAwake)
        local playParticle = _G["PlayParticle"]
        if playParticle and sleepDog then
            playParticle("vfx_characterChange", sleepDog.transform.position)
        end
    end
    if soberDog then
        soberDog:SetActive(isAwake)
    end
end

local function HideAllModels()
    if sleepDog then sleepDog:SetActive(false) end
    if soberDog then soberDog:SetActive(false) end
end

function CheckDogState()
    local dogStatus = GetDogStatus()
    local isChapter2 = dogStatus >= 4
    local redRoof = IsRedRoofSpot()
    local spotEnabled = redRoof and isChapter2 or (not redRoof and not isChapter2)
    local isAwake = dogStatus >= 3

    if lastSpotEnabled == spotEnabled and lastAwake == isAwake then
        return
    end
    lastSpotEnabled = spotEnabled
    lastAwake = isAwake

    SetInteractionEnabled(spotEnabled)

    if not spotEnabled then
        HideAllModels()
        return
    end

    if redRoof then
        ApplyAwakeModels(true)
    else
        ApplyAwakeModels(isAwake)
    end
end

function Start()
    CheckDogState()
end

function Update()
    CheckDogState()
end

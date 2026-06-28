---@var sleepDog :UnityEngine.GameObject
---@var soberDog :UnityEngine.GameObject
---@var ladder :UnityEngine.GameObject
--
local lastBorrowed = nil

function Start()
    CheckDogState()
end

function Update()
    CheckDogState()
end

function CheckDogState()
    local isBorrowed = false
    local getFunc = _G["GetGlobalVar"] or _G["GetGlobalVariable"]
    if getFunc then
        isBorrowed = getFunc("E06_LadderBorrowed")
    else
        local globalVars = _G["_GlobalVariables"]
        if globalVars and globalVars["E06_LadderBorrowed"] then
            isBorrowed = globalVars["E06_LadderBorrowed"].value
        end
    end

    if type(isBorrowed) == "number" then
        isBorrowed = (isBorrowed ~= 0)
    elseif type(isBorrowed) == "string" then
        isBorrowed = (isBorrowed == "true" or isBorrowed == "1")
    end

    if lastBorrowed == isBorrowed then
        return
    end
    lastBorrowed = isBorrowed

    if sleepDog then
        sleepDog:SetActive(not isBorrowed)
        ladder:SetActive(not isBorrowed)
    end
    if soberDog then
        soberDog:SetActive(isBorrowed)
    end
end

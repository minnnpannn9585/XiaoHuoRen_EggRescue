-- C01/C02 奶酪碎碰撞拾取（doc 13 §13.5）
---@var pickupId :string
---@var amount :int = 1
---@var requiresNGPlus :bool = false
---@var visualRoot :UnityEngine.GameObject
---@end

if _G._CheesePickupState == nil then
    _G._CheesePickupState = {}
end

local function GetPickupId()
    if pickupId and pickupId ~= "" then
        return pickupId
    end
    local parent = self.transform.parent
    if parent and parent.parent and parent.parent.name == "奶酪散点" then
        return parent.name
    end
    return self.gameObject.name
end

local function GetGlobalBool(name)
    local getFunc = _G["GetGlobalVar"]
    return getFunc and getFunc(name) == true
end

local function IsPicked()
    return _G._CheesePickupState[GetPickupId()] == true
end

local function SetPickedState(picked)
    local id = GetPickupId()
    if picked then
        _G._CheesePickupState[id] = true
    else
        _G._CheesePickupState[id] = nil
    end
end

local function ApplyVisibility()
    local ngOk = not requiresNGPlus or GetGlobalBool("NGPlus")
    local available = ngOk and not IsPicked()
    local root = visualRoot or self.gameObject
    if root then
        root:SetActive(available)
    end
    local col = self.gameObject:GetComponent(typeof(CS.UnityEngine.Collider))
    if col then
        col.enabled = available
    end
end

function TryPickup()
    if IsPicked() then
        return
    end
    if requiresNGPlus and not GetGlobalBool("NGPlus") then
        return
    end

    local add = amount or 1
    local getFunc = _G["GetGlobalVar"]
    local setFunc = _G["SetGlobalVar"]
    if not getFunc or not setFunc then
        print("[CheesePickup] SetGlobalVar 未就绪")
        return
    end

    local current = tonumber(getFunc("CheeseCount")) or 0
    setFunc("CheeseCount", current + add, "int")
    SetPickedState(true)

    if _G["OnCheeseCountChanged"] then
        _G["OnCheeseCountChanged"]()
    end
    if _G["MouseBrother_RefreshDerivedFlags"] then
        _G["MouseBrother_RefreshDerivedFlags"]()
    end

    print(string.format("[CheesePickup] %s +%d => CheeseCount=%d",
        GetPickupId(), add, current + add))

    UnityEngine.Object.Destroy(self.gameObject)
end

function OnPlayerTriggerEnter(douyinPlayer)
    if douyinPlayer == nil then
        return
    end
    local actor = douyinPlayer:GetActor()
    if actor == nil or actor.isLocal ~= true then
        return
    end
    TryPickup()
end

function Start()
    if IsPicked() then
        UnityEngine.Object.Destroy(self.gameObject)
        return
    end
    ApplyVisibility()
end

-- HUD：奶酪碎计数（doc 11）
---@var countText :UnityEngine.UI.Text
---@end

local function GetCheeseCount()
    local getFunc = _G["GetGlobalVar"]
    if getFunc then
        return tonumber(getFunc("CheeseCount")) or 0
    end
    return 0
end

function RefreshCheeseHud()
    local count = GetCheeseCount()
    if countText then
        countText.text = tostring(count)
    end
end

function OnCheeseCountChanged()
    RefreshCheeseHud()
end

function Start()
    _G["CheeseHud_Refresh"] = RefreshCheeseHud
    _G["OnCheeseCountChanged"] = OnCheeseCountChanged
    RefreshCheeseHud()
end

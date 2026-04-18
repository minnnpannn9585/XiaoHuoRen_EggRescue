---@var light:UnityEngine.GameObject
---@end

function SwitchLight()
    light:SetActive(not(light.activeSelf))
end

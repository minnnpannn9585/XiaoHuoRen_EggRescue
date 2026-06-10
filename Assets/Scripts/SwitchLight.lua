

-- Start is called before the first frame update
function Start()
    
end

---@var light:UnityEngine.GameObject
---@end

function SwitchLight()
    light:SetActive(not(light.activeSelf))
end

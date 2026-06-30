-- 游戏开始后按子节点空 Transform 生成奶酪拾取 prefab
---@var cheesePrefab :UnityEngine.GameObject
---@end

local function ClearMarkerPickups(marker)
    for i = marker.childCount - 1, 0, -1 do
        local child = marker:GetChild(i)
        if child then
            UnityEngine.Object.Destroy(child.gameObject)
        end
    end
end

local function IsMarkerAvailable(markerName)
    if _G._CheesePickupState and _G._CheesePickupState[markerName] == true then
        return false
    end
    return true
end

function Start()
    local markerRoot = self.transform

    local function SpawnAll()
        if cheesePrefab == nil then
            print("[CheeseSpawner] cheesePrefab 未绑定")
            return
        end

        for i = 0, markerRoot.childCount - 1 do
            local marker = markerRoot:GetChild(i)
            ClearMarkerPickups(marker)
            if not IsMarkerAvailable(marker.name) then
                goto continue
            end

            local go = UnityEngine.GameObject.Instantiate(cheesePrefab, marker)
            go.name = "Pickup"
            go.transform.localPosition = CS.UnityEngine.Vector3.zero
            go.transform.localRotation = CS.UnityEngine.Quaternion.identity
            go.transform.localScale = CS.UnityEngine.Vector3.one

            ::continue::
        end
    end

    _G["CheeseSpawner_Respawn"] = SpawnAll
    SpawnAll()
end

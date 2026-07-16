-- 进入 Trigger 区域后强制播放 NPC 对话（不需按交互键）
---@var npcName :string
---@var startNodeId :int
---@var requireVarName :string
---@var requireVarMustBe :bool
---@var blockVarName :string
---@var blockWhenTrue :bool
---@var disableColliderAfterFire :bool
---@var skipIfDialogueActive :bool
---@end

local fired = false

local function GetGlobalBool(name)
    if not name or name == "" then
        return nil
    end
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

local function IsDialogueActive()
    local mgr = _G["_DialogueManager"]
    if mgr and mgr.IsDialogueActive then
        return mgr.IsDialogueActive()
    end
    return false
end

local function DisableSelfCollider()
    local col = self.gameObject:GetComponent(typeof(CS.UnityEngine.Collider))
    if col then
        col.enabled = false
    end
end

function TryFireDialogue()
    if fired then
        return
    end

    if skipIfDialogueActive ~= false and IsDialogueActive() then
        return
    end

    if requireVarName and requireVarName ~= "" then
        local actual = GetGlobalBool(requireVarName)
        local expected = requireVarMustBe == true
        if actual ~= expected then
            return
        end
    end

    if blockVarName and blockVarName ~= "" then
        local blocked = GetGlobalBool(blockVarName)
        if blockWhenTrue ~= false and blocked then
            return
        end
        if blockWhenTrue == false and not blocked then
            return
        end
    end

    local startFn = _G.StartNpcDialogue
    if not startFn then
        print("[DialogueAreaTrigger] StartNpcDialogue 未注册")
        return
    end

    fired = true
    if disableColliderAfterFire ~= false then
        DisableSelfCollider()
    end

    startFn(npcName, startNodeId or 1)
end

function OnPlayerTriggerEnter(douyinPlayer)
    if douyinPlayer == nil then
        return
    end
    local actor = douyinPlayer:GetActor()
    if actor == nil or actor.isLocal ~= true then
        return
    end
    TryFireDialogue()
end

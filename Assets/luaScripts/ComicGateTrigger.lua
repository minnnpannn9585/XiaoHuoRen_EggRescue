-- E20 · 红顶屋二层窗漫画收束占位
-- 完整漫画流程待接；当前仅写 Comic_Revealed 并播占位对白

---@var placeholderDialogueId :int = 600
---@end

local PLACEHOLDER_DIALOGUE = "（漫画收束演出占位——真相即将揭晓。）"

local function SetGlobalBool(name, value)
    local setFunc = _G["SetGlobalVar"]
    if setFunc then
        setFunc(name, value, "bool")
    end
end

local function GetGlobalBool(name)
    local getFunc = _G["GetGlobalVar"]
    if getFunc then
        return getFunc(name) == true
    end
    return false
end

local function LoadMiaosuDialogue()
    local dialogueDataGo = CS.UnityEngine.GameObject.Find("DialogueData")
    if not dialogueDataGo then
        return nil
    end
    local childTransform = dialogueDataGo.transform:Find("miaosu")
    if not childTransform then
        return nil
    end
    local douyinScript = childTransform.gameObject:GetComponent(typeof(DouyinScript))
    if not douyinScript or not douyinScript.script then
        return nil
    end
    if douyinScript.script.DialogueConfig then
        return douyinScript.script.DialogueConfig
    end
    return douyinScript.script
end

local function PlayPlaceholderDialogue()
    local mgr = _G["_DialogueManager"]
    if not mgr or not mgr.StartDialogueWithData then
        print("[ComicGate] " .. PLACEHOLDER_DIALOGUE)
        return
    end

    local data = LoadMiaosuDialogue()
    local startId = placeholderDialogueId or 600
    if data and data[startId] then
        mgr.StartDialogueWithData(data, startId)
        return
    end

    -- 内联兜底：miaosu 未配 600 时仍给一句反馈
    local fallback = {
        [600] = {
            Type = "Normal",
            NpcName = "描述",
            NpcSprite = "",
            Dialogue = PLACEHOLDER_DIALOGUE,
            Next = -1
        }
    }
    mgr.StartDialogueWithData(fallback, 600)
end

function OnComicInteract()
    if GetGlobalBool("Comic_Revealed") then
        print("[ComicGate] 漫画已收束，忽略重复点击")
        return
    end

    SetGlobalBool("Comic_Revealed", true)
    SetGlobalBool("NGPlus", true)
    if _G["CheeseRefresh_OnNGPlus"] then
        _G["CheeseRefresh_OnNGPlus"]()
    end
    print("[ComicGate] Comic_Revealed = true, NGPlus = true")
    PlayPlaceholderDialogue()
end

function Start()
    _G["ComicGate_OnInteract"] = function()
        OnComicInteract()
    end
end

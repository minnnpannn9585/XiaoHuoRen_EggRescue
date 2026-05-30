--开始对话的ID
---@var ID :int
---@end

function Start()
    if _G["_DialogueManager"]==nil then
        logError("场景中缺少DialogueManager预制件")
    end
end

--开始对话
function StartDialogue()
    _G["_DialogueManager"].StartDialogue(ID)
end

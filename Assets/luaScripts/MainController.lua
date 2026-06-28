-- 定义计时相关变量（放在函数外部，作为脚本成员变量）wa
-- Unity 启动入口
function Start()
end

-- Unity 每一帧都会调用 Update
function Update()
    DouyinUIService.GetInteractionButton(HandType.Right, UIType.Fly).gameObject:SetActive(false)
    OnChatClose()
end

function OnChatClose()
    local ui = UnityEngine.GameObject.Find("UISystem")
    if ui ~= nil then
        local chat = ui.transform:Find("Canvas/UIRoot/Bottom/MainInputPanel(Clone)/ObserverNotHideLayer")
        if chat ~= nil then
            chat.gameObject:SetActive(false)
        end
    end
end

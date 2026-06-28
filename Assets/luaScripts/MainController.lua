-- 定义计时相关变量（放在函数外部，作为脚本成员变量）
local delayTime = 10.0  -- 延迟秒数
local currentTime = 0
local isWaiting = false -- 是否正在等待倒计时
local hasClosed = false -- 防止重复关闭

-- 延迟后执行的操作
function OnDelayedClose()
    DouyinUIService.GetInteractionButton(HandType.Right, UIType.Fly).gameObject:SetActive(false)
    OnChatClose()
    print("DouyinUIService")
end

-- Unity 每一帧都会调用 Update
function Update()
    if not hasClosed then
        local flyBtn = DouyinUIService.GetInteractionButton(HandType.Right, UIType.Fly)
        if flyBtn and flyBtn.gameObject and flyBtn.gameObject.activeSelf then
            hasClosed = true
            OnDelayedClose()
        end
    end

    if isWaiting then
        currentTime = currentTime - UnityEngine.Time.deltaTime
        if currentTime <= 0 then
            isWaiting = false
            OnDelayedClose()
        end
    end
end

function OnChatClose()
    local ui = UnityEngine.GameObject.Find("UISystem")
    if ui ~= nil then
        local chat = ui.transform:Find("Canvas/UIRoot/Bottom/MainInputPanel(Clone)/ObserverNotHideLayer")
        if chat ~= nil then
            -- 注意：这里原本的 active 未定义，改为 false 表示隐藏
            chat.gameObject:SetActive(false)
        end
    end
end

---@var open :UnityEngine.UI.Button
---@var boolPanel :UnityEngine.GameObject
---@var leftBtn :UnityEngine.UI.Button
---@var rightBtn :UnityEngine.UI.Button
---@var pageContents :UnityEngine.GameObject[]

local currentIndex = 1

function Start()
    DouyinUIService.GetInteractionButton(HandType.Right, UIType.Fly).gameObject:SetActive(false)
    boolPanel:SetActive(false)
    open.onClick:AddListener(OnOpenClick)
    leftBtn.onClick:AddListener(OnLeftClick)
    rightBtn.onClick:AddListener(OnRightClick)

    HideAllPages()
    if pageContents and pageContents.Length > 0 then
        pageContents[currentIndex - 1]:SetActive(true)
    end
end

function OnOpenClick()
    boolPanel:SetActive(not boolPanel.activeSelf)
    if boolPanel.activeSelf then
        HideAllPages()
        if pageContents and pageContents.Length > 0 then
            pageContents[currentIndex - 1]:SetActive(true)
        end
    end
end

function OnLeftClick()
    if not pageContents or pageContents.Length == 0 then return end
    currentIndex = currentIndex - 1
    if currentIndex < 1 then
        currentIndex = pageContents.Length
    end
    HideAllPages()
    pageContents[currentIndex - 1]:SetActive(true)
end

function OnRightClick()
    if not pageContents or pageContents.Length == 0 then return end
    currentIndex = currentIndex + 1
    if currentIndex > pageContents.Length then
        currentIndex = 1
    end
    HideAllPages()
    pageContents[currentIndex - 1]:SetActive(true)
end

function HideAllPages()
    if not pageContents then return end
    for i = 0, pageContents.Length - 1 do
        pageContents[i]:SetActive(false)
    end
end

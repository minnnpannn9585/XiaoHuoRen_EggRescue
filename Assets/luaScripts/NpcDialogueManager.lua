--对话配置文件
---@var dialoguePanel :UnityEngine.GameObject
---@var playerNamePanel :UnityEngine.GameObject
---@var npcNamePanel :UnityEngine.GameObject
---@var npcName :UnityEngine.UI.Text
---@var npcSprite :UnityEngine.UI.Image
---@var npcDialogueText :UnityEngine.UI.Text
---@var next :UnityEngine.UI.Button
---@var playerPanel :UnityEngine.GameObject
---@var playerPanelBtn :UnityEngine.UI.Button
---@var Sprites :UnityEngine.Sprite[]
---@end

local dialogueManager = {}

-- 私有变量
local currentDialogueID = -1
local allSprites = {}
local isWaitingForChoice = false
local currentOptions = {}
local optionButtons = {}

-- 打字机效果相关变量
local typingSpeed = 0.05
local isTyping = false
local typingTimer = 0
local currentTypingIndex = 0
local fullDialogueText = ""
local currentDataCache = nil

-- 选项逐个显示动画相关变量
local isAnimatingOptions = false
local optionAnimationTimer = 0
local currentAnimatingOptionIndex = 0
local optionAnimationSpeed = 0.2

-- ========== 新增：选项点击后暂存与等待 Next 状态 ==========
local selectedOptionCache = nil      -- 缓存玩家选择的选项
local isWaitingForNextAfterOption = false   -- 是否正在等待点击 Next 以完成选项跳转

-- ========== 新增：外部动态加载的对话配置 ==========
local externalDialogueConfig = nil   -- 动态加载的外部对话数据

function Awake()
    _G["_DialogueManager"] = self.script
    dialogueManager = self.script

    if Sprites then
        for i = 1, Sprites.Length do
            if Sprites[i-1] then
                allSprites[Sprites[i-1].name] = Sprites[i-1]
            end
        end
    end

    if dialoguePanel then
        dialoguePanel:SetActive(false)
    end
    if playerPanel then
        playerPanel:SetActive(false)
    end
    if playerNamePanel then
        playerNamePanel:SetActive(false)
    end

    if next then
        next.onClick:AddListener(OnNextClick)
        next.gameObject:SetActive(false)
    end

    if dialoguePanel then
        local panelBtn = dialoguePanel:GetComponent(typeof(UnityEngine.UI.Button))
        if not panelBtn then
            panelBtn = dialoguePanel:AddComponent(typeof(UnityEngine.UI.Button))
        end
        panelBtn.onClick:AddListener(OnNextClick)
    end

    if playerPanelBtn then
        playerPanelBtn.gameObject:SetActive(false)
    end
end

function Start()
    -- StartDialogue(1)
end

function GetDialogueData(id)
    if externalDialogueConfig and externalDialogueConfig[id] ~= nil then
        return externalDialogueConfig[id]
    end
    return nil
end

function StartDialogue(dialogueID)
    if GetDialogueData(dialogueID) == nil then
        DouyinUtility.Toast("对话id出现配置错误，请检查～")
        return
    end
    SetPlayerNamePanel(false)
    currentDialogueID = dialogueID
    if dialoguePanel then
        dialoguePanel:SetActive(true)
    end

    DouyinUIService.SetUIVisible(false)

    UpdateDialogueUI()
end

function StartDialogueWithData(dialogueData, startID)
    externalDialogueConfig = dialogueData
    local actualID = startID or 1
    if GetDialogueData(actualID) == nil then
        for k, v in pairs(dialogueData) do
            actualID = k
            break
        end
    end
    if GetDialogueData(actualID) == nil then
        DouyinUtility.Toast("对话数据为空～")
        return
    end
    SetPlayerNamePanel(false)
    currentDialogueID = actualID
    if dialoguePanel then
        dialoguePanel:SetActive(true)
    end
    DouyinUIService.SetUIVisible(false)
    UpdateDialogueUI()
end

function OnNextClick()
    -- 如果选项正在动画显示中...
    if isAnimatingOptions then
        CompleteOptionAnimation()
        return
    end

    if isWaitingForChoice then
        return
    end

    if isTyping then
        CompleteTypingEffect()
        return
    end

    -- 处理选项完成后的 Next 点击
    if isWaitingForNextAfterOption and selectedOptionCache then
        if next then
            next.gameObject:SetActive(false)
        end
        -- 切换回 NPC 名字面板
        SetPlayerNamePanel(false)   -- 显示NPC名字，隐藏玩家名字
        -- 执行选项跳转
        PerformOptionJump(selectedOptionCache)
        selectedOptionCache = nil
        isWaitingForNextAfterOption = false
        return
    end

    -- 普通对话的 Next 逻辑...
    local currentData = GetDialogueData(currentDialogueID)
    if currentData == nil then
        DouyinUtility.Toast("当前对话数据不存在～")
        EndDialogue()
        return
    end

    local nextID = currentData.Next
    if nextID == -1 then
        EndDialogue()
    elseif GetDialogueData(nextID) ~= nil then
        currentDialogueID = nextID
        UpdateDialogueUI()
    else
        DouyinUtility.Toast("对话配置错误，下一段对话不存在～")
        EndDialogue()
    end
end

function UpdateDialogueUI()
    local data = GetDialogueData(currentDialogueID)
    if data == nil then
        DouyinUtility.Toast("对话数据加载失败～")
        EndDialogue()
        return
    end

    currentDataCache = data

    if next then
        next.gameObject:SetActive(false)
    end
    if playerPanel then
        playerPanel:SetActive(false)
    end
    ClearOptionButtons()

    UpdateNPCInfo(data)
end

function UpdateNPCInfo(data)
    if npcName then
        npcName.text = data.NpcName or ""
    end

    if npcSprite then
        if data.NpcSprite and allSprites[data.NpcSprite] then
            npcSprite.sprite = allSprites[data.NpcSprite]
            npcSprite.gameObject:SetActive(true)
        else
            npcSprite.gameObject:SetActive(false)
        end
    end

    if npcDialogueText then
        fullDialogueText = data.Dialogue or ""
        StartTypingEffect()
    end
end

function StartTypingEffect()
    isTyping = true
    typingTimer = 0
    currentTypingIndex = 0
    npcDialogueText.text = ""
end

function CompleteTypingEffect()
    isTyping = false
    npcDialogueText.text = fullDialogueText

    if isWaitingForNextAfterOption then
        -- 选项文本播放完成：切换到玩家名字面板，显示 Next 按钮
        SetPlayerNamePanel(true)   -- 显示玩家名字，隐藏NPC名字
        if next then
            next.gameObject:SetActive(true)
            next.interactable = true
        end
    elseif currentDataCache then
        if currentDataCache.Type == "Question" then
            ShowQuestionUI(currentDataCache)
        else
            ShowNPCConversationUI(currentDataCache)
        end
    end
end

function CompleteOptionAnimation()
    isAnimatingOptions = false
    if optionButtons then
        for i, btn in ipairs(optionButtons) do
            if btn and btn.gameObject then
                btn.gameObject:SetActive(true)
            end
        end
    end
end

function Update()
    if isTyping then
        typingTimer = typingTimer + UnityEngine.Time.deltaTime
        if typingTimer >= typingSpeed then
            typingTimer = 0
            currentTypingIndex = currentTypingIndex + 1

            local textLen = utf8.len(fullDialogueText)
            if currentTypingIndex <= textLen then
                local byteStart = utf8.offset(fullDialogueText, 1)
                local byteEnd = utf8.offset(fullDialogueText, currentTypingIndex + 1) - 1
                npcDialogueText.text = string.sub(fullDialogueText, byteStart, byteEnd)
            else
                CompleteTypingEffect()
            end
        end
    end

    if isAnimatingOptions then
        optionAnimationTimer = optionAnimationTimer + UnityEngine.Time.deltaTime
        if optionAnimationTimer >= optionAnimationSpeed then
            optionAnimationTimer = 0
            currentAnimatingOptionIndex = currentAnimatingOptionIndex + 1

            if optionButtons and currentAnimatingOptionIndex <= #optionButtons then
                local btn = optionButtons[currentAnimatingOptionIndex]
                if btn and btn.gameObject then
                    btn.gameObject:SetActive(true)
                end
            else
                isAnimatingOptions = false
            end
        end
    end
end

function ShowNPCConversationUI(data)
    isWaitingForChoice = false

    if playerPanel then
        playerPanel:SetActive(false)
    end
    ClearOptionButtons()

    -- 显示NPC名字，隐藏玩家名字
    SetPlayerNamePanel(false)

    if next then
        next.gameObject:SetActive(true)
        next.interactable = true
    end
end

function ShowQuestionUI(data)
    isWaitingForChoice = true

    if next then
        next.gameObject:SetActive(false)
    end

    if playerPanel then
        playerPanel:SetActive(true)
    end

    if playerNamePanel then
        playerNamePanel:SetActive(true)
    end

    if npcNamePanel then
        npcNamePanel:SetActive(false)
    end

    currentOptions = data.Options or {}

    if #currentOptions == 0 then
        DouyinUtility.Toast("提问模式缺少选项配置～")
        EndDialogue()
        return
    end

    GenerateOptionButtons()
end

function ClearOptionButtons()
    if optionButtons then
        for i, btn in ipairs(optionButtons) do
            if btn and btn.gameObject then
                UnityEngine.GameObject.Destroy(btn.gameObject)
            end
        end
        optionButtons = {}
    end
end

function GenerateOptionButtons()
    if not playerPanel then
        DouyinUtility.Toast("玩家选项面板不存在～")
        return
    end

    if not playerPanelBtn then
        DouyinUtility.Toast("玩家选项按钮预制体不存在～")
        return
    end

    ClearOptionButtons()

    local templateRect = playerPanelBtn:GetComponent(typeof(UnityEngine.RectTransform))
    local buttonHeight = 80
    if templateRect then
        buttonHeight = templateRect.rect.height
    end

    local totalHeight = #currentOptions * buttonHeight
    local startY = totalHeight / 2 - buttonHeight / 2

    for i, option in ipairs(currentOptions) do
        local btnObj = UnityEngine.GameObject.Instantiate(playerPanelBtn.gameObject, playerPanel.transform)
        btnObj:SetActive(false)

        local btnText = btnObj:GetComponentInChildren(typeof(UnityEngine.UI.Text))
        if btnText then
            btnText.text = option.Text
        else
            DouyinUtility.Toast("按钮文本组件不存在～")
        end

        local rect = btnObj:GetComponent(typeof(UnityEngine.RectTransform))
        if rect then
            local yPos = startY - (i - 1) * buttonHeight
            rect.anchoredPosition = UnityEngine.Vector2(0, yPos)
        end

        local btn = btnObj:GetComponent(typeof(UnityEngine.UI.Button))
        if btn then
            local capturedOption = option
            btn.onClick:AddListener(function()
                OnOptionSelected(capturedOption)
            end)
        end

        table.insert(optionButtons, btnObj)
    end

    isAnimatingOptions = true
    optionAnimationTimer = 0
    currentAnimatingOptionIndex = 0
end

-- ========== 修改：选项点击后先显示选项文字，再等待 Next ==========
function OnOptionSelected(option)
    if not isWaitingForChoice then
        return
    end

    -- 清除等待选项状态，隐藏选项按钮面板（但保留当前名字面板状态，不立即切换）
    isWaitingForChoice = false
    if playerPanel then
        playerPanel:SetActive(false)   -- 隐藏选项按钮容器
    end
    ClearOptionButtons()

    -- 缓存选中的选项，标记为等待 Next 状态
    selectedOptionCache = option
    isWaitingForNextAfterOption = true

    -- 将选项文本作为对话内容，开始打字机效果
    fullDialogueText = option.Text
    StartTypingEffect()
end

function SetPlayerNamePanel(active)
    if playerNamePanel then
        playerNamePanel:SetActive(active)
    end
    if npcNamePanel then
        npcNamePanel:SetActive(not active)
    end
end

-- ========== 新增：执行选项的实际分支跳转逻辑 ==========
function PerformOptionJump(option)
    if option.BranchFlag then
        SaveBranchFlag(option.BranchFlag)
    end

    local nextID = option.Next

    if nextID == -1 then
        EndDialogue()
    elseif GetDialogueData(nextID) ~= nil then
        currentDialogueID = nextID
        UpdateDialogueUI()
    else
        DouyinUtility.Toast("选项配置错误，下一段对话不存在～")
        EndDialogue()
    end
end

function SaveBranchFlag(flag)
    local actor = DouyinActorService.GetLocalActor()
    if actor then
        actor:SetActorTag("Branch_" .. flag, "true")
    end

    _G["DialogueBranch_" .. flag] = true
end

function CheckBranchFlag(flag)
    local actor = DouyinActorService.GetLocalActor()
    if actor then
        local value = actor:GetActorTag("Branch_" .. flag)
        return value == "true"
    end
    return _G["DialogueBranch_" .. flag] == true
end

-- ========== 修改：结束对话时重置新增的状态变量 ==========
function EndDialogue()
    currentDialogueID = -1
    isWaitingForChoice = false
    isTyping = false
    isAnimatingOptions = false
    isWaitingForNextAfterOption = false
    selectedOptionCache = nil
    externalDialogueConfig = nil

    if dialoguePanel then
        dialoguePanel:SetActive(false)
    end
    if playerPanel then
        playerPanel:SetActive(false)
    end
    if next then
        next.gameObject:SetActive(false)
    end

    ClearOptionButtons()
    DouyinUIService.SetUIVisible(true)
end

function dialogueManager.StartDialogue(dialogueID)
    StartDialogue(dialogueID)
end

function dialogueManager.StartDialogueWithData(dialogueData, startID)
    StartDialogueWithData(dialogueData, startID)
end

function dialogueManager.EndDialogue()
    EndDialogue()
end

function dialogueManager.CheckBranch(flag)
    return CheckBranchFlag(flag)
end
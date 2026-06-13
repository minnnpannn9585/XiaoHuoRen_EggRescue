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
local npcConfigPath = "Assets/Editor/EidtData/NPCData_Config.lua"  -- NPC 配置文件路径
local globalVariablesPath = "Assets/Editor/EidtData/GlobalVariables.lua"  -- 全局变量文件路径
local unlockedBranchCache = {}  -- 已处理过的分支缓存，防止同一节点重复解锁

-- ========== 新增：全局变量表（用于条件分支判断） ==========
local globalVariables = {}   -- 全局变量存储，支持 bool 和 int 类型

-- 获取项目根目录
local function GetProjectPath()
    local dataPath = CS.UnityEngine.Application.dataPath
    local projectPath = dataPath
    if dataPath:find("DouyinWorldDebugger") or dataPath:find("_Data") then
        local parts = {}
        for part in dataPath:gmatch("[^/\\]+") do
            table.insert(parts, part)
        end
        if #parts >= 2 then
            local newParts = {}
            for i = 1, #parts - 2 do
                table.insert(newParts, parts[i])
            end
            projectPath = table.concat(newParts, "/")
        else
            projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../../")
        end
    else
        projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../")
    end
    return projectPath
end

-- 从 GlobalVariables.lua 文件重新加载全局变量（每次条件判断前调用一次，确保是最新值）
function ReloadGlobalVariablesFromFile()
    local success, err = pcall(function()
        local projectPath = GetProjectPath()
        local fullPath = CS.System.IO.Path.Combine(projectPath, globalVariablesPath)
        if not CS.System.IO.File.Exists(fullPath) then
            return
        end
        local content = CS.System.IO.File.ReadAllText(fullPath)
        local func = load(content)
        if not func then return end
        local data = func()
        if data == nil then return end

        local freshVars = {}
        for _, item in ipairs(data) do
            if item.name and item.type then
                if item.type == "bool" then
                    freshVars[item.name] = { type = "bool", value = (item.value == true or item.value == "true" or item.value == 1) }
                else
                    freshVars[item.name] = { type = "int", value = tonumber(item.value) or 0 }
                end
            end
        end
        globalVariables = freshVars
    end)
    if not success then
        print("[ReloadGlobalVariables] 读取失败: " .. tostring(err))
    end
end

-- 设置全局变量
function SetGlobalVariable(varName, value, varType)
    if varName == nil or varName == "" then return end
    varType = varType or "bool"
    if varType == "bool" then
        globalVariables[varName] = { type = "bool", value = (value == true or value == "true" or value == 1) }
    else
        globalVariables[varName] = { type = "int", value = tonumber(value) or 0 }
    end
end

-- 获取全局变量值
function GetGlobalVariable(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].value
end

-- 获取全局变量类型
function GetGlobalVariableType(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].type
end

-- 打印所有全局变量（调试用）
function PrintGlobalVariables()
    print("===== 全局变量表 =====")
    for k, v in pairs(globalVariables) do
        print("  [" .. k .. "] type=" .. tostring(v.type) .. ", value=" .. tostring(v.value))
    end
    print("=====================")
end

-- 根据条件分支计算下一个节点 ID
function GetNextNodeByCondition(data)
    -- 每次条件判断前，重新从 GlobalVariables.lua 读取最新值
    ReloadGlobalVariablesFromFile()

    if data == nil or data.ConditionBranches == nil or #data.ConditionBranches == 0 then
        return nil
    end
    for i, cb in ipairs(data.ConditionBranches) do
        if cb.VarName ~= nil and cb.VarName ~= "" then
            local varType = cb.VarType or "bool"
            local varValue = GetGlobalVariable(cb.VarName)

            if varType == "bool" then
                -- bool 模式：true/false 各走一个分支；未设置的变量视为 false
                --   true  → TrueNext
                --   false/nil → FalseNext
                if varValue == true and cb.TrueNext ~= nil and cb.TrueNext > 0 then
                    return cb.TrueNext
                elseif (varValue == false or varValue == nil) and cb.FalseNext ~= nil and cb.FalseNext > 0 then
                    return cb.FalseNext
                end
            else
                -- int 模式：用操作符比较；未设置的变量视为 0
                local op = cb.Op or "=="
                local cmpValue = tonumber(cb.Value) or 0
                local intVal = tonumber(varValue) or 0
                local match = false
                if op == "==" then match = (intVal == cmpValue)
                elseif op == "!=" then match = (intVal ~= cmpValue)
                elseif op == ">" then match = (intVal > cmpValue)
                elseif op == "<" then match = (intVal < cmpValue)
                elseif op == ">=" then match = (intVal >= cmpValue)
                elseif op == "<=" then match = (intVal <= cmpValue)
                end
                if match and cb.Next ~= nil and cb.Next > 0 then
                    return cb.Next
                end
            end
        end
    end
    return nil  -- 没有任何条件分支匹配
end

-- ========== 新增：NPC 分支解锁（将 NPC 的 currentBranchId ==========
-- 功能：当执行到带有 UnlockBranchId 的节点时，修改 NPCData_Config.lua 中的 currentBranchId

-- ========== 与 DialogueTrigger 保持一致的项目路径计算 ==========
function GetProjectPath_DM()
    local dataPath = CS.UnityEngine.Application.dataPath
    local projectPath = dataPath

    if dataPath:find("DouyinWorldDebugger") or dataPath:find("_Data") then
        local parts = {}
        for part in dataPath:gmatch("[^/\\]+") do
            table.insert(parts, part)
        end
        if #parts >= 2 then
            local newParts = {}
            for i = 1, #parts - 2 do
                table.insert(newParts, parts[i])
            end
            projectPath = table.concat(newParts, "/")
        else
            projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../../")
        end
    else
        projectPath = CS.System.IO.Path.GetFullPath(dataPath .. "/../")
    end

    return projectPath
end

function UpdateNPCBranchConfig(npcName, newBranchId)
    if not npcName or npcName == "" then
        return false
    end
    newBranchId = tonumber(newBranchId) or 0
    if newBranchId <= 0 then
        return false
    end

    -- 用与 DialogueTrigger 相同的 GetProjectPath 逻辑计算项目根目录
    local projectRoot = GetProjectPath_DM()
    local fullPath = CS.System.IO.Path.Combine(projectRoot, npcConfigPath)

    print("=== NPC [" .. npcName .. "] -> " .. newBranchId)
    print(": " .. fullPath)

    -- 读取 NPC 配置
    local configContent
    local success, err = pcall(function()
        if not CS.System.IO.File.Exists(fullPath) then
            error("配置文件不存在: " .. fullPath)
        end
        return CS.System.IO.File.ReadAllText(fullPath)
    end)

    if not success then
        print("[NPC分支解锁] 读取失败: " .. tostring(err))
        return false
    end

    configContent = err

    -- 执行 Lua 代码获取 Lua 表
    local configData
    local loadSuccess, loadErr = pcall(function()
        local func = load(configContent)
        return func()
    end)

    if not loadSuccess or not loadErr then
        print("[NPC分支解锁] 解析失败: " .. tostring(loadErr))
        return false
    end

    configData = loadErr

    -- 在 npcList 中查找并修改
    local found = false
    if configData and configData.npcList then
        for _, npc in ipairs(configData.npcList) do
            if npc.name == npcName then
                local oldBranchId = npc.currentBranchId or 1
                npc.currentBranchId = newBranchId
                found = true
                print("[NPC分支解锁] 找到 NPC [" .. npcName .. "]，currentBranchId: " .. oldBranchId .. " -> " .. newBranchId)
                break
            end
        end
    end

    if not found then
        print("[NPC分支解锁] 未找到名为 [" .. npcName .. "] 的 NPC")
        return false
    end

    -- 将修改后的配置表重新序列化为 Lua 文本
    local newContent = SerializeNPCConfig(configData.npcList)
    if not newContent then
        print("[NPC分支解锁] 序列化失败")
        return false
    end

    -- 写回文件
    local writeSuccess, writeErr = pcall(function()
        CS.System.IO.File.WriteAllText(fullPath, newContent)
    end)

    if not writeSuccess then
        print("[NPC分支解锁] 写入失败: " .. tostring(writeErr))
        return false
    end

    DouyinUtility.Toast("NPC [" .. npcName .. "] 已解锁分支 " .. newBranchId)
    print("[NPC分支解锁] ✓ 已成功更新 NPCData_Config.lua")
    return true
end

-- ========== 新增：将 NPC 配置表序列化为 Lua 文本 ==========
function SerializeNPCConfig(npcList)
    if not npcList then
        return nil
    end

    local sb = {}
    table.insert(sb, "local NPCData = {")
    table.insert(sb, "    npcList = {")

    for i, npc in ipairs(npcList) do
        table.insert(sb, "        {")
        table.insert(sb, '            id = "' .. tostring(npc.id or "") .. '",')
        table.insert(sb, '            name = "' .. tostring(npc.name or "") .. '",')
        table.insert(sb, '            avatarPath = "' .. tostring(npc.avatarPath or "") .. '",')
        table.insert(sb, "            currentBranchId = " .. tostring(npc.currentBranchId or 1) .. ",")

        if npc.isFolded ~= nil then
            local foldStr = npc.isFolded and "true" or "false"
            table.insert(sb, "            isFolded = " .. foldStr .. ",")
        end

        if npc.storyGraphs and #npc.storyGraphs then
            table.insert(sb, "            storyGraphs = {")
            for j, graph in ipairs(npc.storyGraphs) do
                table.insert(sb, "                {")
                table.insert(sb, "                    branchId = " .. tostring(graph.branchId or 1) .. ",")
                table.insert(sb, '                    storyDescription = "' .. tostring(graph.storyDescription or "") .. '",')
                table.insert(sb, '                    luaModuleName = "' .. tostring(graph.luaModuleName or "") .. '",')
                table.insert(sb, '                    luaAssetPath = "' .. tostring(graph.luaAssetPath or "") .. '"')
                table.insert(sb, "                }")
                if j < #npc.storyGraphs then
                    table.insert(sb, "                ,")
                end
            end
            table.insert(sb, "            }")
        end

        table.insert(sb, "        }")
        if i < #npcList then
            table.insert(sb, "        ,")
        end
    end

    table.insert(sb, "    }")
    table.insert(sb, "}")
    table.insert(sb, "return NPCData")

    return table.concat(sb, "\n") .. "\n"
end

-- ========== 新增：检查并处理 UnlockBranches（节点执行时解锁指定 NPC 的分支）==========
function CheckAndUnlockBranch(data)
    if not data then
        return
    end

    -- 收集所有需要解锁的条目：可能是数组（新格式），也可能是 UnlockBranchId 整数（兼容）
    local entries = {}

    if data.UnlockBranches and #data.UnlockBranches > 0 then
        -- 新格式：UnlockBranches = { { NpcName = "大树", BranchId = 2 }, ... }
        for _, item in ipairs(data.UnlockBranches) do
            local name = item.NpcName or item.npcName
            local bid = tonumber(item.BranchId) or tonumber(item.branchId) or 0
            if name and name ~= "" and bid > 0 then
                table.insert(entries, { npcName = name, branchId = bid })
            end
        end
    end

    if data.UnlockBranchId and tonumber(data.UnlockBranchId) > 0 then
        -- 兼容旧格式：UnlockBranchId = 2，NPC 为当前节点的 NpcName
        local name = data.NpcName or ""
        if name ~= "" then
            table.insert(entries, { npcName = name, branchId = tonumber(data.UnlockBranchId) })
        end
    end

    if #entries == 0 then
        return
    end

    -- 逐条执行解锁（同节点内每个NPC只处理一次）
    for _, entry in ipairs(entries) do
        local cacheKey = currentDialogueID .. "_" .. entry.npcName
        if not unlockedBranchCache[cacheKey] then
            if UpdateNPCBranchConfig(entry.npcName, entry.branchId) then
                unlockedBranchCache[cacheKey] = true
            end
        end
    end
end

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

    -- 优先检查条件分支（基于全局变量），如果没有匹配则使用默认 Next
    local nextID = GetNextNodeByCondition(currentData)
    if nextID == nil then
        nextID = currentData.Next
    end

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

    -- 检查是否需要解锁分支
    CheckAndUnlockBranch(data)

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
    unlockedBranchCache = {}

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
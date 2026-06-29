GlobalVariableList = {}

---@var GlobalVariablesScript :DouyinScript
---@var NPCDataConfig :DouyinScript
---@var DialogueData :DouyinScript[]
---@end

local globalVariables = {}
local debugButtonImages = {}

-- 开发测 bool 变量 UI（Canvas 滚动列表，按下=true 抬起=false）；发布前改 false
local VAR_DEBUG_UI_ENABLED = true

-- 开发测对话分支时设为 true：保留 NPCData_Config 里 Publish 的 currentBranchId（如大黄 branch 5 → FROM_DOC）
-- 正式打包/发布前改回 false
local KEEP_NPC_BRANCH_FOR_TEST = true

local COLOR_OFF = UnityEngine.Color(0.22, 0.24, 0.28, 0.92)
local COLOR_ON = UnityEngine.Color(0.18, 0.62, 0.32, 1.0)

local function ParseItemValue(item)
    if item.type == "bool" then
        return item.value == true or item.value == "true" or item.value == 1
    end
    return tonumber(item.value) or 0
end

local function FindListItem(varName)
    if not GlobalVariableList then return nil end
    for _, item in ipairs(GlobalVariableList) do
        if item.name == varName then
            return item
        end
    end
    return nil
end

local function LoadGlobalVariablesFromList(list)
    if not list then
        print("[GlobalVariables] GlobalVariableList 为空")
        return
    end

    for _, item in ipairs(list) do
        if item.name and item.type then
            local value = ParseItemValue(item)
            globalVariables[item.name] = { type = item.type, value = value }
        end
    end
    print("[GlobalVariables] 从 GlobalVariableList 加载完成")
end

local function BindInspectorVariableList()
    if GlobalVariablesScript and GlobalVariablesScript.script and GlobalVariablesScript.script.GlobalVariables then
        GlobalVariableList = GlobalVariablesScript.script.GlobalVariables
        return
    end
    print("[GlobalVariables] GlobalVariablesScript 引用未设置，GlobalVariableList 保持为空")
end

function GetGlobalVar(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].value
end

function SetGlobalVar(varName, value, varType)
    if varName == nil or varName == "" then return end
    varType = varType or "bool"

    if globalVariables[varName] == nil then
        if varType == "bool" then
            globalVariables[varName] = { type = "bool", value = false }
        else
            globalVariables[varName] = { type = "int", value = 0 }
        end
    end

    if varType == "bool" then
        globalVariables[varName].value = (value == true or value == "true" or value == 1)
    else
        globalVariables[varName].value = tonumber(value) or 0
    end

    local runtimeValue = globalVariables[varName].value
    local listItem = FindListItem(varName)
    if listItem then
        listItem.value = runtimeValue
    end

    local btnImage = debugButtonImages[varName]
    if btnImage and varType == "bool" then
        btnImage.color = (runtimeValue == true) and COLOR_ON or COLOR_OFF
    end

    print("[GlobalVariables] 设置变量: " .. varName .. " = " .. tostring(runtimeValue))
end

function GetGlobalVarType(varName)
    if varName == nil or globalVariables[varName] == nil then
        return nil
    end
    return globalVariables[varName].type
end

local function CreateRectChild(name, parent, anchorMin, anchorMax, offsetMin, offsetMax)
    local go = UnityEngine.GameObject(name)
    go.transform:SetParent(parent, false)
    local rt = go:AddComponent(typeof(UnityEngine.RectTransform))
    rt.anchorMin = anchorMin
    rt.anchorMax = anchorMax
    rt.offsetMin = offsetMin
    rt.offsetMax = offsetMax
    return go, rt
end

local function AddToggleBoolButton(contentRt, varName)
    local btnGo = UnityEngine.GameObject("VarBtn_" .. varName)
    btnGo.transform:SetParent(contentRt, false)
    local btnRt = btnGo:AddComponent(typeof(UnityEngine.RectTransform))
    btnRt.anchorMin = UnityEngine.Vector2(0, 1)
    btnRt.anchorMax = UnityEngine.Vector2(1, 1)
    btnRt.pivot = UnityEngine.Vector2(0.5, 1)
    btnRt.sizeDelta = UnityEngine.Vector2(0, 34)

    local layoutEl = btnGo:AddComponent(typeof(UnityEngine.UI.LayoutElement))
    layoutEl.preferredHeight = 34
    layoutEl.minHeight = 34

    local img = btnGo:AddComponent(typeof(UnityEngine.UI.Image))
    local initial = GetGlobalVar(varName) == true
    img.color = initial and COLOR_ON or COLOR_OFF
    debugButtonImages[varName] = img

    local btn = btnGo:AddComponent(typeof(UnityEngine.UI.Button))
    btn.targetGraphic = img

    local textGo = UnityEngine.GameObject("Label")
    textGo.transform:SetParent(btnRt, false)
    local textRt = textGo:AddComponent(typeof(UnityEngine.RectTransform))
    textRt.anchorMin = UnityEngine.Vector2(0, 0)
    textRt.anchorMax = UnityEngine.Vector2(1, 1)
    textRt.offsetMin = UnityEngine.Vector2(8, 2)
    textRt.offsetMax = UnityEngine.Vector2(-8, -2)
    local label = textGo:AddComponent(typeof(UnityEngine.UI.Text))
    label.text = varName
    label.font = UnityEngine.Resources.GetBuiltinResource(typeof(UnityEngine.Font), "Arial.ttf")
    label.fontSize = 13
    label.alignment = UnityEngine.TextAnchor.MiddleLeft
    label.color = UnityEngine.Color(0.95, 0.95, 0.95, 1)

    local captured = varName
    btn.onClick:AddListener(function()
        local current = GetGlobalVar(captured) == true
        SetGlobalVar(captured, not current, "bool")
    end)
end

local function BuildVarDebugScrollPanel()
    if not VAR_DEBUG_UI_ENABLED then return end

    local canvas = UnityEngine.GameObject.Find("Canvas")
    if not canvas then
        print("[GlobalVarDebug] 未找到 Canvas")
        return
    end

    local canvasRt = canvas:GetComponent(typeof(UnityEngine.RectTransform))
    if not canvasRt then
        print("[GlobalVarDebug] Canvas 无 RectTransform")
        return
    end

    if canvas.transform:Find("VarDebugPanel") then
        print("[GlobalVarDebug] VarDebugPanel 已存在，跳过创建")
        return
    end

    local panelGo, panelRt = CreateRectChild(
        "VarDebugPanel",
        canvasRt,
        UnityEngine.Vector2(1, 0),
        UnityEngine.Vector2(1, 1),
        UnityEngine.Vector2(-340, 12),
        UnityEngine.Vector2(-12, -12)
    )
    local panelBg = panelGo:AddComponent(typeof(UnityEngine.UI.Image))
    panelBg.color = UnityEngine.Color(0.08, 0.09, 0.12, 0.88)

    local titleGo, titleRt = CreateRectChild(
        "Title",
        panelRt,
        UnityEngine.Vector2(0, 1),
        UnityEngine.Vector2(1, 1),
        UnityEngine.Vector2(8, -38),
        UnityEngine.Vector2(-8, -8)
    )
    local titleText = titleGo:AddComponent(typeof(UnityEngine.UI.Text))
    titleText.text = "Bool 变量调试（点击切换 true/false）"
    titleText.font = UnityEngine.Resources.GetBuiltinResource(typeof(UnityEngine.Font), "Arial.ttf")
    titleText.fontSize = 14
    titleText.alignment = UnityEngine.TextAnchor.MiddleLeft
    titleText.color = UnityEngine.Color(1, 1, 1, 0.9)

    local scrollGo, scrollRt = CreateRectChild(
        "ScrollView",
        panelRt,
        UnityEngine.Vector2(0, 0),
        UnityEngine.Vector2(1, 1),
        UnityEngine.Vector2(8, 8),
        UnityEngine.Vector2(-8, -44)
    )
    local scrollRect = scrollGo:AddComponent(typeof(UnityEngine.UI.ScrollRect))
    scrollRect.horizontal = false
    scrollRect.vertical = true
    scrollRect.movementType = UnityEngine.UI.ScrollRect.MovementType.Clamped
    scrollRect.scrollSensitivity = 24

    local viewportGo, viewportRt = CreateRectChild(
        "Viewport",
        scrollRt,
        UnityEngine.Vector2(0, 0),
        UnityEngine.Vector2(1, 1),
        UnityEngine.Vector2(0, 0),
        UnityEngine.Vector2(0, 0)
    )
    local viewportImg = viewportGo:AddComponent(typeof(UnityEngine.UI.Image))
    viewportImg.color = UnityEngine.Color(1, 1, 1, 0.01)
    viewportGo:AddComponent(typeof(UnityEngine.UI.Mask))

    local contentGo, contentRt = CreateRectChild(
        "Content",
        viewportRt,
        UnityEngine.Vector2(0, 1),
        UnityEngine.Vector2(1, 1),
        UnityEngine.Vector2(0, 0),
        UnityEngine.Vector2(0, 0)
    )
    contentRt.pivot = UnityEngine.Vector2(0.5, 1)

    local layout = contentGo:AddComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
    layout.childAlignment = UnityEngine.TextAnchor.UpperCenter
    layout.childControlWidth = true
    layout.childControlHeight = true
    layout.childForceExpandWidth = true
    layout.childForceExpandHeight = false
    layout.spacing = 4
    layout.padding = CS.UnityEngine.RectOffset(4, 4, 4, 4)

    local fitter = contentGo:AddComponent(typeof(UnityEngine.UI.ContentSizeFitter))
    fitter.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    fitter.verticalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize

    scrollRect.viewport = viewportRt
    scrollRect.content = contentRt

    local boolCount = 0
    if GlobalVariableList then
        for _, item in ipairs(GlobalVariableList) do
            if item.name and item.type == "bool" then
                AddToggleBoolButton(contentRt, item.name)
                boolCount = boolCount + 1
            end
        end
    end

    print("[GlobalVarDebug] VarDebugPanel 已创建，bool 按钮 x" .. boolCount)
end

function ResetAllNPCBranchesToStart()
    if not NPCDataConfig or not NPCDataConfig.script then
        print("[GlobalVariables] NPCDataConfig 引用未设置")
        return
    end

    local data = NPCDataConfig.script.NPCData
    if data and data.npcList then
        for _, npc in ipairs(data.npcList) do
            if npc.currentBranchId then
                npc.currentBranchId = 1
            end
        end
        print("[GlobalVariables] NPCData_Config 所有分支已重置为 1")
    end
end

function Start()
    BindInspectorVariableList()
    LoadGlobalVariablesFromList(GlobalVariableList)

    if KEEP_NPC_BRANCH_FOR_TEST then
        print("[GlobalVariables] KEEP_NPC_BRANCH_FOR_TEST=true，保留 NPCData 中的 currentBranchId")
    else
        ResetAllNPCBranchesToStart()
    end

    _G["_GlobalVariables"] = globalVariables
    _G["GetGlobalVar"] = GetGlobalVar
    _G["SetGlobalVar"] = SetGlobalVar
    _G["GetGlobalVarType"] = GetGlobalVarType
    if NPCDataConfig and NPCDataConfig.script then
        _G["_NPCDataConfig"] = NPCDataConfig.script.NPCData
    end

    local count = 0
    for _ in pairs(globalVariables) do count = count + 1 end
    print("[GlobalVariables] 初始化完成，共 " .. count .. " 个变量")

    BuildVarDebugScrollPanel()
end

---@var open :UnityEngine.UI.Button
---@var boolPanel :UnityEngine.GameObject
---@var leftBtn :UnityEngine.UI.Button
---@var rightBtn :UnityEngine.UI.Button
---@var pageContents :UnityEngine.GameObject[]
---@var page1 :UnityEngine.GameObject[]

local currentIndex = 1
local unlockedItems = {}
local fadingItems = {}
local unlockConfig = {
    fadeDuration = 1.0,

    conditions = {
        "Shufen_CommissionDone==true",
        "E01_ViewCharcoal==true",
        "E03_Overheard==true",
        "E02_ViewFeather==true",
        "ChickStatus==2",
        "Frog_WaterMonsterQueried==true",
        "E23_dabble==true",
        "E25_ChickenFootprints==true"
    }
}

function Start()
    DouyinUIService.GetInteractionButton(HandType.Right, UIType.Fly).gameObject:SetActive(false)
    boolPanel:SetActive(false)
    open.onClick:AddListener(OnOpenClick)
    leftBtn.onClick:AddListener(OnLeftClick)
    rightBtn.onClick:AddListener(OnRightClick)

    print("[BookController] 配置加载成功, fadeDuration=" .. tostring(unlockConfig.fadeDuration))
    if unlockConfig.conditions then
        print("[BookController] 条件数量: " .. #unlockConfig.conditions)
        for i, cond in ipairs(unlockConfig.conditions) do
            print("[BookController] 条件[" .. i .. "]: " .. cond)
        end
    end

    InitializePage1()
    HideAllPages()
    if pageContents and pageContents.Length > 0 then
        pageContents[currentIndex - 1]:SetActive(true)
    end
end

function InitializePage1()
    if not page1 then return end
    for i = 0, page1.Length - 1 do
        local obj = page1[i]
        if obj then
            obj:SetActive(false)
            local canvasGroup = obj:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
            if not canvasGroup then
                canvasGroup = obj:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
            end
            canvasGroup.alpha = 0
            unlockedItems[i] = false
        end
    end
end

function Update()
    if not unlockConfig then return end

    local fadeDuration = unlockConfig.fadeDuration or 1.0
    local toRemove = {}

    for idx, info in pairs(fadingItems) do
        info.elapsed = info.elapsed + CS.UnityEngine.Time.deltaTime
        local progress = info.elapsed / fadeDuration
        if progress >= 1 then
            progress = 1
            table.insert(toRemove, idx)
        end
        info.canvasGroup.alpha = progress
    end

    for _, idx in ipairs(toRemove) do
        fadingItems[idx] = nil
    end
end

function OnOpenClick()
    boolPanel:SetActive(not boolPanel.activeSelf)
    if boolPanel.activeSelf then
        CheckAndUnlockPage1()
        HideAllPages()
        if pageContents and pageContents.Length > 0 then
            pageContents[currentIndex - 1]:SetActive(true)
        end
    end
end

function CheckAndUnlockPage1()
    print("[BookController] CheckAndUnlockPage1 开始")

    if not page1 then
        print("[BookController] page1 为空")
        return
    end
    print("[BookController] page1 物体数量: " .. page1.Length)

    if not unlockConfig then
        print("[BookController] unlockConfig 为空")
        return
    end

    local conditions = unlockConfig.conditions
    if not conditions then
        print("[BookController] conditions 为空")
        return
    end
    print("[BookController] conditions 数量: " .. #conditions)

    for i = 0, page1.Length - 1 do
        local obj = page1[i]
        local condition = conditions[i + 1]

        print("[BookController] 检查索引[" .. i .. "]: obj=" .. tostring(obj) .. ", condition=" .. tostring(condition))

        if obj and condition and condition ~= "" then
            if unlockedItems[i] then
                print("[BookController] 索引[" .. i .. "] 已解锁，跳过")
            else
                local result = CheckUnlockCondition(condition)
                print("[BookController] 索引[" .. i .. "] 条件检查结果: " .. tostring(result))
                if result then
                    print("[BookController] 索引[" .. i .. "] 解锁成功!")
                    UnlockItem(i, obj)
                end
            end
        end
    end

    print("[BookController] CheckAndUnlockPage1 结束")
end

function CheckUnlockCondition(condition)
    local globalVars = _G["_GlobalVariables"]
    if not globalVars then
        print("[BookController] _GlobalVariables 为空")
        return false
    end
    print("[BookController] 检查条件: " .. condition)

    local subConditions = {}
    for subCond in string.gmatch(condition, "[^&]+") do
        local trimmed = string.gsub(subCond, "^%s*(.-)%s*$", "%1")
        if trimmed ~= "" then
            table.insert(subConditions, trimmed)
        end
    end
    print("[BookController] 分割后的子条件数量: " .. #subConditions)

    for _, subCond in ipairs(subConditions) do
        print("[BookController] 检查子条件: " .. subCond)
        local result = CheckSingleCondition(subCond, globalVars)
        print("[BookController] 子条件[" .. subCond .. "] 结果: " .. tostring(result))
        if not result then
            print("[BookController] 子条件[" .. subCond .. "] 不满足，返回 false")
            return false
        end
    end

    print("[BookController] 所有条件满足，返回 true")
    return true
end

function CheckSingleCondition(subCond, globalVars)
    local pattern = "^([%w_]+)([<>!=]+)([%d]+)$"
    local name, op, val = string.match(subCond, pattern)

    if not name then
        local boolPattern = "^([%w_]+)==([a-z]+)$"
        name, val = string.match(subCond, boolPattern)
        if name and val then
            print("[BookController] 布尔条件: " .. name .. " == " .. val)
            local var = globalVars[name]
            if not var then
                print("[BookController] 变量[" .. name .. "] 不存在")
                return false
            end
            print("[BookController] 变量[" .. name .. "] 当前值: " .. tostring(var.value) .. ", 类型: " .. var.type)
            local boolVal = (val == "true" or val == "1")
            local result = var.value == boolVal
            print("[BookController] 比较结果: " ..
                tostring(var.value) .. " == " .. tostring(boolVal) .. " = " .. tostring(result))
            return result
        end
        print("[BookController] 条件格式不匹配: " .. subCond)
        return false
    end

    print("[BookController] 数字条件: " .. name .. " " .. op .. " " .. val)
    local var = globalVars[name]
    if not var then
        print("[BookController] 变量[" .. name .. "] 不存在")
        return false
    end
    print("[BookController] 变量[" .. name .. "] 当前值: " .. tostring(var.value) .. ", 类型: " .. var.type)

    local numVal = tonumber(val)
    if not numVal then
        print("[BookController] 比较值不是数字: " .. val)
        return false
    end

    local result = false
    if op == ">=" then
        result = var.value >= numVal
    elseif op == "<=" then
        result = var.value <= numVal
    elseif op == ">" then
        result = var.value > numVal
    elseif op == "<" then
        result = var.value < numVal
    elseif op == "==" then
        result = var.value == numVal
    elseif op == "!=" then
        result = var.value ~= numVal
    end
    print("[BookController] 比较结果: " .. tostring(var.value) .. " " .. op .. " " .. numVal .. " = " .. tostring(result))
    return result
end

function UnlockItem(index, obj)
    obj:SetActive(true)
    unlockedItems[index] = true

    local canvasGroup = obj:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if not canvasGroup then
        canvasGroup = obj:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
    end
    canvasGroup.alpha = 0

    fadingItems[index] = {
        canvasGroup = canvasGroup,
        elapsed = 0
    }
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

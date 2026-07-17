-- E20 漫画收束 · Notebook/Ending（prefab 内默认 inactive）
-- 黑底仅开场渐黑一次；换页用 crossfade，避免闪黑
-- 最后一张图后整体渐隐并关闭 Ending

---@var panels :UnityEngine.GameObject[]
---@var clickArea :UnityEngine.UI.Button
---@var fadeDuration :float = 1.0
---@end

local phase = "idle"
local fadeInfo = nil
local currentPanelIndex = 0
local finalized = false
local bgLocked = false
local bgImage = nil
local advanceBound = false
local crossfadeFrom = nil
local crossfadeTo = nil
local fadeInTarget = nil
local fadeOutPanel = nil

local function RegisterGlobal()
    if _G["EndingController_Start"] then return end
    _G["EndingController_Start"] = function()
        EndingController_Start()
    end
end

local function SmoothStep(t)
    if t <= 0 then return 0 end
    if t >= 1 then return 1 end
    return t * t * (3 - 2 * t)
end

local function GetBgImage()
    if not bgImage then
        bgImage = self.gameObject:GetComponent(typeof(CS.UnityEngine.UI.Image))
    end
    return bgImage
end

local function SetBgAlpha(alpha)
    if bgLocked and alpha < 1 then return end
    local img = GetBgImage()
    if not img then return end
    local c = img.color
    img.color = CS.UnityEngine.Color(c.r, c.g, c.b, alpha)
end

local function LockBg()
    bgLocked = true
    SetBgAlpha(1)
end

local function SetVisualAlpha(go, alpha)
    if not go then return end
    local img = go:GetComponent(typeof(CS.UnityEngine.UI.Image))
    if img then
        local c = img.color
        img.color = CS.UnityEngine.Color(c.r, c.g, c.b, alpha)
        return
    end
    local txt = go:GetComponent(typeof(CS.UnityEngine.UI.Text))
    if txt then
        local c = txt.color
        txt.color = CS.UnityEngine.Color(c.r, c.g, c.b, alpha)
    end
end

local function ClearLegacyCanvasGroup(go)
    if not go then return end
    local cg = go:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if cg then
        CS.UnityEngine.Object.Destroy(cg)
    end
end

local function DeactivateGo(go)
    if not go then return end
    ClearLegacyCanvasGroup(go)
    SetVisualAlpha(go, 0)
    go:SetActive(false)
end

local function GetPanelCount()
    if not panels then return 0 end
    return panels.Length
end

local function HideAllPanels()
    if not panels then return end
    for i = 0, panels.Length - 1 do
        DeactivateGo(panels[i])
    end
end

local function SetClickEnabled(enabled)
    if clickArea then
        clickArea.interactable = enabled
    end
end

local function SetRootRaycastEnabled(enabled)
    local img = GetBgImage()
    if img then
        img.raycastTarget = enabled
    end
end

local function DisableButtonColorTransition(btn)
    if not btn then return end
    btn.transition = CS.UnityEngine.UI.Selectable.Transition.None
end

local function DisableConflictingComponents()
    local rootCg = self.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if rootCg then
        rootCg.alpha = 1
        rootCg.blocksRaycasts = false
    end
    local anim = self.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    if anim then
        anim.enabled = false
    end
end

local function InitializeVisuals()
    bgLocked = false
    DisableConflictingComponents()
    SetBgAlpha(0)
    HideAllPanels()
    SetClickEnabled(false)
end

local function EnsureEndingHidden()
    InitializeVisuals()
    SetClickEnabled(false)
    SetRootRaycastEnabled(false)
    self.gameObject:SetActive(false)
end

local function FinalizeEnding()
    if finalized then return end
    finalized = true
    phase = "done"
    SetClickEnabled(false)
    SetRootRaycastEnabled(false)

    print("[EndingController] 漫画收束完成，上报 Terminal")
    if DouyinApplication and DouyinApplication.isSimulator then
        print("[EndingController] 模拟器跳过 Terminal")
    else
        CS.DouyinTaskService.SendEvent(CS.DouyinTaskEvent.Terminal)
    end

    -- 漫画收束完毕 → 进入二周目（各 NPC entry 分发 / 奶酪刷新）
    if _G["SetGlobalVar"] then
        _G["SetGlobalVar"]("NGPlus", true, "bool")
        print("[EndingController] NGPlus = true")
    end

    if _G["ResetPosition"] then
        _G["ResetPosition"]()
        print("[EndingController] 调用 ResetPosition")
    end

    if DouyinUIService.SetNativeUIVisible then
        DouyinUIService.SetNativeUIVisible(true)
    end

    self.gameObject:SetActive(false)
end

local function OnFadeComplete()
    if phase == "fadeBg" then
        LockBg()
        currentPanelIndex = 1
        local go = panels and panels.Length > 0 and panels[0] or nil
        if go then
            phase = "fadeIn"
            fadeInTarget = go
            go:SetActive(true)
            SetVisualAlpha(go, 0)
            fadeInfo = { kind = "in", elapsed = 0, onComplete = OnFadeComplete }
        else
            FinalizeEnding()
        end
        return
    end

    if phase == "fadeIn" then
        if fadeInTarget then
            SetVisualAlpha(fadeInTarget, 1)
            fadeInTarget = nil
        end
        if GetPanelCount() == 0 then
            FinalizeEnding()
        else
            phase = "waitClick"
            SetClickEnabled(true)
        end
        return
    end

    if phase == "crossfade" then
        if crossfadeFrom then
            DeactivateGo(crossfadeFrom)
        end
        if crossfadeTo then
            SetVisualAlpha(crossfadeTo, 1)
        end
        crossfadeFrom = nil
        crossfadeTo = nil
        phase = "waitClick"
        SetClickEnabled(true)
        return
    end

    if phase == "fadeOut" then
        if fadeOutPanel then
            DeactivateGo(fadeOutPanel)
            fadeOutPanel = nil
        end
        SetBgAlpha(0)
        FinalizeEnding()
        return
    end
end

local function StartFadeOut(panelGo)
    phase = "fadeOut"
    fadeOutPanel = panelGo
    bgLocked = false
    SetClickEnabled(false)
    fadeInfo = { kind = "out", elapsed = 0, onComplete = OnFadeComplete }
end

local function StartCrossfade(fromGo, toGo)
    phase = "crossfade"
    crossfadeFrom = fromGo
    crossfadeTo = toGo
    SetClickEnabled(false)
    if toGo then
        toGo:SetActive(true)
        SetVisualAlpha(toGo, 0)
    end
    if fromGo then
        SetVisualAlpha(fromGo, 1)
    end
    fadeInfo = {
        kind = "crossfade",
        elapsed = 0,
        onComplete = OnFadeComplete
    }
end

local function OnAdvanceClick()
    if phase ~= "waitClick" then return end

    local prevGo = nil
    if panels and currentPanelIndex >= 1 and currentPanelIndex <= panels.Length then
        prevGo = panels[currentPanelIndex - 1]
    end

    currentPanelIndex = currentPanelIndex + 1
    if currentPanelIndex <= GetPanelCount() then
        StartCrossfade(prevGo, panels[currentPanelIndex - 1])
    else
        StartFadeOut(prevGo)
    end
end

local function BindClickArea()
    if advanceBound then return end
    advanceBound = true

    if clickArea then
        DisableButtonColorTransition(clickArea)
        clickArea.onClick:AddListener(OnAdvanceClick)
        return
    end

    local rootGo = self.gameObject
    local btn = rootGo:GetComponent(typeof(CS.UnityEngine.UI.Button))
    if not btn then
        btn = rootGo:AddComponent(typeof(CS.UnityEngine.UI.Button))
    end
    DisableButtonColorTransition(btn)
    btn.onClick:AddListener(OnAdvanceClick)
    clickArea = btn
end

function EndingController_Start()
    if phase ~= "idle" and phase ~= "done" then
        print("[EndingController] 演出进行中，忽略重复启动")
        return
    end

    finalized = false
    currentPanelIndex = 0
    fadeInfo = nil
    fadeInTarget = nil
    fadeOutPanel = nil
    crossfadeFrom = nil
    crossfadeTo = nil
    phase = "fadeBg"

    BindClickArea()
    InitializeVisuals()

    SetRootRaycastEnabled(true)
    self.gameObject:SetActive(true)

    fadeInfo = { kind = "bg", elapsed = 0, onComplete = OnFadeComplete }
    SetBgAlpha(0)

    print("[EndingController] 开始漫画收束")
end

function Start()
    RegisterGlobal()
    BindClickArea()
    if phase == "idle" or phase == "done" then
        EnsureEndingHidden()
    end
end

function Update()
    if not fadeInfo then return end

    local duration = fadeDuration or 1.0
    if duration <= 0 then duration = 1.0 end

    fadeInfo.elapsed = fadeInfo.elapsed + CS.UnityEngine.Time.deltaTime
    local progress = fadeInfo.elapsed / duration
    if progress > 1 then progress = 1 end
    local eased = SmoothStep(progress)

    if fadeInfo.kind == "bg" then
        SetBgAlpha(eased)
    elseif fadeInfo.kind == "in" then
        SetVisualAlpha(fadeInTarget, eased)
    elseif fadeInfo.kind == "crossfade" then
        if crossfadeFrom then
            SetVisualAlpha(crossfadeFrom, 1 - eased)
        end
        if crossfadeTo then
            SetVisualAlpha(crossfadeTo, eased)
        end
    elseif fadeInfo.kind == "out" then
        local alpha = 1 - eased
        SetBgAlpha(alpha)
        if fadeOutPanel then
            SetVisualAlpha(fadeOutPanel, alpha)
        end
    end

    if progress >= 1 then
        local cb = fadeInfo.onComplete
        fadeInfo = nil
        if cb then cb() end
    end
end

-- Canvas/StartPage：进入游戏时全屏展示，停留后渐隐关闭

---@var holdDuration :float = 2.0
---@var fadeDuration :float = 1.0
---@end

local phase = "idle"
local elapsed = 0
local canvasGroup = nil

local function SmoothStep(t)
    if t <= 0 then return 0 end
    if t >= 1 then return 1 end
    return t * t * (3 - 2 * t)
end

local function ResolveHoldDuration()
    if holdDuration and holdDuration > 0 then
        return holdDuration
    end
    return 2.0
end

local function ResolveFadeDuration()
    if fadeDuration and fadeDuration > 0 then
        return fadeDuration
    end
    return 1.0
end

local function GetCanvasGroup()
    if canvasGroup then
        return canvasGroup
    end
    canvasGroup = self.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if not canvasGroup then
        canvasGroup = self.gameObject:AddComponent(typeof(CS.UnityEngine.CanvasGroup))
    end
    return canvasGroup
end

local function Finish()
    local cg = GetCanvasGroup()
    cg.alpha = 0
    cg.blocksRaycasts = false
    self.gameObject:SetActive(false)
    phase = "done"
end

function Start()
    self.gameObject:SetActive(true)
    local cg = GetCanvasGroup()
    cg.alpha = 1
    cg.blocksRaycasts = true
    phase = "hold"
    elapsed = 0
end

function Update()
    if phase == "idle" or phase == "done" then
        return
    end

    elapsed = elapsed + CS.UnityEngine.Time.deltaTime

    if phase == "hold" then
        if elapsed >= ResolveHoldDuration() then
            phase = "fade"
            elapsed = 0
        end
        return
    end

    if phase == "fade" then
        local duration = ResolveFadeDuration()
        local t = elapsed / duration
        if t >= 1 then
            Finish()
            return
        end
        GetCanvasGroup().alpha = 1 - SmoothStep(t)
    end
end

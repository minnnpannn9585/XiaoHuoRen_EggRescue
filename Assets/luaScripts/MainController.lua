---@var audioClips :UnityEngine.AudioClip[]   -- 音频数组，可在 Unity Inspector 中赋值
---@var audioSource :UnityEngine.AudioSource -- 用于播放的音频源，若为空则自动添加
---@var open :UnityEngine.UI.Button
---@var particleSystems :UnityEngine.ParticleSystem[] -- 粒子系统数组，可在 Unity Inspector 中赋值
---@end

-- 场景杂项：隐藏 SDK 飞行键/聊天面板；注册全局 PlayAudio / PlayParticle。
-- 薄荷鱼蛙模型切换见 BeiShangWa.lua。

-- Unity 启动入口
function Start()
    -- 获取或添加 AudioSource 组件
    -- audioSource = gameObject:GetComponent(typeof(UnityEngine.AudioSource))
    -- if audioSource == nil then
    --     audioSource = gameObject:AddComponent(typeof(UnityEngine.AudioSource))
    -- end
    if open then open.onClick:AddListener(OnOpenClick) end
    _G["PlayAudio"] = PlayAudioByName
    _G["PlayParticle"] = PlayParticleByName
end

function OnOpenClick()
    -- PlayAudioByName("audio_openNote")
    local playParticle = _G["PlayParticle"]
    if playParticle then
        playParticle("vfx_characterChange", self.transform.position)
    end
    print("OnOpenClick 执行完成")
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

function QuitSample()
    DouyinApplication.Quit()
end

-- 播放音频函数，参数为音频数组索引（从 0 开始）
function PlayAudioClip(index)
    if audioClips == nil or audioClips.Length == 0 then
        print("No audio clips assigned")
        return
    end
    if index < 0 or index >= audioClips.Length then
        print("Invalid audio clip index: " .. tostring(index))
        return
    end
    local clip = audioClips[index]
    if clip == nil then
        print("Audio clip at index " .. tostring(index) .. " is nil")
        return
    end
    if audioSource then
        audioSource:PlayOneShot(clip) -- 使用现有 AudioSource 播放
    else
        -- 备用方案：在场景原点播放（若 audioSource 丢失）
        UnityEngine.AudioSource.PlayClipAtPoint(clip, UnityEngine.Vector3.zero)
    end
end

-- 新增：通过音频名称（AudioClip 的 name 属性，即导入时的文件名）查找并播放
-- 注意：名称不包含扩展名，例如文件名为 "Click.wav"，则传入 "Click"
function PlayAudioByName(name)
    if audioClips == nil or audioClips.Length == 0 then
        print("No audio clips assigned")
        return
    end
    for i = 0, audioClips.Length - 1 do
        local clip = audioClips[i]
        if clip and clip.name == name then
            PlayAudioClip(i) -- 复用索引播放函数
            return
        end
    end
    print("No audio clip found with name: " .. tostring(name))
end

-- 播放粒子函数，参数为粒子数组索引（从 0 开始），可选位置参数
function PlayParticle(index, position)
    if particleSystems == nil or particleSystems.Length == 0 then
        print("[PlayParticle] 粒子数组为空")
        return
    end
    if index < 0 or index >= particleSystems.Length then
        print("[PlayParticle] 无效索引: " .. tostring(index))
        return
    end
    local ps = particleSystems[index]
    if ps == nil then
        print("[PlayParticle] 粒子为空: " .. tostring(index))
        return
    end

    if position then
        ps.transform.position = position
    end

    ps:Stop()
    ps:Clear()
    ps:Play()
end

-- 通过粒子系统名称查找并播放（ParticleSystem 的 name 属性），可选位置参数
function PlayParticleByName(name, position)
    if particleSystems == nil or particleSystems.Length == 0 then
        print("[PlayParticle] 粒子数组为空")
        return
    end
    print("[PlayParticle] 查找粒子: " .. tostring(name) .. ", 数组长度: " .. particleSystems.Length)
    for i = 0, particleSystems.Length - 1 do
        local ps = particleSystems[i]
        if ps then
            print("[PlayParticle] 粒子[" .. i .. "]: " .. ps.name)
            if ps.name == name then
                PlayParticle(i, position)
                return
            end
        end
    end
    print("[PlayParticle] 未找到粒子: " .. tostring(name))
end

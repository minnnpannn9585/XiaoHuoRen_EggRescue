-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "大树？",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "Black Cat",
    Dialogue = "你踩到我的根了。",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "哦，对不起。",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "Black Cat",
    Dialogue = "……",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "Black Cat",
    Dialogue = "无趣。",
    Next = -1  -- 下一段对话ID
}


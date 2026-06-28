-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "嗝——",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "谁……",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬的蛋不见了。你看到过什么吗？",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄的耳朵动了一下，目光慢慢聚过来）",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "蛋……乌鸦……叼走了。",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "乌鸦？",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "嗯……飞到谷仓屋顶去了。我追了……跳不上去，只咬到空气。",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄把脑袋重新压回前爪上，声音低下去）",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "我失职了……没有保护好淑芬的蛋。",
    SetVariables = {
        { VarName = "DogStatus", VarType = "int", Value = 2 }
    },
    Next = -1  -- 下一段对话ID
}


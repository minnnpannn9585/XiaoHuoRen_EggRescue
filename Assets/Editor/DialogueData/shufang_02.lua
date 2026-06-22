-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你来了，快进来。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "有发现吗？",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "眼神里是止不住的期待，很快又压下去",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "没有也没事，慢慢来——有什么要问的都可以。",
    UnlockBranches = {
        { NpcName = "淑芬", BranchId = 3 }
    },
    Next = -1  -- 下一段对话ID
}


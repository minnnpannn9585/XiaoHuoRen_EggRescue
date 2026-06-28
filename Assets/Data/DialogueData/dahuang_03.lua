-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄半睡半醒，耳朵动了一下又垂下去）",
    Next = 15  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄眯着眼嗅了嗅，慢慢伸出舌头，喝了几口，停住，再喝）",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "（片刻后，大黄猛地甩了下脑袋——湿树叶从额头飞出去）",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "呕——",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "嗝——",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄使劲眨眼，目光开始聚焦）",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "……我刚才说什么来着？",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "你说乌鸦叼走了蛋，飞到谷仓屋顶。",
    Next = 10  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄低下头，耳朵耷拉着）",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "对。我没拦住。",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄深吸一口气，四肢从梯子上撑起来，摇摇晃晃站稳）",
    UnlockBranches = {
        { NpcName = "大黄", BranchId = 4 }
    },
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄哼了一声，把头埋进前爪里）",
    Next = 14  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "嗝……别吵……",
    ConditionBranches = {
        { VarName = "E06_ViewNeedLadder", VarType = "bool", TrueNext = 18, FalseNext = 19 }
    },
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "嗝……干嘛……",
    ConditionBranches = {
        { VarName = "E05_GrainSoakGet", VarType = "bool", TrueNext = 16, FalseNext = 17 }
    },
    Next = 16  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "大黄，先喝点这个。",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "大黄，醒醒。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "这样叫不醒。得先让他清醒过来，短梯才借得出来。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "这样叫不醒。得找点能让他清醒的东西。",
    Next = -1  -- 下一段对话ID
}


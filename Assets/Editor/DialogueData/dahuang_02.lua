-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[0] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "你身下压着一架短木梯，能先挪一下吗？谷仓入口那道矮墙翻不过去。",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄迷迷糊糊蹬了下腿，短梯反而被压得更实）",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "看来得把他叫醒。",
    UnlockBranches = {
        { NpcName = "大黄", BranchId = 3 }
    },
    Next = -1  -- 下一段对话ID
}


-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "听见动静猛地抬起头",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "哦，是你！",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……怎么样了，有消息了吗？",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "说完拢了拢翅膀，像是刚才那句话太着急了",
    UnlockBranches = {
        { NpcName = "淑芬", BranchId = 4 }
    },
    Next = -1  -- 下一段对话ID
}


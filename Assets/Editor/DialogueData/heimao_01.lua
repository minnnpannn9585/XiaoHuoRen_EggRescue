-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "傻子在炫耀，瞎子在到处问。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谁？大树？大树说话了？",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "咳咳，嗯……是本树在说话。",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "哦！那大树你说的傻子和瞎子是谁？",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "……走吧，凡人。别踩我的根。",
    UnlockBranches = {
        { NpcName = "大树", BranchId = 2 }
    },
    Next = -1  -- 下一段对话ID
}


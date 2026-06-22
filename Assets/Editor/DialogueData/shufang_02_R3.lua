-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "来了啊，进来坐。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "往窝边扫了一眼，目光停了停",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "还在查吧？有什么我能帮上的，说一声。",
    UnlockBranches = {
        { NpcName = "淑芬", BranchId = 2 }
    },
    Next = -1  -- 下一段对话ID
}


-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大树？",
    Next = 2 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "你踩到我的根了。",
    Next = 3 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "哦，对不起。",
    Next = 4 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "……",
    Next = 5 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "无趣。",
    Next = 6 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大树，农场里出大事了，你知道吗？",
    Next = 7 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "吵。",
    Next = 8 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "什么吵？",
    Next = 9 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "你说话，吵。",
    Next = 10 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大树你每天在这里，能看到什么？",
    Next = 11 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "凡人……看见的永远是自己想看见的。",
    Next = 12 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……大树，这话有点深。",
    Next = 13 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "走吧。",
    ConditionBranches = {
        { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2, Next = 14 }
    },
    Next = -1 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大树，谷仓屋顶上是不是有什么东西？",
    Next = 15 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "屋顶那只蠢东西……",
    Next = 16 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "还守着他的宝贝呢。",
    Next = 17 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "什么宝贝？",
    Next = 18 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "有什么好守的。",
    Next = 19 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你是说乌鸦吗？",
    Next = 20 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "本树不指名道姓。",
    Next = -1 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大树，你有没有听到什么奇怪的声音？",
    ConditionBranches = {
        { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2, Next = 22 }
    },
    Next = -1 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "谷仓顶上那个，今天又叫……",
    Next = 23 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谁在叫？",
    Next = 24 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "你说他叫什么叫。每天凌晨四点，已经三年了。",
    Next = 25 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "大树",
    NpcSprite = "",
    Dialogue = "……走吧。",
    Next = -1 -- 下一段对话ID
}

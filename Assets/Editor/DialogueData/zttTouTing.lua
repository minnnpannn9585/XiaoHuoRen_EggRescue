-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（压声）昨晚那声音……肯定是水怪……",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（压声）池塘那边……青蛙还说宝珠沉下去了……",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（极小声）……可是大前天……明明是我们……",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（压声）瓜子！别说了！",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（压声）那要是有人来问……",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（发抖）……水怪。从池塘来的。把蛋叼走了……",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（压声）只能是这样……不然弟弟怎么不见了……",
    SetVariables = {
        { VarName = "E03_Overheard", VarType = "bool", Value = true }
    },
    Next = -1  -- 下一段对话ID
}


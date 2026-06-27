-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "嘿，你们在干什么？",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡挤在鸡舍边，纸板墨镜歪着）",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）有人来了……",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "别、别看他……",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满往前挪了半步，又停住）",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬的蛋不见了，你们知道吗？",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满墨镜滑到喙尖）",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（极小声）弟弟……",
    Next = 10  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（急）别乱叫！",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满把墨镜顶回去）",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们……暗影侦探团……也在查。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "这事很大。你最好别乱插手。",
    Next = 14  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "能告诉我点什么吗？",
    Next = 15  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆拽了拽阿满翅膀）",
    Next = 16  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 17  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "内部情报。不能说。",
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "总得说点什么吧。",
    Next = 19  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（米粒和豆豆对视一眼）",
    Next = 20  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "……我们是侦探。",
    Next = 21  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "对。很忙的。",
    Next = 22  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（瓜子低着头，喙动了动，没出声）",
    UnlockBranches = {
        { NpcName = "小鸡侦探团", BranchId = 2 }
    },
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 1 }
    },
    Next = 23  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[23] = {
    Type = "Question",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……在查。别碰我们的现场。",
    Options = {  -- 选项列表
        {Text = "没事，走了。", Next = -1, BranchFlag = "Branch_A"}
    }
}


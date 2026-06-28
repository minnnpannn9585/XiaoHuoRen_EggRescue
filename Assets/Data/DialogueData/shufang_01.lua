-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "鸡舍门口，一只母鸡正站着，忽然抬起头来",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "哎——你等一下！",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "帮个忙行不行？我找不到孩儿了——",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "往鸡窝方向领了一步，又回头张望",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "画了爱心标记的那颗蛋，今早发现没了。",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "其他孩子出壳都好几天了，就这最小的——迟迟没动静，我一直守着它。",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "昨晚前还动过一下，那种感觉……我不可能认错的。",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停了停，看了看天",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "最近天骤然凉了，我就担心——",
    Next = 10  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "主人也来看了好几回，来的比我还频繁，就那样站着不说话。",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你帮我找找吧，行吗？",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "好，我来帮你找找。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "谢谢你，真的。有什么要问的随时来找我——农场的事，我比谁都熟。",
    UnlockBranches = {
        { NpcName = "淑芬", BranchId = 2 }
    },
    SetVariables = {
        { VarName = "Shufen_CommissionDone", VarType = "bool", Value = true }
    },
    Next = -1  -- 下一段对话ID
}


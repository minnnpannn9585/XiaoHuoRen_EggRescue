-- 对话配置文件
DialogueConfig = {}

-- ==================== 2-hub-intro · 入口判定 ====================

DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Op = "==", Value = false },
        { Next = 2 }
    },
    Next = 50
}

-- ==================== 2-hub-intro · 轮播组1（!Frog_WaterMonsterQueried） ====================

DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面纹丝不动）",
    Next = 3
}

DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "今天的水……跟昨天的水一样。",
    Next = 4
}

DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但昨天已经消失了。",
    Next = 5
}

DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "所以其实……不一样。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组1B ====================

DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你好。",
    Next = 11
}

DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "好什么。",
    Next = 12
}

DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面重归沉默）",
    Next = 13
}

DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……来过就是来过。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组1C ====================

DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "活着就是在等一个不会来的什么。",
    Next = 21
}

DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "等……什么？",
    Next = 22
}

DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "不知道。",
    Next = 23
}

DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但感觉就是在等。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组1D ====================

DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "农场里出事了……",
    Next = 31
}

DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "一直在出事。",
    Next = 32
}

DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "只是你们才刚注意到。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组2（Frog_WaterMonsterQueried） ====================

DialogueConfig[50] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙重新盯向水面，不再看过来）",
    Next = 51
}

DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "你已经知道了。",
    Next = 52
}

DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但知道了也没有用。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组2B ====================

DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……虚无不会因为被发现而消失。",
    Next = 70
}

-- ==================== 2-hub-intro · 轮播组2C ====================

DialogueConfig[65] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你还好吗？",
    Next = 66
}

DialogueConfig[66] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "还好，是一种很奢侈的状态。",
    Next = 70
}

-- ==================== 2-hub · 主菜单 ====================

DialogueConfig[70] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……",
    Next = 71
}

DialogueConfig[71] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "水怪……这池塘里真的有水怪？",
            Next = 80,
            DisplayConditions = {
                { VarName = "ChickStatus",              VarType = "int",  Op = ">=", Value = 2 },
                { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "这里有没有见过……一颗蛋？",
            Next = 100,
            DisplayConditions = {
                { VarName = "Shufen_CommissionDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "谷仓那边……你去过吗？",
            Next = 110,
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "……",
            Next = -1
        }
    }
}

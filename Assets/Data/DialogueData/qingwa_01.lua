-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（一股刺鼻的草本甜味，混着池水腥气）",
    Next = 2 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "……你来了。",
    Next = 3 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "或者……你只是路过这片死水。",
    Next = 4 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……这里是你的地方？",
    Next = 5 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "这里是虚无的地方。",
    Next = 6 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "坐了很久了。",
    UnlockBranches = {
        { NpcName = "悲伤蛙", BranchId = 2 }
    },
    SetVariables = {
        { VarName = "Frog_FirstMeetShown", VarType = "bool", Value = false }
    },
    ConditionBranches = {
        { VarName = "Frog_WaterMonsterQueried", VarType = "bool", TrueNext = 23, FalseNext = 7 }
    },
    Next = -1 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面纹丝不动）",
    Next = 8 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面纹丝不动）",
    Next = 9 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "今天的水……跟昨天的水一样。",
    Next = 10 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "但昨天已经消失了。",
    Next = 11 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "所以其实……不一样。",
    Next = 12 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你好。",
    Next = 13 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "好什么。",
    Next = 14 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面重归沉默）",
    Next = 15 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "……来过就是来过。",
    Next = 16 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "活着就是在等一个不会来的什么。",
    Next = 17 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "等……什么？",
    Next = 18 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "不知道。",
    Next = 19 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "但感觉就是在等。",
    Next = 20 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "农场里出事了……",
    Next = 21 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "一直在出事。",
    Next = 22 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "只是你们才刚注意到。",
    Next = 29 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙重新盯向水面，不再看过来）",
    Next = 24 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "你已经知道了。",
    Next = 25 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "但知道了也没有用。",
    Next = 26 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "……虚无不会因为被发现而消失。",
    Next = 27 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[27] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你还好吗？",
    Next = 28 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "还好，是一种很奢侈的状态。",
    Next = 29 -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "……",
    Next = 30 -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[30] = {
    Type = "Question",
    NpcName = "悲伤蛙",
    NpcSprite = "介入",
    Dialogue = "……还说？",
    Options = { -- 选项列表
        {
            Text = "水怪……这池塘里真的有水怪？",
            Next = 51,
            BranchFlag = "Branch_A",
            DisplayConditions = {
                { VarName = "ChickStatus",              VarType = "int",  Op = ">=", Value = 2 },
                { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "这里有没有见过……一颗蛋？",
            Next = 31,
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "Shufen_CommissionDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "谷仓那边……你去过吗？",
            Next = 41,
            BranchFlag = "Flag_3",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Op = "==", Value = true }
            }
        },
        { Text = "「……」（告辞）", Next = -1, BranchFlag = "Flag_4" }
    }
}

-- ==================== 2-B · 询问蛋 ====================

DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这里有没有见过……一颗蛋？",
    Next = 32
}

DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "蛋。",
    Next = 33
}

DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这片水里，早就没有新生了。",
    Next = 34
}

DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "所以是……有，还是没有？",
    Next = 35
}

DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "问错了地方。",
    Next = 30
}

-- ==================== 2-C · 谷仓闲聊 ====================

DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓那边……你去过吗？",
    Next = 42
}

DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "离水远的地方。",
    Next = 43
}

DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……连虚无都是干的。",
    Next = 30
}

-- ==================== 2-D · 水怪质询 ====================

DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "水怪……这池塘里真的有水怪？",
    Next = 52
}

DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙缓缓转头，目光第一次落过来，眼神不对焦）",
    Next = 53
}

DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "水怪。",
    Next = 54
}

DialogueConfig[54] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……没有水怪。",
    Next = 55
}

DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但有比水怪更令人心碎的东西。",
    Next = 56
}

DialogueConfig[56] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这片水……见证了连环的消逝。",
    Next = 57
}

DialogueConfig[57] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面平静，什么痕迹都没留下）",
    Next = 58
}

DialogueConfig[58] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "纯净，第一个死去。",
    Next = 59
}

DialogueConfig[59] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "然后……冰冷的器皿来了。",
    Next = 60
}

DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙低头，视线落在水面，久久不抬起来）",
    Next = 61
}

DialogueConfig[61] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "生命之源……在枯竭。",
    Next = 62
}

DialogueConfig[62] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "一个黑色的恶魔……",
    Next = 63
}

DialogueConfig[63] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙喉咙动了一下，沉默）",
    Next = 64
}

DialogueConfig[64] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "带走了宝珠。",
    Next = 65
}

DialogueConfig[65] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "什么都不剩。",
    Next = 66
}

DialogueConfig[66] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "神经病...",
    SetVariables = {
        { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Value = true }
    },
    Next = 30
}

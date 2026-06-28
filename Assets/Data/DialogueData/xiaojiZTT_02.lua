-- 对话配置文件
DialogueConfig = {}

-- 提问类型（玩家需要选择回答）
DialogueConfig[1] = {
    Type = "Question",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……在查。别碰我们的现场。",
    Options = {  -- 选项列表
        {  -- 选项#1
            Text = "你们到底在搞什么鬼？",
            Next = 28,
            BranchFlag = "Branch_A",
            DisplayConditions = {
                { VarName = "ChickTraceCount", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 1 }
            },
        },
        {  -- 选项#2
            Text = "谷仓角落有个草窝，你们知道是谁的吗？",
            Next = 49,
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Value = false },
                { VarName = "Chick_NapSpotAsked", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#3
            Text = "大黄宿醉成那样，有什么法子叫醒他吗？",
            Next = 55,
            BranchFlag = "Flag_3",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = "==", Value = 2 },
                { VarName = "Chick_WakeDogHintShown", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#4
            Text = "这玩意儿，你们怎么解释？",
            Next = 63,
            BranchFlag = "Flag_4",
            DisplayConditions = {
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "ChickStatus", VarType = "int", Op = "<", Value = 3 }
            },
        },
        {  -- 选项#5
            Text = "我准备上谷仓顶找乌鸦。",
            Next = 100,
            BranchFlag = "Flag_5",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "Chick_RoofBlockShown", VarType = "bool", Value = false }
            },
        },
        {Text = "没事，走了。", Next = -1, BranchFlag = "Flag_6"}
    }
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[2] = {
    Type = "Question",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "池塘那边……去了吗？",
    Options = {  -- 选项列表
        {  -- 选项#1
            Text = "谷仓角落有个草窝，你们知道是谁的吗？",
            Next = 49,
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Value = false },
                { VarName = "Chick_NapSpotAsked", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#2
            Text = "大黄宿醉成那样，有什么法子叫醒他吗？",
            Next = 55,
            BranchFlag = "Flag_3",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = "==", Value = 2 },
                { VarName = "Chick_WakeDogHintShown", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#3
            Text = "这玩意儿，你们怎么解释？",
            Next = 63,
            BranchFlag = "Flag_4",
            DisplayConditions = {
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "ChickStatus", VarType = "int", Op = "<", Value = 3 }
            },
        },
        {  -- 选项#4
            Text = "我准备上谷仓顶找乌鸦。",
            Next = 100,
            BranchFlag = "Flag_5",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "Chick_RoofBlockShown", VarType = "bool", Value = false }
            },
        },
        {Text = "没事，走了。", Next = -1, BranchFlag = "Flag_6"}
    }
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[3] = {
    Type = "Question",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……外勤停了。有事快说。",
    Options = {  -- 选项列表
        {  -- 选项#1
            Text = "谷仓角落有个草窝，你们知道是谁的吗？",
            Next = 49,
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Value = false },
                { VarName = "Chick_NapSpotAsked", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#2
            Text = "这玩意儿，你们怎么解释？",
            Next = 63,
            BranchFlag = "Flag_4",
            DisplayConditions = {
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "ChickStatus", VarType = "int", Op = "<", Value = 3 }
            },
        },
        {  -- 选项#3
            Text = "我准备上谷仓顶找乌鸦。",
            Next = 100,
            BranchFlag = "Flag_5",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = false },
                { VarName = "Chick_RoofBlockShown", VarType = "bool", Value = false }
            },
        },
        {Text = "没事，走了。", Next = -1, BranchFlag = "Flag_6"}
    }
}

-- 普通对话类型
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你们到底在搞什么鬼？",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 2 }
    },
    Next = 29  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满脖子一缩）",
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……那是……",
    Next = 31  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "工具……",
    Next = 32  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "鸡舍边上那些乱七八糟的痕迹——和你们有关吧。",
    Next = 33  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡挤得更紧）",
    Next = 34  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（瓜子突然发抖）",
    Next = 35  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（哭腔）水怪……水怪把弟弟……",
    Next = 36  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[36] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "对！！就是水怪！！",
    Next = 37  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[37] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满朝池塘方向猛点头）",
    Next = 38  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[38] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "三个脑袋！浑身绿色！",
    Next = 39  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[39] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "从池塘来！把蛋拖进水里了！！",
    Next = 40  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[40] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你亲眼看见的？",
    Next = 41  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "没、没看见……但肯定是！！",
    Next = 42  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "昨晚外面那声音……青蛙也说了……",
    Next = 43  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（发颤）不然弟弟怎么不见了……",
    Next = 44  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[44] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "池塘那只青蛙肯定见过！！",
    Next = 45  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[45] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "快去问他！！求你快去！！",
    Next = 46  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[46] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满墨镜歪了，顾不上扶）",
    Next = 47  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[47] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "你去池塘……快去……",
    Next = 48  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[48] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（小声）找弟弟……",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 2 }
    },
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[49] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓角落有个草窝，你们知道是谁的吗？",
    Next = 50  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[50] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "谷仓角落？",
    Next = 51  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满皱眉）",
    Next = 52  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们没去过那边。",
    Next = 53  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "不是我们的地盘。",
    Next = 54  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[54] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "对。",
    SetVariables = {
        { VarName = "Chick_NapSpotAsked", VarType = "bool", Value = false }
    },
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄宿醉成那样，有什么法子叫醒他吗？",
    Next = 56  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[56] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆蹦了一下，墨镜歪了）",
    Next = 57  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[57] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "大黄叔叔？！他还没醒？！",
    Next = 58  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[58] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满按住豆豆）",
    Next = 59  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[59] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……嗯。",
    Next = 60  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满压低声音，翅膀尖抖了一下）",
    Next = 61  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[61] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "鸡舍水槽边有老谷物泡水。\n他爱喝。灌下去就能醒。",
    Next = 62  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[62] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（小声）……这次能帮上忙吗？",
    SetVariables = {
        { VarName = "Chick_WakeDogHintShown", VarType = "bool", Value = false }
    },
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[63] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你们猜，我千辛万苦爬上去，在乌鸦那找到什么了？",
    Next = 64  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[64] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡对视，谁也不说话）",
    Next = 65  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[65] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "……蛋？",
    Next = 66  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[66] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "说！这是什么！怎么回事！",
    Next = 67  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[67] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡凑过来，又猛地僵住）",
    Next = 68  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[68] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "……是我们画的。",
    Next = 69  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[69] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（墨镜啪嗒落地）",
    Next = 70  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[70] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "那不是老妈的蛋……乌鸦叼走的是假的……",
    Next = 71  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[71] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哭）那弟弟呢——弟弟到底在哪——",
    Next = 72  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[72] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满翅膀捂住脸）",
    Next = 73  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[73] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "呜呜呜——我招了！！",
    Next = 74  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[74] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "从头说。",
    Next = 75  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[75] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "大前天下午，我们捡了块白石头，画成蛋，把弟弟偷出来——",
    Next = 76  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[76] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）踢球。",
    Next = 77  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[77] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "踢……球？什么球？踢得哪个球？",
    Next = 78  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[78] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（几只小鸡低头不语）",
    Next = 79  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[79] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "然后呢？",
    Next = 80  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[80] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "推着弟弟路过谷仓的时候，老鼠叔叔蹿出来，说有沼泽水怪，晚上爬出来，专门吃沾了泥土的蛋！",
    Next = 81  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[81] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（气鼓鼓）现在想起来他们全程在憋笑！！",
    Next = 82  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[82] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们跑去池塘边把弟弟洗干净，青蛙在说我们听不懂的很吓人很吓人的话",
    Next = 83  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[83] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "吓得我们马上把真蛋推回窝里了！！",
    Next = 84  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[84] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "假石头呢？",
    Next = 85  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[85] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "大前天下午扔草丛里了……",
    Next = 86  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[86] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（小声）看来是被乌鸦叼走了……",
    Next = 87  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[87] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄说他昨天下午看见乌鸦叼走了一颗蛋——",
    Next = 88  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[88] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡对视）",
    Next = 89  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[89] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "昨天……？",
    Next = 90  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[90] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "大黄叔叔都喝了两天了，他昨天还醉着呢，哪能看见什么乌鸦呀。",
    Next = 91  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[91] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哭）那根本不是同一件事——！！",
    Next = 92  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[92] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "弟弟昨晚才不见的！",
    Next = 93  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[93] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "昨晚有什么动静吗？",
    Next = 94  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[94] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "睡前还在……半夜发现窝空了……",
    Next = 95  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[95] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "有好响好响的声音……我们以为是水怪来了……",
    Next = 96  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[96] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哭）没有水怪……那是什么声音……到底是谁带走了弟弟？",
    Next = 97  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[97] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满瘫坐）",
    Next = 98  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[98] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "……以后再也不偷弟弟出去踢球了。",
    Next = 99  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[99] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（鸡舍里很安静）",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 3 }
    },
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[100] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我准备上谷仓顶找乌鸦。",
    Next = 101  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[101] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "啊？谷仓有什么？",
    Next = 102  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[102] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄亲眼看见的——今早，乌鸦从草丛叼走了一颗白色的蛋，飞上了谷仓顶。",
    Next = 103  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[103] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡僵住）",
    Next = 104  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[104] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……草丛？",
    Next = 105  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[105] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）白色的……",
    Next = 106  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[106] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "是啊，乌鸦现在还守在上面。我得上去看看。",
    Next = 107  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[107] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满和米粒、豆豆、瓜子对视）",
    Next = 108  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[108] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆嘴张了张，没出声）",
    Next = 109  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[109] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 110  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[110] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（极小声）那个……是不是……",
    Next = 111  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[111] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（急）瓜子——！",
    Next = 112  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[112] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "什么？",
    Next = 113  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[113] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡一起闭嘴了）",
    SetVariables = {
        { VarName = "Chick_RoofBlockShown", VarType = "bool", Value = false }
    },
    Next = 2  -- 下一段对话ID
}


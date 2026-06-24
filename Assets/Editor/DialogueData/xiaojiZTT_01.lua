-- 对话配置文件
DialogueConfig = {}

-- ==================== 一、主交互阶段 ====================

-- 2-A · 首次接触
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "嘿，你们在干什么？",
    Next = 2
}

DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡挤在鸡舍边，纸板墨镜歪着）",
    Next = 3
}

DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）有人来了……",
    Next = 4
}

DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "别、别看他……",
    Next = 5
}

DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满往前挪了半步，又停住）",
    Next = 6
}

DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 7
}

DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬的蛋不见了，你们知道吗？",
    Next = 8
}

DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满墨镜滑到喙尖）",
    Next = 9
}

DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（极小声）弟弟……",
    Next = 10
}

DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（急）别乱叫！",
    Next = 11
}

DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满把墨镜顶回去）",
    Next = 12
}

DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们……暗影侦探团……也在查。",
    Next = 13
}

DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "这事很大。你最好别乱插手。",
    Next = 14
}

DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "能告诉我点什么吗？",
    Next = 15
}

DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆拽了拽阿满翅膀）",
    Next = 16
}

DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 17
}

DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "内部情报。不能说。",
    Next = 18
}

DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "总得说点什么吧。",
    Next = 19
}

DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（米粒和豆豆对视一眼）",
    Next = 20
}

DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "……我们是侦探。",
    Next = 21
}

DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "对。很忙的。",
    Next = 22
}

DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（瓜子低着头，喙动了动，没出声）",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 1 }
    },
    Next = 23  -- 跳转至 2-hub
}

-- 2-hub · 主菜单 hub 入口判定
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 1, Next = 24 },
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 2, Next = 25 },
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 3, Next = 26 }
    },
    Next = 24  -- 默认 ChickStatus==1
}

-- 【回访】ChickStatus==1
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……在查。别碰我们的现场。",
    Next = 27  -- 跳转至菜单
}

-- 【回访】ChickStatus==2
DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "池塘那边……去了吗？",
    Next = 27  -- 跳转至菜单
}

-- 【回访】ChickStatus==3
DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……外勤停了。有事快说。",
    Next = 27  -- 跳转至菜单
}

-- 【菜单】主菜单
DialogueConfig[27] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "你们到底在搞什么鬼？",
            Next = 28,  -- 2-B
            BranchFlag = "Branch_A",
            DisplayConditions = {
                { VarName = "ChickTraceCount", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 1 }
            }
        },
        {
            Text = "谷仓角落有个草窝，你们知道是谁的吗？",
            Next = 44,  -- 2-C
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Op = "==", Value = true },
                { VarName = "Chick_NapSpotAsked", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "大黄宿醉成那样，有什么法子叫醒他吗？",
            Next = 51,  -- 2-D
            BranchFlag = "Flag_3",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = "==", Value = 2 },
                { VarName = "Chick_WakeDogHintShown", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "这玩意儿，你们怎么解释？",
            Next = 60,  -- 2-E
            BranchFlag = "Flag_4",
            DisplayConditions = {
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Op = "==", Value = true },
                { VarName = "ChickStatus", VarType = "int", Op = "<", Value = 3 }
            }
        },
        {
            Text = "我准备上谷仓顶找乌鸦。",
            Next = 91,  -- 2-F
            BranchFlag = "Flag_5",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Op = "==", Value = false },
                { VarName = "Chick_RoofBlockShown", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "没事，走了。",
            Next = -1,  -- 对话结束
            BranchFlag = "Flag_6"
        }
    }
}

-- ==================== 2-B · 水怪说质询 ====================
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你们到底在搞什么鬼？",
    Next = 29
}

DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满脖子一缩）",
    Next = 30
}

DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……那是……",
    Next = 31
}

DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "工具……",
    Next = 32
}

DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "鸡舍边上那些乱七八糟的痕迹——和你们有关吧。",
    Next = 33
}

DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡挤得更紧）",
    Next = 34
}

DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（瓜子突然发抖）",
    Next = 35
}

DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（哭腔）水怪……水怪把弟弟……",
    Next = 36
}

DialogueConfig[36] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "对！！就是水怪！！",
    Next = 37
}

DialogueConfig[37] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满朝池塘方向猛点头）",
    Next = 38
}

DialogueConfig[38] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "三个脑袋！浑身绿色！",
    Next = 39
}

DialogueConfig[39] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "从池塘来！把蛋拖进水里了！！",
    Next = 40
}

DialogueConfig[40] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你亲眼看见的？",
    Next = 41
}

DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "没、没看见……但肯定是！！",
    Next = 42
}

DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（发颤）不然弟弟怎么不见了……",
    Next = 43
}

DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "你去池塘……快去……\n（小声）找弟弟……",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 2 }
    },
    Next = 23  -- 返回 2-hub
}

-- ==================== 2-C · 谷仓午睡点 ====================
DialogueConfig[44] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓角落有个草窝，你们知道是谁的吗？",
    Next = 45
}

DialogueConfig[45] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "谷仓角落？",
    Next = 46
}

DialogueConfig[46] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满皱眉）",
    Next = 47
}

DialogueConfig[47] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们没去过那边。",
    Next = 48
}

DialogueConfig[48] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "不是我们的地盘。",
    Next = 49
}

DialogueConfig[49] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "对。",
    SetVariables = {
        { VarName = "Chick_NapSpotAsked", VarType = "bool", Value = true }
    },
    Next = 23  -- 返回 2-hub
}

-- ==================== 2-D · 叫醒大黄 ====================
DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄宿醉成那样，有什么法子叫醒他吗？",
    Next = 52
}

DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆蹦了一下，墨镜歪了）",
    Next = 53
}

DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "大黄叔叔？！他还没醒？！",
    Next = 54
}

DialogueConfig[54] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满按住豆豆）",
    Next = 55
}

DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……嗯。",
    Next = 56
}

DialogueConfig[56] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满压低声音，翅膀尖抖了一下）",
    Next = 57
}

DialogueConfig[57] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "鸡舍水槽边有老谷物泡水。",
    Next = 58
}

DialogueConfig[58] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "他爱喝。灌下去就能醒。",
    Next = 59
}

DialogueConfig[59] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（小声）……这次能帮上忙吗？",
    SetVariables = {
        { VarName = "Chick_WakeDogHintShown", VarType = "bool", Value = true }
    },
    Next = 23  -- 返回 2-hub
}

-- ==================== 2-E · E10 质询招供 ====================
DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你们猜，我千辛万苦爬上去，在乌鸦那找到什么了？",
    Next = 61
}

DialogueConfig[61] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡对视，谁也不说话）",
    Next = 62
}

DialogueConfig[62] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "……蛋？",
    Next = 63
}

DialogueConfig[63] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "说！这是什么！怎么回事！",
    Next = 64
}

DialogueConfig[64] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡凑过来，又猛地僵住）",
    Next = 65
}

DialogueConfig[65] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "……是我们画的。",
    Next = 66
}

DialogueConfig[66] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（墨镜啪嗒落地）",
    Next = 67
}

DialogueConfig[67] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "那不是老妈的蛋……乌鸦叼走的是假的……",
    Next = 68
}

DialogueConfig[68] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哭）那弟弟呢——弟弟到底在哪——",
    Next = 69
}

DialogueConfig[69] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满翅膀捂住脸）",
    Next = 70
}

DialogueConfig[70] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "呜呜呜——我招了！！",
    Next = 71
}

DialogueConfig[71] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "从头说。",
    Next = 72
}

DialogueConfig[72] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "大前天下午，我们捡了块白石头，画成蛋，把弟弟偷出来——",
    Next = 73
}

DialogueConfig[73] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）踢球。",
    Next = 74
}

DialogueConfig[74] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "踢……球？什么球？踢得哪个球？",
    Next = 75
}

DialogueConfig[75] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（几只小鸡低头不语）",
    Next = 76
}

DialogueConfig[76] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "然后呢？",
    Next = 77
}

DialogueConfig[77] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "推着弟弟路过谷仓的时候，老鼠叔叔蹿出来，说有沼泽水怪，晚上爬出来，专门吃沾了泥土的蛋！",
    Next = 78
}

DialogueConfig[78] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（气鼓鼓）现在想起来他们全程在憋笑！！",
    Next = 79
}

DialogueConfig[79] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "我们跑去池塘边把弟弟洗干净，青蛙在说我们听不懂的很吓人很吓人的话",
    Next = 80
}

DialogueConfig[80] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "吓得我们马上把真蛋推回窝里了！！",
    Next = 81
}

DialogueConfig[81] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "假石头呢？",
    Next = 82
}

DialogueConfig[82] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "大前天下午扔草丛里了……",
    Next = 83
}

DialogueConfig[83] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（小声）看来是被乌鸦叼走了……",
    Next = 84
}

DialogueConfig[84] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄说他昨天下午看见乌鸦叼走了一颗蛋——",
    Next = 85
}

DialogueConfig[85] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡对视）",
    Next = 86
}

DialogueConfig[86] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "昨天……？",
    Next = 87
}

DialogueConfig[87] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "大黄叔叔都喝了两天了，他昨天还醉着呢，哪能看见什么乌鸦呀。",
    Next = 88
}

DialogueConfig[88] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哭）那根本不是同一件事——！！",
    Next = 89
}

DialogueConfig[89] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "弟弟昨晚才不见的！\n没有水怪……那是什么声音……到底是谁带走了弟弟？",
    Next = 90
}

DialogueConfig[90] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满瘫坐）\n瓜子：……以后再也不偷弟弟出去踢球了。\n（鸡舍里很安静）",
    SetVariables = {
        { VarName = "ChickStatus", VarType = "int", Value = 3 }
    },
    Next = 23  -- 返回 2-hub
}

-- ==================== 2-F · 拦路上顶 ====================
DialogueConfig[91] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我准备上谷仓顶找乌鸦。",
    Next = 92
}

DialogueConfig[92] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "啊？谷仓有什么？",
    Next = 93
}

DialogueConfig[93] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄亲眼看见的——今早，乌鸦从草丛叼走了一颗白色的蛋，飞上了谷仓顶。",
    Next = 94
}

DialogueConfig[94] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡僵住）",
    Next = 95
}

DialogueConfig[95] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……草丛？",
    Next = 96
}

DialogueConfig[96] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "（小声）白色的……",
    Next = 97
}

DialogueConfig[97] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "是啊，乌鸦现在还守在上面。我得上去看看。",
    Next = 98
}

DialogueConfig[98] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满和米粒、豆豆、瓜子对视）",
    Next = 99
}

DialogueConfig[99] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆嘴张了张，没出声）",
    Next = 100
}

DialogueConfig[100] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……",
    Next = 101
}

DialogueConfig[101] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（极小声）那个……是不是……",
    Next = 102
}

DialogueConfig[102] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（急）瓜子——！",
    Next = 103
}

DialogueConfig[103] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "什么？",
    Next = 104
}

DialogueConfig[104] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡一起闭嘴了）",
    SetVariables = {
        { VarName = "Chick_RoofBlockShown", VarType = "bool", Value = true }
    },
    Next = 23  -- 返回 2-hub
}

-- ==================== 三、第二章 · 愧疚待命 ====================

-- 3-A · 愧疚待命入口判定
DialogueConfig[105] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "DogStatus", VarType = "int", Op = "==", Value = 4 },
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 3 },
        { VarName = "Chick_Chapter2GuiltShown", VarType = "bool", Op = "==", Value = false }
    },
    Next = 106,  -- 满足条件进入 3-A
    ElseNext = 23  -- 不满足条件返回 2-hub
}

-- 3-A · 轮播1
DialogueConfig[106] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（极小声）大侦探……",
    Next = 107
}

DialogueConfig[107] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（更小声）别看我……",
    Next = 108
}

DialogueConfig[108] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（压声）站好。",
    Next = 109
}

DialogueConfig[109] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬还在哭。",
    Next = 110
}

DialogueConfig[110] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……我们知道。",
    Next = 111
}

DialogueConfig[111] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（哭腔）是我们害的…",
    Next = 112
}

-- 3-A · 轮播2
DialogueConfig[112] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "大侦探。",
    Next = 113
}

DialogueConfig[113] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "嗯？",
    Next = 114
}

DialogueConfig[114] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "要是……要是弟弟真在红顶屋……",
    Next = 115
}

DialogueConfig[115] = {
    Type = "Normal",
    NpcName = "米粒",
    NpcSprite = "",
    Dialogue = "我们就去认错。",
    Next = 116
}

DialogueConfig[116] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（小声）……嗯。",
    Next = 117
}

DialogueConfig[117] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "还不确定。",
    Next = 118
}

DialogueConfig[118] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满点了一下头）",
    Next = 119
}

-- 3-A · 轮播3
DialogueConfig[119] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "后悔吗？",
    Next = 120
}

DialogueConfig[120] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡都不吭声）",
    Next = 121
}

DialogueConfig[121] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "……后悔。",
    Next = 122
}

DialogueConfig[122] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（哑）暗影侦探团……搞砸了。",
    Next = 123
}

DialogueConfig[123] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "水怪是假的。乌鸦那边也是石头。",
    Next = 124
}

DialogueConfig[124] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "别再提了。",
    SetVariables = {
        { VarName = "Chick_Chapter2GuiltShown", VarType = "bool", Value = true }
    },
    Next = -1  -- 对话结束
}

-- ==================== 二周目 ====================

-- NGPlus · 一次性
DialogueConfig[125] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡坐在鸡舍门口）\n（阿满墨镜搁在脚边）",
    Next = 126
}

DialogueConfig[126] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "……",
    Next = 127
}

DialogueConfig[127] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "来了。",
    Next = 128
}

DialogueConfig[128] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "弟弟出壳了。",
    Next = 129
}

DialogueConfig[129] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡抬头）",
    Next = 130
}

DialogueConfig[130] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "……出来了？",
    Next = 131
}

DialogueConfig[131] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "出来了。",
    Next = 132
}

DialogueConfig[132] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "……",
    Next = 133
}

DialogueConfig[133] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆扭头，翅膀蹭眼睛）",
    Next = 134
}

DialogueConfig[134] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "我没哭。",
    Next = 135
}

DialogueConfig[135] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "……我们一直知道他会没事。",
    Next = 136
}

DialogueConfig[136] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "是吗。",
    Next = 137
}

DialogueConfig[137] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "嗯。",
    Next = 138
}

DialogueConfig[138] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（低声）只是……当时太怕。",
    Next = 139
}

DialogueConfig[139] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "老鼠的水怪谎话呢？",
    Next = 140
}

DialogueConfig[140] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（豆豆翅膀举起）",
    Next = 141
}

DialogueConfig[141] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "要算！！",
    Next = 142
}

DialogueConfig[142] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（打断）……",
    Next = 143
}

DialogueConfig[143] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（阿满重新戴上墨镜）",
    Next = 144
}

DialogueConfig[144] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "暗影侦探团自有安排。",
    Next = 145
}

DialogueConfig[145] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "水怪是假的。这农场也没有沼泽。",
    Next = 146
}

DialogueConfig[146] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（小声）老鼠叔叔编过头了……",
    Next = 147
}

DialogueConfig[147] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（压声）豆豆。\n（米粒、豆豆、瓜子一起点头）",
    SetVariables = {
        { VarName = "Chick_NGPlusShown", VarType = "bool", Value = true }
    },
    Next = -1  -- 对话结束
}

-- NGPlus 回访 · 轮播1
DialogueConfig[148] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（四只小鸡排成一列，墨镜戴正了）",
    Next = 149
}

DialogueConfig[149] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "同行。",
    Next = 150
}

DialogueConfig[150] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "还有任务？",
    Next = 151
}

DialogueConfig[151] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "散步。",
    Next = 152
}

DialogueConfig[152] = {
    Type = "Normal",
    NpcName = "豆豆",
    NpcSprite = "",
    Dialogue = "（压声）顺便看老鼠在不在。",
    Next = 153
}

DialogueConfig[153] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "（压声）豆豆！！",
    Next = 154
}

-- NGPlus 回访 · 轮播2
DialogueConfig[154] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "新案子？",
    Next = 155
}

DialogueConfig[155] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "没有。",
    Next = 156
}

DialogueConfig[156] = {
    Type = "Normal",
    NpcName = "阿满",
    NpcSprite = "",
    Dialogue = "弟弟刚出壳。别出去疯。",
    Next = 157
}

DialogueConfig[157] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "嗯。",
    Next = 158
}

-- NGPlus 回访 · 轮播3
DialogueConfig[158] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（瓜子盯着鸡舍里）",
    Next = 159
}

DialogueConfig[159] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "看什么？",
    Next = 160
}

DialogueConfig[160] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "看弟弟。",
    Next = 161
}

DialogueConfig[161] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（窝里传来细弱的叫声）",
    Next = 162
}

DialogueConfig[162] = {
    Type = "Normal",
    NpcName = "瓜子",
    NpcSprite = "",
    Dialogue = "（小声）他刚才往这边看了。\n嗯。",
    Next = -1  -- 对话结束
}

-- ==================== 入口判定节点 ====================
-- 主入口 - 根据条件选择对话路径
DialogueConfig[999] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        -- 二周目一次性
        { VarName = "NGPlus", VarType = "bool", Op = "==", Value = true },
        { VarName = "Chick_NGPlusShown", VarType = "bool", Op = "==", Value = false },
        { Next = 125 }  -- NGPlus
    },
    ElseNext = 998
}

DialogueConfig[998] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        -- 二周目回访
        { VarName = "NGPlus", VarType = "bool", Op = "==", Value = true },
        { VarName = "Chick_NGPlusShown", VarType = "bool", Op = "==", Value = true },
        { Next = 148 }  -- NGPlus 回访
    },
    ElseNext = 997
}

DialogueConfig[997] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        -- 第二章愧疚待命
        { VarName = "DogStatus", VarType = "int", Op = "==", Value = 4 },
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 3 },
        { VarName = "Chick_Chapter2GuiltShown", VarType = "bool", Op = "==", Value = false },
        { Next = 106 }  -- 3-A
    },
    ElseNext = 996
}

DialogueConfig[996] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        -- 首次接触
        { VarName = "ChickStatus", VarType = "int", Op = "==", Value = 0 },
        { Next = 1 }  -- 2-A
    },
    ElseNext = 995
}

DialogueConfig[995] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        -- ChickStatus >= 1 进入 hub
        { VarName = "ChickStatus", VarType = "int", Op = ">=", Value = 1 },
        { Next = 23 }  -- 2-hub
    },
    ElseNext = 1  -- 默认进入首次接触
}
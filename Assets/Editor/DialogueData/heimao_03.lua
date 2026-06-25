-- 对话配置文件
DialogueConfig = {}

-- ==================== 1-C · 黑猫现身 ====================

DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（树冠剧烈颤动，一只黑猫从树上落地，毛发炸乱，白眼一翻）",
    Next = 2
}

DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "滚——开！",
    Next = 3
}

DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "没看到本喵正因感情欺骗疗伤吗？！",
    Next = 4
}

DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "等等……这声音……",
    Next = 5
}

DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你就是那棵大树！！",
    Next = 6
}

DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……是猫。",
    Next = 7
}

DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄压低声音）",
    Next = 8
}

DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "你跟大树说话了？",
    Next = 9
}

DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我以为……",
    Next = 10
}

DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫深吸一口气，抬爪梳了两下乱毛，没梳平，更烦）",
    Next = 11
}

DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那个该死的两脚兽！",
    Next = 12
}

DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "昨晚用温柔手法骗本喵——",
    Next = 13
}

DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他把本喵捧起来，本喵以为是要按摩——",
    Next = 14
}

DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "结果把本喵放在冰冷地板上！",
    Next = 15
}

DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "抢走本喵的御用软垫！",
    Next = 16
}

DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "啊……那挺过分的。",
    Next = 17
}

DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "还有你！",
    Next = 18
}

DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫视线漫不经心扫过大黄）",
    Next = 19
}

DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……地毯。",
    Next = 20
}

DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "什么？！",
    Next = 21
}

DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只鸟叫你的。",
    Next = 22
}

DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（停顿一秒）",
    Next = 23
}

DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "把树晃成那样？！这是什么不文明的手段？！",
    Next = 24
}

DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "不摇你不下来嘛。",
    Next = 25
}

DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫将视线缓缓滑向玩家，停住）",
    Next = 26
}

DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你又是谁？",
    Next = 27
}

DialogueConfig[27] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我是侦探，在调查淑芬的蛋失踪案。",
    Next = 28
}

DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "鸡的事，和本喵有什么关系。",
    Next = 29
}

DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫在大橡树根旁坐下，尾巴慢速扫地，一副不想理人的架子，但没有离开）",
    Next = 30
}

DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 31
}

-- ==================== 菜单 · 提问节点 ====================

DialogueConfig[31] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "蛋的线索指向红顶屋里面。",
            Next = 32,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "我还有新的线索要汇报。",
            Next = 56,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "谷仓角落那里……那个草窝，是你的吧。",
            Next = 57,
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot",          VarType = "bool", Op = "==", Value = true },
                { VarName = "E08_ViewBurnMark",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "有关你要我办的那件事。",
            Next = 75,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",        VarType = "bool", Op = "==", Value = false },
                { VarName = "Frog_PadRefused",          VarType = "bool", Op = "==", Value = true },
                { VarName = "Mouse_FrogFallbackGiven",  VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "找回来了。",
            Next = 93,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending",  VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 105,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Op = "==", Value = false },
                { VarName = "E10_ViewWhiteStone",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-B · 案情汇报线 · 开场必播 ====================

DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "蛋的线索指向红顶屋里面。",
    Next = 33
}

DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……说来听听。",
    Next = 34
}

DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵不承诺有反应。",
    Next = 35
}

DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬今天早上醒来，蛋不见了。",
    Next = 36
}

DialogueConfig[36] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……然后呢。",
    Next = 37
}

DialogueConfig[37] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "但窝里没有打斗迹象，没有外来气味，也没有拖拽痕迹。",
    Next = 38
}

DialogueConfig[38] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "没有闯入迹象。",
    Next = 39
}

DialogueConfig[39] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "自己跑走的？",
    Next = 40
}

DialogueConfig[40] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄的鼻子刚恢复，他说蛋的气味现在还从红顶屋里飘出来。",
    Next = 41
}

DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只蠢狗的鼻子，在这件事上倒是有用。",
    Next = 42
}

DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "还有昨晚悲伤蛙看见了什么——",
    Next = 43
}

DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "高大的两脚兽，带着冰冷的容器，把什么「生命之源」从池塘抽走了。",
    Next = 44
}

DialogueConfig[44] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……那只蛤蟆的措辞一向如诗如画。",
    Next = 45
}

DialogueConfig[45] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，眼神开始算什么）",
    Next = 46
}

DialogueConfig[46] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "但「冰冷的容器」和「生命之源」……",
    Next = 47
}

DialogueConfig[47] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "继续。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Value = true }
    },
    Next = 48
}

-- 条件分支节点
DialogueConfig[48] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "E17_ViewEmptyBucket", VarType = "bool", Op = "==", Value = false },
        { VarName = "E18_ViewBootprints",  VarType = "bool", Op = "==", Value = false },
        { Next = 49 }
    },
    Next = 52
}

-- 【条件】（!E17_ViewEmptyBucket && !E18_ViewBootprints）→ 对话结束
DialogueConfig[49] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你说主人昨晚出去过——有什么能证明？",
    Next = 50
}

DialogueConfig[50] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……我再去看看。",
    Next = 51
}

DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去吧。",
    Next = -1
}

-- 【条件】（E17_ViewEmptyBucket || E18_ViewBootprints）→ 2-B-hub
DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫眯起眼睛）",
    Next = 53
}

DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "看来你确实找到了些东西。",
    Next = 54
}

DialogueConfig[54] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "我还有新的线索要汇报。",
            Next = 56,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-B-hub · 回访菜单 ====================

-- 【回访】
DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 56
}

-- 【菜单】
DialogueConfig[56] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "门旁有个空水桶，桶底是池塘泥沙。",
            Next = 121,
            DisplayConditions = {
                { VarName = "E17_ViewEmptyBucket",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "门前的雨靴脚印，夜里朝鸡窝方向。",
            Next = 132,
            DisplayConditions = {
                { VarName = "E18_ViewBootprints",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_CaseLineBootSaid", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "先说到这儿。",
            Next = 136,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineBootSaid",   VarType = "bool", Op = "==", Value = false }
            }
        }
    }
}

-- ==================== 2-B-A · 空水桶汇报 ====================

DialogueConfig[121] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "红顶屋门旁有一个空水桶，桶底是池塘的泥沙。",
    Next = 122
}

DialogueConfig[122] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫的视线落在玩家身上，停了一秒）",
    Next = 123
}

DialogueConfig[123] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "冰冷的容器。",
    Next = 124
}

DialogueConfig[124] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "就是这个。",
    Next = 125
}

DialogueConfig[125] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那悲伤蛙昨晚看见的人——就在这栋屋子里。",
    Next = 126
}

DialogueConfig[126] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫尾巴慢了下来，不再扫地，只是压着）",
    Next = 127
}

-- 条件分支：缺雨靴脚印 → 卡点台词；有雨靴脚印 → 继续到顿悟
DialogueConfig[127] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    SetVariables = {
        { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", Value = true }
    },
    ConditionBranches = {
        { VarName = "E18_ViewBootprints", VarType = "bool", Op = "==", Value = false },
        { Next = 128 }
    },
    Next = 136
}

-- 卡点台词（缺雨靴脚印）
DialogueConfig[128] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "主人昨晚出去过。",
    Next = 129
}

DialogueConfig[129] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "只凭一个水桶，还不够。",
    Next = 130
}

DialogueConfig[130] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……我再去看看。",
    Next = 131
}

DialogueConfig[131] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去吧。",
    Next = 55
}

-- ==================== 2-B-B · 雨靴脚印汇报 ====================

DialogueConfig[132] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "还有红顶屋门前的雨靴脚印。",
    Next = 133
}

DialogueConfig[133] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "是夜里踩出来的，朝鸡窝方向走的。",
    Next = 134
}

DialogueConfig[134] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停住）",
    Next = 135
}

DialogueConfig[135] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "鸡窝。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineBootSaid", VarType = "bool", Value = true }
    },
    Next = 136
}

-- ==================== 2-B-D · 顿悟 ====================

DialogueConfig[136] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫一动不动，像是在走完最后一步）",
    Next = 137
}

DialogueConfig[137] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "昨晚，有人去池塘取了水。",
    Next = 138
}

DialogueConfig[138] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "然后，夜里去了鸡窝。",
    Next = 139
}

DialogueConfig[139] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "现在，蛋的气味从红顶屋里飘出来。",
    Next = 140
}

DialogueConfig[140] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（沉默）",
    Next = 141
}

DialogueConfig[141] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那家伙昨晚进鸡窝拿走了蛋。",
    Next = 142
}

DialogueConfig[142] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "带进了红顶屋。",
    Next = 143
}

DialogueConfig[143] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "但为什么？",
    Next = 144
}

DialogueConfig[144] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 145
}

DialogueConfig[145] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵也想知道。",
    Next = 146
}

DialogueConfig[146] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（站起来了一点，又坐回去）",
    Next = 147
}

DialogueConfig[147] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他在用那颗蛋做什么。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineDone", VarType = "bool", Value = true }
    },
    Next = 148
}

-- 条件分支：两条线都完成 → 2-E汇合；否则 → 2-hub
DialogueConfig[148] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true },
        { Next = 175 }
    },
    Next = 149
}

-- → 2-hub【回访】+【菜单】（未完成薄荷鱼线）
DialogueConfig[149] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "找回来了。",
            Next = 93,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending",  VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 105,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Op = "==", Value = false },
                { VarName = "E10_ViewWhiteStone",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-C · 草窝与焦痕 ====================

DialogueConfig[57] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓角落那里……那个草窝，是你的吧？",
    Next = 58
}

DialogueConfig[58] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "旁边还有烧焦的稻草和皮毛。",
    Next = 59
}

DialogueConfig[59] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫骤然抬眼，定住）",
    Next = 60
}

DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你怎么知道那个。",
    Next = 61
}

DialogueConfig[61] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那个焦痕是怎么回事？",
    Next = 62
}

DialogueConfig[62] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "还不是那只死鸟——",
    Next = 63
}

DialogueConfig[63] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（立刻收住）",
    Next = 64
}

DialogueConfig[64] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……但那件事跟你无关。",
    Next = 65
}

DialogueConfig[65] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，视线短暂飘向红顶屋墙缝方向，很快收回；尾巴尖弹动了一下）",
    Next = 66
}

DialogueConfig[66] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "跟老鼠有关系吗？",
    Next = 67
}

DialogueConfig[67] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你在乱猜什么。",
    Next = 68
}

DialogueConfig[68] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我帮你把这事办妥——你帮我开屋子。",
    Next = 69
}

DialogueConfig[69] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫沉默，眯起眼睛，打量玩家，停了很久）",
    Next = 70
}

DialogueConfig[70] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 71
}

DialogueConfig[71] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去找老鼠。",
    Next = 72
}

DialogueConfig[72] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "找回来再说。",
    SetVariables = {
        { VarName = "BlackCat_MintFishPending", VarType = "bool", Value = true }
    },
    Next = 73
}

-- → 2-hub【回访】+【菜单】
DialogueConfig[73] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    Next = 74
}

DialogueConfig[74] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "我还有新的线索要汇报。",
            Next = 55,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "有关你要我办的那件事。",
            Next = 75,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",        VarType = "bool", Op = "==", Value = false },
                { VarName = "Frog_PadRefused",          VarType = "bool", Op = "==", Value = true },
                { VarName = "Mouse_FrogFallbackGiven",  VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-C-D · 薄荷鱼任务进展 ====================

DialogueConfig[75] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "有关你要我办的那件事。",
    Next = 76
}

DialogueConfig[76] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫眼皮动了一下，仍蹲着）",
    Next = 77
}

DialogueConfig[77] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……说。",
    Next = 78
}

DialogueConfig[78] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你要的东西，我找到了。",
    Next = 79
}

DialogueConfig[79] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫耳朵竖起来，尾巴尖不受控地弹了一下）",
    Next = 80
}

DialogueConfig[80] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "在哪。",
    Next = 81
}

DialogueConfig[81] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "绿油油的，带着一股冲鼻子的草本甜气——",
    Next = 82
}

DialogueConfig[82] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "池塘里有只蛙一直坐在上面呢。",
    Next = 83
}

DialogueConfig[83] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫往前倾了半寸，瞳孔放大，又立刻坐正）",
    Next = 84
}

DialogueConfig[84] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……然后呢。",
    Next = 85
}

DialogueConfig[85] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我要不回来。",
    Next = 86
}

DialogueConfig[86] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你有办法吗？",
    Next = 87
}

DialogueConfig[87] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫顿住，胡须压平，一秒后又摆回傲慢脸）",
    Next = 88
}

DialogueConfig[88] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "为什么在蛤蟆那儿——本喵不知道。",
    Next = 89
}

DialogueConfig[89] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "拿不回来，就去找老鼠。",
    Next = 90
}

DialogueConfig[90] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他们肯定有办法。",
    Next = 91
}

-- → 2-hub【回访】+【菜单】
DialogueConfig[91] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    Next = 92
}

DialogueConfig[92] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "我还有新的线索要汇报。",
            Next = 55,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "有关你要我办的那件事。",
            Next = 75,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",        VarType = "bool", Op = "==", Value = false },
                { VarName = "Frog_PadRefused",          VarType = "bool", Op = "==", Value = true },
                { VarName = "Mouse_FrogFallbackGiven",  VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "找回来了。",
            Next = 93,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending",  VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 105,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Op = "==", Value = false },
                { VarName = "E10_ViewWhiteStone",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-D · 薄荷鱼交付 ====================

DialogueConfig[93] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "找回来了。",
    Next = 94
}

DialogueConfig[94] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（薄荷鱼递出）",
    Next = 95
}

DialogueConfig[95] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫耳朵竖起来，尾巴拍了两下——立刻压住）",
    Next = 96
}

DialogueConfig[96] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……哼。",
    Next = 97
}

DialogueConfig[97] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（慢慢走近，低头闻了一下，忍了一秒，吸了一大口——喉咙里半秒呼噜，骤然停住）",
    Next = 98
}

DialogueConfig[98] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "喵……就是这个——不对！",
    Next = 99
}

DialogueConfig[99] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（往后退半步，爪子压住鱼）",
    Next = 100
}

DialogueConfig[100] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "一条臭鱼，买不走本喵！",
    Next = 101
}

DialogueConfig[101] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "（小声）你刚才呼噜了……",
    Next = 102
}

DialogueConfig[102] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你耳朵出问题了。",
    SetVariables = {
        { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Value = true }
    },
    Next = 103
}

-- 条件分支：!BlackCat_CaseLineDone → 2-hub；BlackCat_CaseLineDone → 2-E
DialogueConfig[103] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_CaseLineDone", VarType = "bool", Op = "==", Value = false },
        { Next = 104 }
    },
    Next = 175
}

-- → 2-hub【回访】+【菜单】（!BlackCat_CaseLineDone）
DialogueConfig[104] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "我还有新的线索要汇报。",
            Next = 55,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "找回来了。",
            Next = 93,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending",  VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",         VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 105,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Op = "==", Value = false },
                { VarName = "E10_ViewWhiteStone",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 3-A · 白石头真相 ====================

DialogueConfig[105] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你上谷仓屋顶那次——是不是已经知道那是块石头？",
    Next = 106
}

DialogueConfig[106] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，舔了一下爪子）",
    Next = 107
}

DialogueConfig[107] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "嗯。早上窗台就看见了——乌鸦俯冲，白石头在晨光里闪着。",
    Next = 108
}

DialogueConfig[108] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫瞥了大黄一眼）",
    Next = 109
}

DialogueConfig[109] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "任何不瞎的都看得出来不是蛋。",
    Next = 110
}

DialogueConfig[110] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你为什么不说！！",
    Next = 111
}

DialogueConfig[111] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只乌鸦，每天早上四点开始嘎嘎嘎。",
    Next = 112
}

DialogueConfig[112] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "已经三年了。",
    Next = 113
}

DialogueConfig[113] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "让侦探多转几圈……本喵觉得相当公平。",
    Next = 114
}

DialogueConfig[114] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫偏头，眼神有一丝难以察觉的满意）",
    Next = 115
}

DialogueConfig[115] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵在树上不是说过吗？",
    Next = 116
}

DialogueConfig[116] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "「傻子在炫耀，瞎子在到处问。」",
    Next = 117
}

DialogueConfig[117] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……等等。",
    Next = 118
}

DialogueConfig[118] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那句话是在说乌鸦和我？！",
    Next = 119
}

DialogueConfig[119] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你以为本喵是在骂大树吗。",
    SetVariables = {
        { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Value = true }
    },
    Next = 120
}

-- → 2-hub【回访】+【菜单】
DialogueConfig[120] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "我还有新的线索要汇报。",
            Next = 55,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",    VarType = "bool", Op = "==", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 105,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Op = "==", Value = false },
                { VarName = "E10_ViewWhiteStone",        VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "该进去看看了。",
            Next = 175,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone",     VarType = "bool", Op = "==", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Op = "==", Value = true }
            }
        },
        {
            Text = "先不打扰你了。",
            Next = -1
        }
    }
}

-- ==================== 2-E · 汇合：起身去开窗 ====================

DialogueConfig[175] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "猫大爷，昨晚的事你清楚吗？",
    Next = 176
}

DialogueConfig[176] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄……",
    Next = 177
}

DialogueConfig[177] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "你可是被那个两脚兽当面骗了一手啊！",
    Next = 178
}

DialogueConfig[178] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "整个农场都看着你睡得呼呼的、还以为是要给你按摩——",
    Next = 179
}

DialogueConfig[179] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 180
}

DialogueConfig[180] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "——结果一觉醒来，软垫没了，自尊扫地！",
    Next = 181
}

DialogueConfig[181] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "这要是传出去，今年冬天你睡稻草堆里，我可不让你蹭我狗窝。",
    Next = 182
}

DialogueConfig[182] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫的尾巴猛地弹了一下，然后静止）",
    Next = 183
}

DialogueConfig[183] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（非常缓慢地，从蹲位站起来）",
    Next = 184
}

DialogueConfig[184] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（用眼神冻住大黄——大黄讪讪地把头转开）",
    Next = 185
}

DialogueConfig[185] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵不是因为那只发疯母鸡。",
    Next = 186
}

DialogueConfig[186] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "也不是因为这条蠢狗指使。",
    Next = 187
}

DialogueConfig[187] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（低头，用嘴叼起薄荷鱼）",
    Next = 188
}

DialogueConfig[188] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "就要亲眼进屋看清楚。",
    Next = 189
}

DialogueConfig[189] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那家伙昨晚到底拿本喵的软垫做了什么。",
    Next = 190
}

DialogueConfig[190] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "垫子去了哪里。",
    Next = 191
}

DialogueConfig[191] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那颗蛋呢？",
    Next = 192
}

DialogueConfig[192] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "至于你说的那颗破蛋——",
    Next = 193
}

DialogueConfig[193] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "既然它现在多半就在屋里，顺便看一眼也不亏。",
    Next = 194
}

DialogueConfig[194] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫走向猫门方向）",
    Next = 195
}

DialogueConfig[195] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（停住，回头）",
    Next = 196
}

DialogueConfig[196] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵有专属钥匙。你要进去——爬二层窗。",
    Next = 197
}

DialogueConfig[197] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵从里面推开。",
    Next = 198
}

DialogueConfig[198] = {
    Type = "Normal",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你不许走本喵的猫门。",
    Next = 199
}

DialogueConfig[199] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（叼着薄荷鱼，将钥匙从项圈取下，利落地钻进猫门）",
    Next = 200
}

DialogueConfig[200] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（片刻后——红屋顶二层的窗子被从内推开，传来一声清脆的「啪嗒」）",
    Next = -1
}

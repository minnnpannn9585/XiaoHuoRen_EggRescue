-- 对话配置文件
DialogueConfig = {}

-- ==================== 入口判定节点 ====================

DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "NGPlus",                   VarType = "bool", Op = "==", Value = true },
        { Next = 200 },
        { VarName = "Frog_FirstMeetShown",      VarType = "bool", Op = "==", Value = false },
        { Next = 2 },
        { VarName = "BlackCat_MintFishPending", VarType = "bool", Op = "==", Value = true },
        { VarName = "MintFish_Obtained",        VarType = "bool", Op = "==", Value = false },
        { Next = 120 }
    },
    Next = 30
}

-- ==================== 2-A · 首次对话 ====================

DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（一股刺鼻的草本甜味，混着池水腥气）",
    Next = 3
}

DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……你来了。",
    Next = 4
}

DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "或者……你只是路过这片死水。",
    Next = 5
}

DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……这里是你的地方？",
    Next = 6
}

DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这里是虚无的地方。",
    Next = 7
}

DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "坐了很久了。",
    SetVariables = {
        { VarName = "Frog_FirstMeetShown", VarType = "bool", Value = true }
    },
    Next = 30
}

-- ==================== 2-hub-intro · 点蛙人设轮播 ====================

DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Op = "==", Value = false },
        { Next = 31 }
    },
    Next = 50
}

DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面纹丝不动）",
    Next = 32
}

DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "今天的水……跟昨天的水一样。",
    Next = 33
}

DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但昨天已经消失了。",
    Next = 34
}

DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "所以其实……不一样。",
    Next = 70
}

DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你好。",
    Next = 36
}

DialogueConfig[36] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "好什么。",
    Next = 37
}

DialogueConfig[37] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面重归沉默）",
    Next = 38
}

DialogueConfig[38] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……来过就是来过。",
    Next = 70
}

DialogueConfig[39] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "活着就是在等一个不会来的什么。",
    Next = 40
}

DialogueConfig[40] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "等……什么？",
    Next = 41
}

DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "不知道。",
    Next = 42
}

DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但感觉就是在等。",
    Next = 70
}

DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "农场里出事了……",
    Next = 44
}

DialogueConfig[44] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "一直在出事。",
    Next = 45
}

DialogueConfig[45] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "只是你们才刚注意到。",
    Next = 70
}

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

DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……虚无不会因为被发现而消失。",
    Next = 70
}

DialogueConfig[54] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……你还好吗？",
    Next = 55
}

DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "还好，是一种很奢侈的状态。",
    Next = 70
}

-- ==================== 2-hub · 主菜单 hub ====================

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

DialogueConfig[72] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……还说？",
    Next = 71
}

-- ==================== 2-D · 水怪质询 ====================

DialogueConfig[80] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "水怪……这池塘里真的有水怪？",
    Next = 81
}

DialogueConfig[81] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙缓缓转头，目光第一次落过来，眼神不对焦）",
    Next = 82
}

DialogueConfig[82] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "水怪。",
    Next = 83
}

DialogueConfig[83] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……没有水怪。",
    Next = 84
}

DialogueConfig[84] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但有比水怪更令人心碎的东西。",
    Next = 85
}

DialogueConfig[85] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这片水……见证了连环的消逝。",
    Next = 86
}

DialogueConfig[86] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面平静，什么痕迹都没留下）",
    Next = 87
}

DialogueConfig[87] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "纯净，第一个死去。",
    Next = 88
}

DialogueConfig[88] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "然后……冰冷的器皿来了。",
    Next = 89
}

DialogueConfig[89] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙低头，视线落在水面，久久不抬起来）",
    Next = 90
}

DialogueConfig[90] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "生命之源……在枯竭。",
    Next = 91
}

DialogueConfig[91] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "一个黑色的恶魔……",
    Next = 92
}

DialogueConfig[92] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙喉咙动了一下，沉默）",
    Next = 93
}

DialogueConfig[93] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "带走了宝珠。",
    Next = 94
}

DialogueConfig[94] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "什么都不剩。",
    Next = 95
}

DialogueConfig[95] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "神经病...",
    SetVariables = {
        { VarName = "Frog_WaterMonsterQueried", VarType = "bool", Value = true }
    },
    Next = 72
}

-- ==================== 2-B · 可选闲聊 · 蛋 ====================

DialogueConfig[100] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这里有没有见过……一颗蛋？",
    Next = 101
}

DialogueConfig[101] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "蛋。",
    Next = 102
}

DialogueConfig[102] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这片水里，早就没有新生了。",
    Next = 103
}

DialogueConfig[103] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "所以是……有，还是没有？",
    Next = 104
}

DialogueConfig[104] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "问错了地方。",
    Next = 72
}

-- ==================== 2-C · 可选闲聊 · 谷仓 ====================

DialogueConfig[110] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓那边……你去过吗？",
    Next = 111
}

DialogueConfig[111] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "离水远的地方。",
    Next = 112
}

DialogueConfig[112] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……连虚无都是干的。",
    Next = 72
}

-- ==================== 3-hub-intro · 薄荷鱼阶段开场 ====================

DialogueConfig[120] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……又有东西来了。",
    Next = 121
}

DialogueConfig[121] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "或者……又有东西要走了。",
    Next = 122
}

-- ==================== 3-hub · 薄荷鱼阶段 hub ====================

DialogueConfig[122] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……",
    Next = 123
}

DialogueConfig[123] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        {
            Text = "你身下那块绿垫子……能给我吗？",
            Next = 130,
            DisplayConditions = {
                { VarName = "E12_ViewGreenPad",  VarType = "bool", Op = "==", Value = true },
                { VarName = "Frog_PadRefused",   VarType = "bool", Op = "==", Value = false },
                { VarName = "MintFish_Obtained", VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "你身下那块绿垫子……能给我吗？",
            Next = 130,
            DisplayConditions = {
                { VarName = "Mouse_MintFishPaid", VarType = "bool", Op = "==", Value = true },
                { VarName = "Frog_PadRefused",    VarType = "bool", Op = "==", Value = false },
                { VarName = "MintFish_Obtained",  VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "……我见过好多只跟你一样的蛙。",
            Next = 160,
            DisplayConditions = {
                { VarName = "Mouse_FrogFallbackGiven", VarType = "bool", Op = "==", Value = true },
                { VarName = "MintFish_Obtained",       VarType = "bool", Op = "==", Value = false }
            }
        },
        {
            Text = "……",
            Next = -1
        }
    }
}

DialogueConfig[124] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……嗯。",
    Next = 123
}

-- ==================== 3-A · 对暗号（三轮） ====================

DialogueConfig[130] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你身下那块绿垫子……能给我吗？",
    Next = 131
}

DialogueConfig[131] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙身下压着绿油油的东西，一阵草本甜气从那里飘过来）",
    Next = 132
}

DialogueConfig[132] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙低头看了一眼胯下，再抬头，眼神仍不对焦）",
    Next = 133
}

DialogueConfig[133] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……你来这里，是因为什么？",
    Next = 134
}

DialogueConfig[134] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        { Text = "我来拿你身下那块绿垫子。", Next = 150 },
        { Text = "因为我在找丢失的蛋。", Next = 150 },
        { Text = "……不知道。感觉到了，就来了。", Next = 135 }
    }
}

DialogueConfig[135] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙没有立刻回应，视线在水面上停了一会儿）",
    Next = 136
}

DialogueConfig[136] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "你懂什么叫失去吗？",
    Next = 137
}

DialogueConfig[137] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        { Text = "懂。丢了还能找回来。", Next = 150 },
        { Text = "懂。我丢过重要的东西。", Next = 150 },
        { Text = "……不懂。或者说，懂了又怎样。", Next = 138 }
    }
}

DialogueConfig[138] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙视线从水面慢慢移到胯下，又移回来）",
    Next = 139
}

DialogueConfig[139] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "它一直陪着我……直到现在。",
    Next = 140
}

DialogueConfig[140] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "",
    Options = {
        { Text = "那你留着吧。我不拿了。", Next = 150 },
        { Text = "但它现在该让人带走了。", Next = 150 },
        { Text = "……陪着，也是一种消耗。", Next = 141 }
    }
}

-- ==================== 3-B · 对暗号失败 ====================

DialogueConfig[150] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙重新盯向水面，不再看过来）",
    Next = 151
}

DialogueConfig[151] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……你不懂。",
    SetVariables = {
        { VarName = "Frog_PadRefused", VarType = "bool", Value = true }
    },
    Next = 124
}

-- ==================== 3-C · 成功交出薄荷鱼 ====================

DialogueConfig[141] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙缓缓挪动身体，绿色的东西从胯下露出来，草本甜气骤然加重）",
    Next = 142
}

DialogueConfig[142] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……拿去吧。",
    Next = 143
}

DialogueConfig[143] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "它散发着令人迷幻的腐朽气味……",
    Next = 144
}

DialogueConfig[144] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "就像生命流逝时……让人头晕目眩的气息。",
    Next = 145
}

DialogueConfig[145] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "既然你喜欢收集虚无……",
    Next = 146
}

DialogueConfig[146] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙重新望向水面，眼神比刚才更空）",
    Next = 147
}

DialogueConfig[147] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……那就都给你。",
    Next = 148
}

DialogueConfig[148] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这东西……你一直坐在上面？",
    Next = 149
}

DialogueConfig[149] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "它和我一样……正在腐烂。",
    Next = 150
}

DialogueConfig[151] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "但至少还留着气味。",
    Next = 152
}

DialogueConfig[152] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "证明曾经存在过。",
    Next = 153
}

DialogueConfig[153] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（一阵风，水面荡开，月影散了又聚）",
    SetVariables = {
        { VarName = "MintFish_Obtained", VarType = "bool", Value = true }
    },
    Next = 124
}

-- ==================== 3-D · 威胁路径「排第七」 ====================

DialogueConfig[160] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……我见过好多只跟你一样的蛙。",
    Next = 161
}

DialogueConfig[161] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙缓缓转头，目光第一次集中起来）",
    Next = 162
}

DialogueConfig[162] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……什么？",
    Next = 163
}

DialogueConfig[163] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "同款台词，同款姿势，同款池塘。",
    Next = 164
}

DialogueConfig[164] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你是这个地区的第七名。",
    Next = 165
}

DialogueConfig[165] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙发呆了好几秒，眼神出现了罕见的慌乱）",
    Next = 166
}

DialogueConfig[166] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……第七。",
    Next = 167
}

DialogueConfig[167] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（沉默）",
    Next = 168
}

DialogueConfig[168] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……第七？",
    Next = 169
}

DialogueConfig[169] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙低头，慢慢把身下的东西推了出来，不说话）",
    Next = 170
}

DialogueConfig[170] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙把身体偏向另一侧，不再看这边）",
    SetVariables = {
        { VarName = "MintFish_Obtained", VarType = "bool", Value = true }
    },
    Next = 124
}

-- ==================== NGPlus · 二周目轮播 ====================

DialogueConfig[200] = {
    Type = "Normal",
    NpcName = "",
    NpcSprite = "",
    Dialogue = "",
    Next = 201
}

DialogueConfig[201] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "宝珠……昨夜又浮上来了。",
    Next = 202
}

DialogueConfig[202] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "沉入深渊的，从来只是倒影。",
    Next = 203
}

DialogueConfig[203] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（水面平静，月影完整）",
    Next = -1
}

DialogueConfig[210] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙没有转头）",
    Next = 211
}

DialogueConfig[211] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "黑色的恶魔……也许只是恨自己的倒影。",
    Next = 212
}

DialogueConfig[212] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "恨的，不止它一个。",
    Next = -1
}

DialogueConfig[220] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "生命之源……仍在被舀走。",
    Next = 221
}

DialogueConfig[221] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "虚无依然存在。",
    Next = 222
}

DialogueConfig[222] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……案子破了。",
    Next = 223
}

DialogueConfig[223] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "破了什么案……虚无还是虚无。",
    Next = -1
}

DialogueConfig[230] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "那块腐朽浮木走了……",
    Next = 231
}

DialogueConfig[231] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "胯下冰凉。",
    Next = 232
}

DialogueConfig[232] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（蛙叹了一口气）",
    Next = 233
}

DialogueConfig[233] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……倒也契合。",
    Next = -1
}

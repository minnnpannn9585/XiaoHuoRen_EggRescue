-- 对话配置文件
-- 黑猫橡树下+揭穿+NGPlus（树状准稿）→ heimao_03_FROM_DOC.lua
-- Scene DialogueTrigger start ID should be 0 (entry dispatcher)
-- doc node map:
--   entry#0 -> DialogueConfig[0]
--   2-A -> DialogueConfig[1]
--   2-hub -> DialogueConfig[30]
--   2-E -> DialogueConfig[116]
--   3-B -> DialogueConfig[150]
--   2-F#E37 -> DialogueConfig[170]
--   2-F#E38 -> DialogueConfig[180]
--   NGPlus -> DialogueConfig[210]

DialogueConfig = {}

-- ==================== entry#0 ====================

DialogueConfig[0] = {
    Type = "Normal",
    DocTag = "entry#0",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "NGPlus", VarType = "bool", TrueNext = 210, FalseNext = 201 }
    },
    Next = 201
}

DialogueConfig[201] = {
    Type = "Normal",
    DocTag = "entry#comic",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "Comic_Revealed", VarType = "bool", TrueNext = 202, FalseNext = 203 }
    },
    Next = 203
}

DialogueConfig[202] = {
    Type = "Normal",
    DocTag = "entry#stone",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_StoneRevealShown", VarType = "bool", TrueNext = 203, FalseNext = 150 }
    },
    Next = 203
}

DialogueConfig[203] = {
    Type = "Normal",
    DocTag = "entry#2e1",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_CaseLineDone", VarType = "bool", TrueNext = 204, FalseNext = 205 }
    },
    Next = 205
}

DialogueConfig[204] = {
    Type = "Normal",
    DocTag = "entry#2e2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_MintFishLineDone", VarType = "bool", TrueNext = 207, FalseNext = 205 }
    },
    Next = 205
}

DialogueConfig[207] = {
    Type = "Normal",
    DocTag = "entry#2e3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_Entered", VarType = "bool", TrueNext = 205, FalseNext = 116 }
    },
    Next = 205
}

DialogueConfig[205] = {
    Type = "Normal",
    DocTag = "entry#hub1",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "Dog_BlackCatSummoned", VarType = "bool", TrueNext = 206, FalseNext = -1 }
    },
    Next = -1
}

DialogueConfig[206] = {
    Type = "Normal",
    DocTag = "entry#hub2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_Entered", VarType = "bool", TrueNext = -1, FalseNext = 30 }
    },
    Next = -1
}

-- 普通对话类型  -- doc:2-A#1
-- Position: { 9500, 150 }
DialogueConfig[1] = {
    Type = "Normal",
    DocTag = "2-A#1",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（树冠剧烈颤动，一只黑猫从树上落地，毛发炸乱，白眼一翻）",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#2
-- Position: { 9850, 150 }
DialogueConfig[2] = {
    Type = "Normal",
    DocTag = "2-A#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "滚——开！",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#3
-- Position: { 10200, 150 }
DialogueConfig[3] = {
    Type = "Normal",
    DocTag = "2-A#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "没看到本喵正因感情欺骗疗伤吗？！",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#4
-- Position: { 10550, 150 }
DialogueConfig[4] = {
    Type = "Normal",
    DocTag = "2-A#4",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "等等……这声音……",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#5
-- Position: { 10900, 150 }
DialogueConfig[5] = {
    Type = "Normal",
    DocTag = "2-A#5",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你就是那棵大树！！",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#6
-- Position: { 11250, 150 }
DialogueConfig[6] = {
    Type = "Normal",
    DocTag = "2-A#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……是猫。",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#7
-- Position: { 11600, 150 }
DialogueConfig[7] = {
    Type = "Normal",
    DocTag = "2-A#7",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄压低声音）",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#8
-- Position: { 11950, 150 }
DialogueConfig[8] = {
    Type = "Normal",
    DocTag = "2-A#8",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "你跟大树说话了？",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#9
-- Position: { 12300, 150 }
DialogueConfig[9] = {
    Type = "Normal",
    DocTag = "2-A#9",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我以为……",
    Next = 10  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#10
-- Position: { 12650, 150 }
DialogueConfig[10] = {
    Type = "Normal",
    DocTag = "2-A#10",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫深吸一口气，抬爪梳了两下乱毛，没梳平，更烦）",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#11
-- Position: { 13000, 150 }
DialogueConfig[11] = {
    Type = "Normal",
    DocTag = "2-A#11",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那个该死的两脚兽！",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#12
-- Position: { 13350, 150 }
DialogueConfig[12] = {
    Type = "Normal",
    DocTag = "2-A#12",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "昨晚用温柔手法骗本喵——",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#13
-- Position: { 13700, 150 }
DialogueConfig[13] = {
    Type = "Normal",
    DocTag = "2-A#13",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他把本喵捧起来，本喵以为是要按摩——",
    Next = 14  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#14
-- Position: { 14050, 150 }
DialogueConfig[14] = {
    Type = "Normal",
    DocTag = "2-A#14",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "结果把本喵放在冰冷地板上！",
    Next = 15  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#15
-- Position: { 14400, 150 }
DialogueConfig[15] = {
    Type = "Normal",
    DocTag = "2-A#15",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "抢走本喵的御用软垫！",
    Next = 16  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#16
-- Position: { 14750, 150 }
DialogueConfig[16] = {
    Type = "Normal",
    DocTag = "2-A#16",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "啊……那挺过分的。",
    Next = 17  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#17
-- Position: { 15100, 150 }
DialogueConfig[17] = {
    Type = "Normal",
    DocTag = "2-A#17",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "还有你！",
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#18
-- Position: { 15450, 150 }
DialogueConfig[18] = {
    Type = "Normal",
    DocTag = "2-A#18",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫视线漫不经心扫过大黄）",
    Next = 19  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#19
-- Position: { 15800, 150 }
DialogueConfig[19] = {
    Type = "Normal",
    DocTag = "2-A#19",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……地毯。",
    Next = 20  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#20
-- Position: { 16150, 150 }
DialogueConfig[20] = {
    Type = "Normal",
    DocTag = "2-A#20",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "什么？！",
    Next = 21  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#21
-- Position: { 16500, 150 }
DialogueConfig[21] = {
    Type = "Normal",
    DocTag = "2-A#21",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只鸟叫你的。",
    Next = 22  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#22
-- Position: { 16850, 150 }
DialogueConfig[22] = {
    Type = "Normal",
    DocTag = "2-A#22",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（停顿一秒）",
    Next = 23  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#23
-- Position: { 17200, 150 }
DialogueConfig[23] = {
    Type = "Normal",
    DocTag = "2-A#23",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "把树晃成那样？！这是什么不文明的手段？！",
    Next = 24  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#24
-- Position: { 17550, 150 }
DialogueConfig[24] = {
    Type = "Normal",
    DocTag = "2-A#24",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "不摇你不下来嘛。",
    Next = 25  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#25
-- Position: { 17900, 150 }
DialogueConfig[25] = {
    Type = "Normal",
    DocTag = "2-A#25",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫将视线缓缓滑向玩家，停住）",
    Next = 26  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#26
-- Position: { 18250, 150 }
DialogueConfig[26] = {
    Type = "Normal",
    DocTag = "2-A#26",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你又是谁？",
    Next = 27  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#27
-- Position: { 18600, 150 }
DialogueConfig[27] = {
    Type = "Normal",
    DocTag = "2-A#27",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我是侦探，在调查淑芬的蛋失踪案。",
    Next = 28  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#28
-- Position: { 18950, 150 }
DialogueConfig[28] = {
    Type = "Normal",
    DocTag = "2-A#28",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "鸡的事，和本喵有什么关系。",
    Next = 29  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-A#29
-- Position: { 19300, 150 }
DialogueConfig[29] = {
    Type = "Normal",
    DocTag = "2-A#29",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫在大橡树根旁坐下，尾巴慢速扫地，一副不想理人的架子，但没有离开）",
    Next = 30  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）  -- doc:2-hub
-- Position: { 19750, 150 }
DialogueConfig[30] = {
    Type = "Question",
    DocTag = "2-hub",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Options = {
        {
            Text = "蛋的线索指向红顶屋里面。",
            Next = 31,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone", VarType = "bool", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Value = false }
            },
        },
        {
            Text = "我还有新的线索要汇报。",
            Next = 50,
            DisplayConditions = {
                { VarName = "BlackCat_CaseLineDone", VarType = "bool", Value = false },
                { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Value = true }
            },
        },
        {
            Text = "谷仓角落那里……那个草窝，是你的吧。",
            Next = 74,
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Value = true },
                { VarName = "E08_ViewBurnMark", VarType = "bool", Value = true },
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Value = false }
            },
        },
        {
            Text = "有关你要我办的那件事。",
            Next = 90,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Value = true },
                { VarName = "MintFish_Obtained", VarType = "bool", Value = false },
                { VarName = "Frog_PadRefused", VarType = "bool", Value = true },
                { VarName = "Mouse_FrogFallbackGiven", VarType = "bool", Value = false }
            },
        },
        {
            Text = "找回来了。",
            Next = 106,
            DisplayConditions = {
                { VarName = "BlackCat_MintFishPending", VarType = "bool", Value = true },
                { VarName = "MintFish_Obtained", VarType = "bool", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Value = false }
            },
        },
        {
            Text = "你上谷仓屋顶那次——",
            Next = 135,
            DisplayConditions = {
                { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Value = false },
                { VarName = "E10_ViewWhiteStone", VarType = "bool", Value = true },
                { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Value = true }
            },
        },
        {
            Text = "先不打扰你了。",
            Next = -1,
        }
    }
}

-- 普通对话类型  -- doc:2-B#1
-- Position: { 20200, 50 }
DialogueConfig[31] = {
    Type = "Normal",
    DocTag = "2-B#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "蛋的线索指向红顶屋里面。",
    Next = 32  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#2
-- Position: { 20550, 50 }
DialogueConfig[32] = {
    Type = "Normal",
    DocTag = "2-B#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……说来听听。",
    Next = 33  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#3
-- Position: { 20900, 50 }
DialogueConfig[33] = {
    Type = "Normal",
    DocTag = "2-B#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵不承诺有反应。",
    Next = 34  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#4
-- Position: { 21250, 150 }
DialogueConfig[34] = {
    Type = "Normal",
    DocTag = "2-B#4",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "淑芬今天早上醒来，蛋不见了。",
    Next = 35  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#5
-- Position: { 21600, 150 }
DialogueConfig[35] = {
    Type = "Normal",
    DocTag = "2-B#5",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……然后呢。",
    Next = 36  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#6
-- Position: { 21950, 150 }
DialogueConfig[36] = {
    Type = "Normal",
    DocTag = "2-B#6",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "但窝里没有打斗迹象，没有外来气味，也没有拖拽痕迹。",
    Next = 37  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#7
-- Position: { 22300, 150 }
DialogueConfig[37] = {
    Type = "Normal",
    DocTag = "2-B#7",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "没有闯入迹象。",
    Next = 38  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#8
-- Position: { 22650, 150 }
DialogueConfig[38] = {
    Type = "Normal",
    DocTag = "2-B#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "自己跑走的？",
    Next = 39  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#9
-- Position: { 23000, 150 }
DialogueConfig[39] = {
    Type = "Normal",
    DocTag = "2-B#9",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄的鼻子刚恢复，他说蛋的气味现在还从红顶屋里飘出来。",
    Next = 40  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#10
-- Position: { 23350, 150 }
DialogueConfig[40] = {
    Type = "Normal",
    DocTag = "2-B#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只蠢狗的鼻子，在这件事上倒是有用。",
    Next = 41  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#11
-- Position: { 23700, 150 }
DialogueConfig[41] = {
    Type = "Normal",
    DocTag = "2-B#11",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "还有昨晚悲伤蛙看见了什么——",
    Next = 42  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#12
-- Position: { 24050, 150 }
DialogueConfig[42] = {
    Type = "Normal",
    DocTag = "2-B#12",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "高大的两脚兽，带着冰冷的容器，把什么「生命之源」从池塘抽走了。",
    Next = 43  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#13
-- Position: { 24400, 150 }
DialogueConfig[43] = {
    Type = "Normal",
    DocTag = "2-B#13",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……那只蛤蟆的措辞一向如诗如画。",
    Next = 44  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#14
-- Position: { 24750, 150 }
DialogueConfig[44] = {
    Type = "Normal",
    DocTag = "2-B#14",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，眼神开始算什么）",
    Next = 45  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#15
-- Position: { 25100, 150 }
DialogueConfig[45] = {
    Type = "Normal",
    DocTag = "2-B#15",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "但「冰冷的容器」和「生命之源」……",
    Next = 46  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B#16
-- Position: { 25450, 150 }
DialogueConfig[46] = {
    Type = "Normal",
    DocTag = "2-B#16",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "继续。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineStarted", VarType = "bool", Value = true }
    },
    Next = 460
}

DialogueConfig[460] = {
    Type = "Normal",
    DocTag = "2-B#gate1",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "E17_ViewEmptyBucket", VarType = "bool", TrueNext = 463, FalseNext = 461 }
    },
    Next = 461
}

DialogueConfig[461] = {
    Type = "Normal",
    DocTag = "2-B#gate2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "E18_ViewBootprints", VarType = "bool", TrueNext = 463, FalseNext = 47 }
    },
    Next = 47
}

DialogueConfig[463] = {
    Type = "Normal",
    DocTag = "2-B#gateHub",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    Next = 50
}

-- 普通对话类型  -- doc:2-B@cond#1
-- Position: { 20200, 330 }
DialogueConfig[47] = {
    Type = "Normal",
    DocTag = "2-B@cond#1",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你说主人昨晚出去过——有什么能证明？",
    Next = 48  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B@cond#2
-- Position: { 20550, 330 }
DialogueConfig[48] = {
    Type = "Normal",
    DocTag = "2-B@cond#2",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……我再去看看。",
    Next = 49  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B@cond#3
-- Position: { 20900, 330 }
DialogueConfig[49] = {
    Type = "Normal",
    DocTag = "2-B@cond#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去吧。",
    Next = -1  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）  -- doc:2-B-hub
-- Position: { 9500, 1980 }
DialogueConfig[50] = {
    Type = "Question",
    DocTag = "2-B-hub",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Options = {
        {
            Text = "门旁有个空水桶，桶底是池塘泥沙。",
            Next = 51,
            DisplayConditions = {
                { VarName = "E17_ViewEmptyBucket", VarType = "bool", Value = true },
                { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", Value = false }
            },
        },
        {
            Text = "门前的雨靴脚印，夜里朝鸡窝方向。",
            Next = 56,
            DisplayConditions = {
                { VarName = "E18_ViewBootprints", VarType = "bool", Value = true },
                { VarName = "BlackCat_CaseLineBootSaid", VarType = "bool", Value = false }
            },
        },
        {
            Text = "先说到这儿。",
            Next = 59,
        }
    }
}

-- 普通对话类型  -- doc:2-B-A#1
-- Position: { 21950, 880 }
DialogueConfig[51] = {
    Type = "Normal",
    DocTag = "2-B-A#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "门旁有个空水桶，桶底是池塘泥沙。",
    Next = 52  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-A#2
-- Position: { 22300, 880 }
DialogueConfig[52] = {
    Type = "Normal",
    DocTag = "2-B-A#2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫的视线落在玩家身上，停了一秒）",
    Next = 53  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-A#3
-- Position: { 22650, 880 }
DialogueConfig[53] = {
    Type = "Normal",
    DocTag = "2-B-A#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "冰冷的容器。就是这个。",
    Next = 54  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-A#4
-- Position: { 23000, 880 }
DialogueConfig[54] = {
    Type = "Normal",
    DocTag = "2-B-A#4",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那悲伤蛙昨晚看见的人——就在这栋屋子里。",
    Next = 55  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-A#5
-- Position: { 23350, 880 }
DialogueConfig[55] = {
    Type = "Normal",
    DocTag = "2-B-A#5",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫尾巴慢了下来，不再扫地，只是压着）",
    SetVariables = {
        { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", Value = true }
    },
    Next = 900
}

DialogueConfig[900] = {
    Type = "Normal",
    DocTag = "2-B-A#gate",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_CaseLineBootSaid", VarType = "bool", TrueNext = 63, FalseNext = 50 }
    },
    Next = 50
}

-- 普通对话类型  -- doc:2-B-B#1
-- Position: { 9500, 1430 }
DialogueConfig[56] = {
    Type = "Normal",
    DocTag = "2-B-B#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "门前的雨靴脚印，夜里朝鸡窝方向。",
    Next = 57  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-B#2
-- Position: { 9850, 1430 }
DialogueConfig[57] = {
    Type = "Normal",
    DocTag = "2-B-B#2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停住）",
    Next = 58  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-B#3
-- Position: { 10200, 1430 }
DialogueConfig[58] = {
    Type = "Normal",
    DocTag = "2-B-B#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "鸡窝。夜里。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineBootSaid", VarType = "bool", Value = true }
    },
    Next = 901
}

DialogueConfig[901] = {
    Type = "Normal",
    DocTag = "2-B-B#gate",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_CaseLineBucketSaid", VarType = "bool", TrueNext = 63, FalseNext = 50 }
    },
    Next = 50
}

-- 普通对话类型  -- doc:2-B-D#1
-- Position: { 14600, 1430 }
DialogueConfig[59] = {
    Type = "Normal",
    DocTag = "2-B-D#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "先说到这儿。",
    Next = 60  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-D#2
-- Position: { 14950, 1430 }
DialogueConfig[60] = {
    Type = "Normal",
    DocTag = "2-B-D#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "还不够。",
    Next = 61  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-D#3
-- Position: { 15300, 1430 }
DialogueConfig[61] = {
    Type = "Normal",
    DocTag = "2-B-D#3",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……我再去看看。",
    Next = 62  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-D#4
-- Position: { 15650, 1430 }
DialogueConfig[62] = {
    Type = "Normal",
    DocTag = "2-B-D#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去吧。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#1
-- Position: { 10650, 1430 }
DialogueConfig[63] = {
    Type = "Normal",
    DocTag = "2-B-C#1",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "昨晚，有人去池塘取了水。",
    Next = 64  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#2
-- Position: { 11000, 1430 }
DialogueConfig[64] = {
    Type = "Normal",
    DocTag = "2-B-C#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "然后，夜里去了鸡窝。",
    Next = 65  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#3
-- Position: { 11350, 1430 }
DialogueConfig[65] = {
    Type = "Normal",
    DocTag = "2-B-C#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "现在，蛋的气味从红顶屋里飘出来。",
    Next = 66  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#4
-- Position: { 11700, 1430 }
DialogueConfig[66] = {
    Type = "Normal",
    DocTag = "2-B-C#4",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（沉默）",
    Next = 67  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#5
-- Position: { 12050, 1430 }
DialogueConfig[67] = {
    Type = "Normal",
    DocTag = "2-B-C#5",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那家伙昨晚进鸡窝拿走了蛋。",
    Next = 68  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#6
-- Position: { 12400, 1430 }
DialogueConfig[68] = {
    Type = "Normal",
    DocTag = "2-B-C#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "带进了红顶屋。",
    Next = 69  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#7
-- Position: { 12750, 1430 }
DialogueConfig[69] = {
    Type = "Normal",
    DocTag = "2-B-C#7",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "但为什么？",
    Next = 70  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#8
-- Position: { 13100, 1430 }
DialogueConfig[70] = {
    Type = "Normal",
    DocTag = "2-B-C#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 71  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#9
-- Position: { 13450, 1430 }
DialogueConfig[71] = {
    Type = "Normal",
    DocTag = "2-B-C#9",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵也想知道。",
    Next = 72  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#10
-- Position: { 13800, 1430 }
DialogueConfig[72] = {
    Type = "Normal",
    DocTag = "2-B-C#10",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（站起来了一点，又坐回去）",
    Next = 73  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-B-C#11
-- Position: { 14150, 1430 }
DialogueConfig[73] = {
    Type = "Normal",
    DocTag = "2-B-C#11",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他在用那颗蛋做什么。",
    SetVariables = {
        { VarName = "BlackCat_CaseLineDone", VarType = "bool", Value = true }
    },
    Next = 902
}

DialogueConfig[902] = {
    Type = "Normal",
    DocTag = "2-B-C#gate",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_MintFishLineDone", VarType = "bool", TrueNext = 116, FalseNext = 30 }
    },
    Next = 30
}

-- 普通对话类型  -- doc:2-C#1
-- Position: { 9500, 880 }
DialogueConfig[74] = {
    Type = "Normal",
    DocTag = "2-C#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谷仓角落那里……那个草窝，是你的吧？",
    Next = 75  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#2
-- Position: { 9850, 880 }
DialogueConfig[75] = {
    Type = "Normal",
    DocTag = "2-C#2",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "旁边还有烧焦的稻草和皮毛。",
    Next = 76  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#3
-- Position: { 10200, 880 }
DialogueConfig[76] = {
    Type = "Normal",
    DocTag = "2-C#3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫骤然抬眼，定住）",
    Next = 77  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#4
-- Position: { 10550, 880 }
DialogueConfig[77] = {
    Type = "Normal",
    DocTag = "2-C#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你怎么知道那个。",
    Next = 78  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#5
-- Position: { 10900, 880 }
DialogueConfig[78] = {
    Type = "Normal",
    DocTag = "2-C#5",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那个焦痕是怎么回事？",
    Next = 79  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#6
-- Position: { 11250, 880 }
DialogueConfig[79] = {
    Type = "Normal",
    DocTag = "2-C#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "还不是那只死鸟——",
    Next = 80  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#7
-- Position: { 11600, 880 }
DialogueConfig[80] = {
    Type = "Normal",
    DocTag = "2-C#7",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（立刻收住）",
    Next = 81  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#8
-- Position: { 11950, 880 }
DialogueConfig[81] = {
    Type = "Normal",
    DocTag = "2-C#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……但那件事跟你无关。",
    Next = 82  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#9
-- Position: { 12300, 880 }
DialogueConfig[82] = {
    Type = "Normal",
    DocTag = "2-C#9",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，视线短暂飘向红顶屋墙缝方向，很快收回；尾巴尖弹动了一下）",
    Next = 83  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#10
-- Position: { 12650, 880 }
DialogueConfig[83] = {
    Type = "Normal",
    DocTag = "2-C#10",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "跟老鼠有关系吗？",
    Next = 84  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#11
-- Position: { 13000, 880 }
DialogueConfig[84] = {
    Type = "Normal",
    DocTag = "2-C#11",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……你在乱猜什么。",
    Next = 85  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#12
-- Position: { 13350, 880 }
DialogueConfig[85] = {
    Type = "Normal",
    DocTag = "2-C#12",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我帮你把这事办妥——你帮我开屋子。",
    Next = 86  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#13
-- Position: { 13700, 880 }
DialogueConfig[86] = {
    Type = "Normal",
    DocTag = "2-C#13",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫沉默，眯起眼睛，打量玩家，停了很久）",
    Next = 87  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#14
-- Position: { 14050, 880 }
DialogueConfig[87] = {
    Type = "Normal",
    DocTag = "2-C#14",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 88  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#15
-- Position: { 14400, 880 }
DialogueConfig[88] = {
    Type = "Normal",
    DocTag = "2-C#15",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "去找老鼠。",
    Next = 89  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C#16
-- Position: { 14750, 880 }
DialogueConfig[89] = {
    Type = "Normal",
    DocTag = "2-C#16",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "找回来再说。",
    SetVariables = {
        { VarName = "BlackCat_MintFishPending", VarType = "bool", Value = true }
    },
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#1
-- Position: { 9950, 1980 }
DialogueConfig[90] = {
    Type = "Normal",
    DocTag = "2-C-D#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "有关你要我办的那件事。",
    Next = 91  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#2
-- Position: { 10300, 1980 }
DialogueConfig[91] = {
    Type = "Normal",
    DocTag = "2-C-D#2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫眼皮动了一下，仍蹲着）",
    Next = 92  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#3
-- Position: { 10650, 1980 }
DialogueConfig[92] = {
    Type = "Normal",
    DocTag = "2-C-D#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……说。",
    Next = 93  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#4
-- Position: { 11000, 1980 }
DialogueConfig[93] = {
    Type = "Normal",
    DocTag = "2-C-D#4",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你要的东西，我找到了。",
    Next = 94  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#5
-- Position: { 11350, 1980 }
DialogueConfig[94] = {
    Type = "Normal",
    DocTag = "2-C-D#5",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫耳朵竖起来，尾巴尖不受控地弹了一下）",
    Next = 95  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#6
-- Position: { 11700, 1980 }
DialogueConfig[95] = {
    Type = "Normal",
    DocTag = "2-C-D#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "在哪。",
    Next = 96  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#7
-- Position: { 12050, 1980 }
DialogueConfig[96] = {
    Type = "Normal",
    DocTag = "2-C-D#7",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "绿油油的，带着一股冲鼻子的草本甜气——",
    Next = 97  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#8
-- Position: { 12400, 1980 }
DialogueConfig[97] = {
    Type = "Normal",
    DocTag = "2-C-D#8",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "池塘里有只蛙一直坐在上面呢。",
    Next = 98  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#9
-- Position: { 12750, 1980 }
DialogueConfig[98] = {
    Type = "Normal",
    DocTag = "2-C-D#9",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫往前倾了半寸，瞳孔放大，又立刻坐正）",
    Next = 99  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#10
-- Position: { 13100, 1980 }
DialogueConfig[99] = {
    Type = "Normal",
    DocTag = "2-C-D#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……然后呢。",
    Next = 100  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#11
-- Position: { 13450, 1980 }
DialogueConfig[100] = {
    Type = "Normal",
    DocTag = "2-C-D#11",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "我要不回来。",
    Next = 101  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#12
-- Position: { 13800, 1980 }
DialogueConfig[101] = {
    Type = "Normal",
    DocTag = "2-C-D#12",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你有办法吗？",
    Next = 102  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#13
-- Position: { 14150, 1980 }
DialogueConfig[102] = {
    Type = "Normal",
    DocTag = "2-C-D#13",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫顿住，胡须压平，一秒后又摆回傲慢脸）",
    Next = 103  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#14
-- Position: { 14500, 1980 }
DialogueConfig[103] = {
    Type = "Normal",
    DocTag = "2-C-D#14",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "为什么在蛤蟆那儿——本喵不知道。",
    Next = 104  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#15
-- Position: { 14850, 1980 }
DialogueConfig[104] = {
    Type = "Normal",
    DocTag = "2-C-D#15",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "拿不回来，就去找老鼠。",
    Next = 105  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-C-D#16
-- Position: { 15200, 1980 }
DialogueConfig[105] = {
    Type = "Normal",
    DocTag = "2-C-D#16",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "他们肯定有办法。",
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#1
-- Position: { 15650, 1980 }
DialogueConfig[106] = {
    Type = "Normal",
    DocTag = "2-D#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "找回来了。",
    Next = 107  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#2
-- Position: { 16000, 1980 }
DialogueConfig[107] = {
    Type = "Normal",
    DocTag = "2-D#2",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（薄荷鱼递出）",
    Next = 108  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#3
-- Position: { 16350, 1980 }
DialogueConfig[108] = {
    Type = "Normal",
    DocTag = "2-D#3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫耳朵竖起来，尾巴拍了两下——立刻压住）",
    Next = 109  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#4
-- Position: { 16700, 1980 }
DialogueConfig[109] = {
    Type = "Normal",
    DocTag = "2-D#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……哼。",
    Next = 110  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#5
-- Position: { 17050, 1980 }
DialogueConfig[110] = {
    Type = "Normal",
    DocTag = "2-D#5",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（慢慢走近，低头闻了一下，忍了一秒，吸了一大口——喉咙里半秒呼噜，骤然停住）",
    Next = 111  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#6
-- Position: { 17400, 1980 }
DialogueConfig[111] = {
    Type = "Normal",
    DocTag = "2-D#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "喵……就是这个——不对！",
    Next = 112  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#7
-- Position: { 17750, 1980 }
DialogueConfig[112] = {
    Type = "Normal",
    DocTag = "2-D#7",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（往后退半步，爪子压住鱼）",
    Next = 113  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#8
-- Position: { 18100, 1980 }
DialogueConfig[113] = {
    Type = "Normal",
    DocTag = "2-D#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "一条臭鱼，买不走本喵！",
    Next = 114  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#9
-- Position: { 18450, 1980 }
DialogueConfig[114] = {
    Type = "Normal",
    DocTag = "2-D#9",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "（小声）你刚才呼噜了……",
    Next = 115  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-D#10
-- Position: { 18800, 1980 }
DialogueConfig[115] = {
    Type = "Normal",
    DocTag = "2-D#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你耳朵出问题了。",
    SetVariables = {
        { VarName = "BlackCat_MintFishLineDone", VarType = "bool", Value = true }
    },
    Next = 903
}

DialogueConfig[903] = {
    Type = "Normal",
    DocTag = "2-D#gate",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    ConditionBranches = {
        { VarName = "BlackCat_CaseLineDone", VarType = "bool", TrueNext = 116, FalseNext = 30 }
    },
    Next = 30
}

-- 普通对话类型  -- doc:2-E#1
-- Position: { 15200, 880 }
DialogueConfig[116] = {
    Type = "Normal",
    DocTag = "2-E#1",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "猫大爷，昨晚的事你清楚吗？",
    Next = 117  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#2
-- Position: { 15550, 880 }
DialogueConfig[117] = {
    Type = "Normal",
    DocTag = "2-E#2",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "大黄……",
    Next = 118  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#3
-- Position: { 15900, 880 }
DialogueConfig[118] = {
    Type = "Normal",
    DocTag = "2-E#3",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "你可是被那个两脚兽当面骗了一手啊！",
    Next = 119  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#4
-- Position: { 16250, 880 }
DialogueConfig[119] = {
    Type = "Normal",
    DocTag = "2-E#4",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "整个农场都看着你睡得呼呼的、还以为是要给你按摩——",
    Next = 120  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#5
-- Position: { 16600, 880 }
DialogueConfig[120] = {
    Type = "Normal",
    DocTag = "2-E#5",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……",
    Next = 121  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#6
-- Position: { 16950, 880 }
DialogueConfig[121] = {
    Type = "Normal",
    DocTag = "2-E#6",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "——结果一觉醒来，软垫没了，自尊扫地！",
    Next = 122  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#7
-- Position: { 17300, 880 }
DialogueConfig[122] = {
    Type = "Normal",
    DocTag = "2-E#7",
    NpcName = "大黄",
    NpcSprite = "大黄",
    Dialogue = "这要是传出去，今年冬天你睡稻草堆里，我可不让你蹭我狗窝。",
    Next = 123  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#8
-- Position: { 17650, 880 }
DialogueConfig[123] = {
    Type = "Normal",
    DocTag = "2-E#8",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫的尾巴猛地弹了一下，然后静止）",
    Next = 124  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#9
-- Position: { 18000, 880 }
DialogueConfig[124] = {
    Type = "Normal",
    DocTag = "2-E#9",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（非常缓慢地，从蹲位站起来；用眼神冻住大黄——大黄讪讪地把头转开）",
    Next = 125  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#10
-- Position: { 18350, 880 }
DialogueConfig[125] = {
    Type = "Normal",
    DocTag = "2-E#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵不是因为那只发疯母鸡。",
    Next = 126  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#11
-- Position: { 18700, 880 }
DialogueConfig[126] = {
    Type = "Normal",
    DocTag = "2-E#11",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "也不是因为这条蠢狗指使。",
    Next = 127  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#12
-- Position: { 19050, 880 }
DialogueConfig[127] = {
    Type = "Normal",
    DocTag = "2-E#12",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（低头，用嘴叼起薄荷鱼）",
    Next = 128  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#13
-- Position: { 19400, 880 }
DialogueConfig[128] = {
    Type = "Normal",
    DocTag = "2-E#13",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "就要亲眼进屋看清楚。",
    Next = 129  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#14
-- Position: { 19750, 880 }
DialogueConfig[129] = {
    Type = "Normal",
    DocTag = "2-E#14",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那家伙昨晚到底拿本喵的软垫做了什么。",
    Next = 130  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#15
-- Position: { 20100, 880 }
DialogueConfig[130] = {
    Type = "Normal",
    DocTag = "2-E#15",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "垫子去了哪里。",
    Next = 131  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#16
-- Position: { 20450, 880 }
DialogueConfig[131] = {
    Type = "Normal",
    DocTag = "2-E#16",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "至于你说的那颗破蛋——既然它现在多半就在屋里，顺便看一眼也不亏。",
    Next = 132  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#17
-- Position: { 20800, 880 }
DialogueConfig[132] = {
    Type = "Normal",
    DocTag = "2-E#17",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵有专属钥匙。你要进去——爬二层窗。本喵从里面推开。你不许走本喵的猫门。",
    Next = 133  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#18
-- Position: { 21150, 880 }
DialogueConfig[133] = {
    Type = "Normal",
    DocTag = "2-E#18",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫利落地钻进猫门）",
    Next = 134  -- 下一段对话ID
}

-- 普通对话类型  -- doc:2-E#19
-- Position: { 21500, 880 }
DialogueConfig[134] = {
    Type = "Normal",
    DocTag = "2-E#19",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（片刻后，红屋顶二层的窗子被从内推开，传来一声清脆的啪嗒）",
    SetVariables = {
        { VarName = "BlackCat_Entered", VarType = "bool", Value = true }
    },
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#2
-- Position: { 50, 150 }
DialogueConfig[135] = {
    Type = "Normal",
    DocTag = "3-A#2",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你上谷仓屋顶那次——是不是已经知道那是块石头？",
    Next = 136  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#3
-- Position: { 400, 150 }
DialogueConfig[136] = {
    Type = "Normal",
    DocTag = "3-A#3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫停顿，舔了一下爪子）",
    Next = 137  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#4
-- Position: { 750, 150 }
DialogueConfig[137] = {
    Type = "Normal",
    DocTag = "3-A#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "嗯。早上窗台就看见了——乌鸦俯冲，白石头在晨光里闪着。",
    Next = 138  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#5
-- Position: { 1100, 150 }
DialogueConfig[138] = {
    Type = "Normal",
    DocTag = "3-A#5",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫瞥了大黄一眼）",
    Next = 139  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#6
-- Position: { 1450, 150 }
DialogueConfig[139] = {
    Type = "Normal",
    DocTag = "3-A#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "任何不瞎的都看得出来不是蛋。",
    Next = 140  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#7
-- Position: { 1800, 150 }
DialogueConfig[140] = {
    Type = "Normal",
    DocTag = "3-A#7",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你为什么不说！！",
    Next = 141  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#8
-- Position: { 2150, 150 }
DialogueConfig[141] = {
    Type = "Normal",
    DocTag = "3-A#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只乌鸦，每天早上四点开始嘎嘎嘎。",
    Next = 142  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#9
-- Position: { 2500, 150 }
DialogueConfig[142] = {
    Type = "Normal",
    DocTag = "3-A#9",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "已经三年了。",
    Next = 143  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#10
-- Position: { 2850, 150 }
DialogueConfig[143] = {
    Type = "Normal",
    DocTag = "3-A#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "让侦探多转几圈……本喵觉得相当公平。",
    Next = 144  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#11
-- Position: { 3200, 150 }
DialogueConfig[144] = {
    Type = "Normal",
    DocTag = "3-A#11",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫偏头，眼神有一丝难以察觉的满意）",
    Next = 145  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#12
-- Position: { 3550, 150 }
DialogueConfig[145] = {
    Type = "Normal",
    DocTag = "3-A#12",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵在树上不是说过吗？",
    Next = 146  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#13
-- Position: { 3900, 150 }
DialogueConfig[146] = {
    Type = "Normal",
    DocTag = "3-A#13",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "「傻子在炫耀，瞎子在到处问。」",
    Next = 147  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#14
-- Position: { 4250, 150 }
DialogueConfig[147] = {
    Type = "Normal",
    DocTag = "3-A#14",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……等等。",
    Next = 148  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#15
-- Position: { 4600, 150 }
DialogueConfig[148] = {
    Type = "Normal",
    DocTag = "3-A#15",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那句话是在说乌鸦和我？！",
    Next = 149  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-A#16
-- Position: { 4950, 150 }
DialogueConfig[149] = {
    Type = "Normal",
    DocTag = "3-A#16",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你以为本喵是在骂大树吗。",
    SetVariables = {
        { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Value = true }
    },
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#2
-- Position: { 5400, 150 }
DialogueConfig[150] = {
    Type = "Normal",
    DocTag = "3-B#2",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你之前上谷仓屋顶——那时候就知道是块石头，对不对？",
    Next = 151  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#3
-- Position: { 5750, 150 }
DialogueConfig[151] = {
    Type = "Normal",
    DocTag = "3-B#3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（黑猫睨过来一眼）",
    Next = 152  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#4
-- Position: { 6100, 150 }
DialogueConfig[152] = {
    Type = "Normal",
    DocTag = "3-B#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "……这才反应过来？",
    Next = 153  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#5
-- Position: { 6450, 150 }
DialogueConfig[153] = {
    Type = "Normal",
    DocTag = "3-B#5",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "早上窗台就看见了。白石头，晨光一照，闪得很——任何不瞎的都看得出来不是蛋。",
    Next = 154  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#6
-- Position: { 6800, 150 }
DialogueConfig[154] = {
    Type = "Normal",
    DocTag = "3-B#6",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你为什么不说？！",
    Next = 155  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#7
-- Position: { 7150, 150 }
DialogueConfig[155] = {
    Type = "Normal",
    DocTag = "3-B#7",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那只乌鸦，每天早上四点开始嘎嘎嘎。",
    Next = 156  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#8
-- Position: { 7500, 150 }
DialogueConfig[156] = {
    Type = "Normal",
    DocTag = "3-B#8",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "已经三年了。",
    Next = 157  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#9
-- Position: { 7850, 150 }
DialogueConfig[157] = {
    Type = "Normal",
    DocTag = "3-B#9",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "让侦探多转几圈……本喵觉得相当公平。",
    Next = 158  -- 下一段对话ID
}

-- 普通对话类型  -- doc:3-B#10
-- Position: { 8200, 150 }
DialogueConfig[158] = {
    Type = "Normal",
    DocTag = "3-B#10",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你们最后找到了，不是吗。",
    SetVariables = {
        { VarName = "BlackCat_StoneRevealShown", VarType = "bool", Value = true }
    },
    Next = -1
}

-- ==================== 2-F · 攻顶途中（E37/E38 日后 startID 接入） ====================

DialogueConfig[170] = {
    Type = "Normal",
    DocTag = "2-F#E37#1",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "别刮花屋檐。",
    Next = 171
}

DialogueConfig[171] = {
    Type = "Normal",
    DocTag = "2-F#E37#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那是本喵晒太阳的位置。",
    Next = 172
}

DialogueConfig[172] = {
    Type = "Normal",
    DocTag = "2-F#E37#3",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（屋里传来一声很轻的尾巴拍地声）",
    Next = 173
}

DialogueConfig[173] = {
    Type = "Normal",
    DocTag = "2-F#E37#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "你摔下去，本喵不会下去捡。",
    Next = -1
}

DialogueConfig[180] = {
    Type = "Normal",
    DocTag = "2-F#E38#1",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "二层窗开着。",
    Next = 181
}

DialogueConfig[181] = {
    Type = "Normal",
    DocTag = "2-F#E38#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "侦探还在屋檐上犹豫。",
    Next = 182
}

DialogueConfig[182] = {
    Type = "Normal",
    DocTag = "2-F#E38#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵开始怀疑你和那只狗是同一种跳跃水平。",
    Next = -1
}

-- ==================== NGPlus · 二周目轮播 ====================

DialogueConfig[210] = {
    Type = "Normal",
    DocTag = "NGPlus",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "",
    RotatePool = { 211, 220 },
    Next = -1
}

DialogueConfig[211] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#1",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "软垫回来了。",
    Next = 212
}

DialogueConfig[212] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵勉强同意把那间屋子继续租给那家伙住。",
    Next = 213
}

DialogueConfig[213] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#3",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那颗蛋呢？",
    Next = 214
}

DialogueConfig[214] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#4",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "那颗破蛋……",
    Next = 215
}

DialogueConfig[215] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#5",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵暂时替它看着。",
    Next = 216
}

DialogueConfig[216] = {
    Type = "Normal",
    DocTag = "NGPlus@v1#6",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "就这样。",
    Next = -1
}

DialogueConfig[220] = {
    Type = "Normal",
    DocTag = "NGPlus@v2#1",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "你下次还会上那棵树吗？",
    Next = 221
}

DialogueConfig[221] = {
    Type = "Normal",
    DocTag = "NGPlus@v2#2",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "本喵在树上休息，不是在说话。",
    Next = 222
}

DialogueConfig[222] = {
    Type = "Normal",
    DocTag = "NGPlus@v2#3",
    NpcName = "黑猫",
    NpcSprite = "",
    Dialogue = "下次别跟大树搭腔了。",
    Next = 223
}

DialogueConfig[223] = {
    Type = "Normal",
    DocTag = "NGPlus@v2#4",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（叼着薄荷鱼，尾巴高高翘起）",
    Next = -1
}

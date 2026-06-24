-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你来了，快进来。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "有发现吗？",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "眼神里是止不住的期待，很快又压下去",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "听见动静猛地抬起头",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "哦，是你！",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……怎么样了，有消息了吗？",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "说完拢了拢翅膀，像是刚才那句话太着急了",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "来了啊，进来坐。",
    Next = 9  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "往窝边扫了一眼，目光停了停",
    Next = 10  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[10] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……还有什么我能做的吗？",
    Options = {  -- 选项列表
        {  -- 选项#1
            Text = "发现和蛋有关的东西了，你看一下……",
            Next = 44,
            BranchFlag = "Branch_A",
            DisplayConditions = {
                { VarName = "E10_ViewWhiteStone ", VarType = "bool", Value = false },
                { VarName = "Shufen_StoneRevealShown", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#2
            Text = "我觉得……主人把蛋带走了。",
            Next = 36,
            BranchFlag = "Branch_B",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = "==", Value = 4 },
                { VarName = "Shufen_MasterTrustShown", VarType = "bool", Value = false }
            },
        },
        {Text = "主人那边……你说他最近老在你窝边转悠？", Next = 11, BranchFlag = "Flag_3"},
        {  -- 选项#4
            Text = "大黄好像喝多了，有什么办法叫醒他吗？ 4",
            Next = 29,
            BranchFlag = "Flag_4",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 2 },
                { VarName = "E05_GrainSoakGet", VarType = "bool", Value = false }
            },
        },
        {  -- 选项#5
            Text = "那只乌鸦，你觉得它知道什么吗？",
            Next = 16,
            BranchFlag = "Flag_5",
            DisplayConditions = {
                { VarName = "DogStatus", VarType = "int", Op = ">=", Value = 22 }
            },
        },
        {  -- 选项#6
            Text = "池塘边那只青蛙，你了解它吗？",
            Next = 19,
            BranchFlag = "Flag_6",
            DisplayConditions = {
                { VarName = "Frog_FirstMeetShown", VarType = "bool", Value = true }
            },
        },
        {  -- 选项#7
            Text = "红顶屋那俩老鼠，你知道它们的事吗？",
            Next = 23,
            BranchFlag = "Flag_7",
            DisplayConditions = {
                { VarName = "Mouse_FirstGreetShown", VarType = "bool", Value = true }
            },
        },
        {  -- 选项#8
            Text = "谷仓那边有个午睡的草窝——那是你的吗？",
            Next = 27,
            BranchFlag = "Flag_8",
            DisplayConditions = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", Value = true },
                { VarName = "Shufen_NapSpotAsked", VarType = "bool", Value = false }
            },
        },
        {Text = "我再去找找别的线索。", Next = -1, BranchFlag = "Flag_9"}
    }
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "就是老来窝边——有时候弯腰往里看，有时候只是站着。",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "我赶他，他就往后退半步，过一会儿又靠过来。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停顿了一下",
    Next = 14  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "他就是这样，担心的事放不下，但又不会说。",
    Next = 15  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "来了我就知道，他也在惦记着孩儿。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "那只乌鸦啊，什么东西都往顶上搬——亮的、白的、圆的，见了就叼。",
    Next = 17  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "谷仓顶堆了一堆，它自己稀罕得很，我们都懒得管它。",
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你要找什么丢了的东西，去它那翻翻也好。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "那只蛙啊……",
    Next = 20  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "轻轻摇了摇头，是无奈不是嫌弃",
    Next = 21  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "说的东西听不太懂，但它就在水边，什么路过的都看在眼里。",
    Next = 22  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你去问问，就是耐心点——说话绕，多问几句。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你跑去找那两个了？",
    Next = 24  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "那俩……消息是有的，就是爱掺水。",
    Next = 25  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "翅膀拢了拢",
    Next = 26  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你要问，我不拦——自己分辨一下，哪句是真的，哪句是瞎掰的。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[27] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "不是我，我不跑那么远。",
    Next = 28  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "鸡舍这边就挺好的...",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "那条蠢狗又喝多了？",
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "叹了口气",
    Next = 31  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "狗窝都空着——准又醉在谷仓那边了。",
    Next = 32  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[32] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "你直接喊是喊不醒的，喝成那样。",
    Next = 33  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[33] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "鸡舍水槽边有桶老谷物泡水，他爱喝那个味儿，灌下去就醒了。",
    Next = 34  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[34] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停了一下",
    Next = 35  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[35] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……上次也是我给他端去的。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[36] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "淑芬皱眉，想了想",
    Next = 37  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[37] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……主人？",
    Next = 38  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[38] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "主人绝对不是坏人。",
    Next = 39  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[39] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "大前天下午，我深蹲做到腿软那会儿——他就站在旁边看着，他也很担心的。",
    Next = 40  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[40] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停顿，羽毛微微绷了一下",
    Next = 41  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[41] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "不会有事的。",
    Next = 42  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[42] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "轻声，像是说给自己听",
    Next = 43  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[43] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……不会有事的。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[44] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "乌鸦屋顶有颗石头，上面画着爱心和鬼脸，你看长这样子。",
    Next = 45  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[45] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "淑芬盯着笔记本，半天没动",
    Next = 46  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[46] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……这是石头？",
    Next = 47  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[47] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "低头再看了一眼，抬起头",
    Next = 48  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[48] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "石头。",
    Next = 49  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[49] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "大前天下午，我离窝去转了一圈，搞了搞沙浴，就那一小会儿。",
    Next = 50  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[50] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "回来一摸，蛋是冰冰凉的。",
    Next = 51  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[51] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停顿，声音低下去",
    Next = 52  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[52] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "心一下子空了。我满院子跑，深蹲做到腿软，想要把孩儿焐回来。",
    Next = 53  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[53] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "跑累了回窝，蛋居然又热了。",
    Next = 54  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[54] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "我还以为是自己把孩儿焐热的。",
    Next = 55  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[55] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "喙用力抿住",
    Next = 56  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[56] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "那几个小崽子！阿满！你带他们干什么好事了！？",
    Next = 57  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[57] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "让我逮到，一个个都得打一顿！",
    Next = 58  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[58] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "停了片刻，气势稍稍泄了一点",
    Next = 59  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[59] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "……不过那是大前天下午的事。今早才发现蛋没了的。",
    Next = 60  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[60] = {
    Type = "Normal",
    NpcName = "淑芬",
    NpcSprite = "守望",
    Dialogue = "谢谢你找到这个。",
    Next = -1  -- 下一段对话ID
}


-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "我清醒多了。刚才说的是真的——乌鸦叼着那个白色圆东西，飞到谷仓屋顶去了。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄低头看着地面，爪尖刮了下泥）",
    Next = 3  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[3] = {
    Type = "Question",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "我没拦住。这事得查清楚。",
    Options = {  -- 选项列表
        {Text = "大黄，梯子能借我吗？乌鸦在谷仓顶上，我得先翻过入口那道小围墙。", Next = 4, BranchFlag = "Branch_A"},
        {  -- 选项#2
            Text = "谷仓那草窝是谁的？",
            Next = 9,
            BranchFlag = "Branch_B",
            ConditionBranches = {
                { VarName = "E07_ViewNapSpot", VarType = "bool", TrueNext = 9, FalseNext = -1 }
            }
        },
        {Text = "这是你追的蛋吗？", Next = 15, BranchFlag = "Flag_3"}
    }
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "梯子？",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄扭头看向身侧那架侧倒的木梯）",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "哦。对哦。拿去吧。",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄用前爪把木梯往玩家方向推了推）",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "架稳了再翻。别摔着。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "谷仓角落有一片被压扁的草窝，你知道是哪个动物的吗？",
    Next = 10  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "谷仓角落……",
    Next = 11  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄皱起眉头，努力回想）",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "我嚎叫那会儿脑子糊着……好像看见两个灰乎乎的东西，抱着什么往红顶屋那边跑。太快了，没看清。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "两个灰乎乎的……",
    Next = 14  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "嗯。也可能是我那两天喝糊涂了产生的幻觉，就那么一眼。",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "大黄，你看这个——是不是你那天追的蛋？",
    Next = 16  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄低头凑近，仔细盯着摊开的笔记本插图）",
    Next = 17  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "这是……什么？",
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄眼睛睁大，头伸得更近）",
    Next = 19  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "一块石头？",
    Next = 20  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄抬起脑袋，僵在那里）",
    Next = 21  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "……这跟乌鸦叼走的……形状差不多。",
    Next = 22  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "Npc1",
    Dialogue = "乌鸦一直守着这块石头，说是他的部落图腾宝石。",
    Next = 23  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄盯着插图，一动不动，像是脑子里有什么齿轮咬住了）",
    Next = 24  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "所以乌鸦叼走的……不是淑芬的蛋？",
    Next = 25  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "……我",
    Next = 26  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "那我不是废柴保安！！",
    Next = 27  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[27] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（尾巴猛地甩动起来，停不下来）",
    Next = 28  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "蛋一定还在！！",
    Next = 29  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（大黄一个激灵，深吸一口气）",
    Next = 30  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（在某个方向停下来，神情郑重）",
    Next = 31  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[31] = {
    Type = "Normal",
    NpcName = "大黄",
    NpcSprite = "",
    Dialogue = "蛋气味在那边。红顶屋那一片。我先走一步。",
    Next = -1  -- 下一段对话ID
}


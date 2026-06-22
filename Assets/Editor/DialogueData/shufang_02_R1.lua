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
        {Text = "发现和蛋有关的东西了，你看一下……", Next = -1, BranchFlag = "Branch_A"},
        {Text = "我觉得……主人把蛋带走了。", Next = -1, BranchFlag = "Branch_B"},
        {Text = "主人那边……你说他最近老在你窝边转悠？", Next = -1, BranchFlag = "Flag_3"},
        {Text = "大黄好像喝多了，有什么办法叫醒他吗？ 4", Next = -1, BranchFlag = "Flag_4"},
        {Text = "那只乌鸦，你觉得它知道什么吗？", Next = -1, BranchFlag = "Flag_5"},
        {Text = "池塘边那只青蛙，你了解它吗？", Next = -1, BranchFlag = "Flag_6"},
        {Text = "红顶屋那俩老鼠，你知道它们的事吗？", Next = -1, BranchFlag = "Flag_7"},
        {Text = "谷仓那边有个午睡的草窝——那是你的吗？", Next = -1, BranchFlag = "Flag_8"},
        {Text = "我再去找找别的线索。", Next = -1, BranchFlag = "Flag_9"}
    }
}


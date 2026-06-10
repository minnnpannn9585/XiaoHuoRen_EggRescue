-- 对话配置文件
DialogueConfig = {}

-- 提问类型（玩家需要选择回答）
DialogueConfig[1] = {
    Type = "Question",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "今天晚上怎么安排？",
    Options = {  -- 选项列表
        {Text = "去飙车？", Next = 2, BranchFlag = "Branch_A"},
        {Text = "去游泳？", Next = 3, BranchFlag = "Branch_B"},
        {Text = "回家躺平？", Next = 4, BranchFlag = "Flag_3"}
    }
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "Go Go Go",
    Next = 5  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "吉格健身房？",
    Next = 6  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "那就回家躺一会吧",
    Next = -1  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[5] = {
    Type = "Question",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "今天几点出发走呢",
    Options = {  -- 选项列表
        {Text = "8点", Next = -1, BranchFlag = "Branch_A"},
        {Text = "7点", Next = -1, BranchFlag = "Branch_B"}
    }
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[6] = {
    Type = "Question",
    NpcName = "辉",
    NpcSprite = "CunZhang",
    Dialogue = "今天准备游泳多少圈？",
    Options = {  -- 选项列表
        {Text = "20圈", Next = -1, BranchFlag = "Branch_A"},
        {Text = "15圈", Next = -1, BranchFlag = "Branch_B"}
    }
}


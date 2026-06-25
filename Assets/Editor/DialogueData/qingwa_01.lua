-- 对话配置文件
DialogueConfig = {}

DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "（一股刺鼻的草本甜味，混着池水腥气）",
    Next = 2
}

DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "……你来了。",
    Next = 3
}

DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "或者……你只是路过这片死水。",
    Next = 4
}

DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "……这里是你的地方？",
    Next = 5
}

DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "这里是虚无的地方。",
    Next = 6
}

DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "悲伤蛙",
    NpcSprite = "",
    Dialogue = "坐了很久了。",
    SetVariables = {
        { VarName = "Frog_FirstMeetShown", VarType = "bool", Value = true }
    },
    UnlockBranches = {
        { NpcName = "悲伤蛙", BranchId = 2 }
    },
    Next = -1
}
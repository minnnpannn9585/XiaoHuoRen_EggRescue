-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "年轻人，你终于来了。最近村里出了大事，我需要一个勇敢的人帮忙。",
    Next = 2  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "三天前，北边的矿洞突然塌方，里面传来了奇怪的吼叫声。",
    Next = 3  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang_Sad",
    Dialogue = "派进去的三个矿工，到现在都没有回来……恐怕已经凶多吉少了。",
    Next = 4  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[4] = {
    Type = "Question",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "我想请你进矿洞调查一下，看看里面到底出了什么事。你愿意去吗？",
    Options = {  -- 选项列表
        {Text = "我接受这个任务，马上出发。", Next = 5, BranchFlag = "AcceptQuest"},
        {Text = "太危险了，我拒绝。", Next = 20, BranchFlag = "RejectQuest"},
        {Text = "可以先告诉我更多情报吗？", Next = 6, BranchFlag = "AskInfo"}
    }
}

-- 普通对话类型
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "太好了！你是我们村唯一的希望。",
    Next = 7  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "矿洞原本很安全，但最近地下传出震动，有人说看到过发光的眼睛。",
    Next = 4  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "铁匠老陈",
    NpcSprite = "Blacksmith",
    Dialogue = "年轻人，等等！老村长，我也一起去吧，多个人多份力。",
    Next = 8  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "老陈，你年纪也大了，别逞强。还是让他一个人去吧。",
    Next = 9  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[9] = {
    Type = "Question",
    NpcName = "铁匠老陈",
    NpcSprite = "Blacksmith",
    Dialogue = "小伙子，我年轻时可是打熊的好手。带上我吧，关键时刻能帮你。",
    Options = {  -- 选项列表
        {Text = "好，那就麻烦您了。", Next = 10, BranchFlag = "TakeSmith"},
        {Text = "不用了，我一个人能行。", Next = 11, BranchFlag = "Alone"}
    }
}

-- 普通对话类型
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "铁匠老陈",
    NpcSprite = "Blacksmith",
    Dialogue = "哈哈，爽快！我去准备两把好武器，明天一早在矿洞口见。",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "铁匠老陈",
    NpcSprite = "Blacksmith_Sad",
    Dialogue = "好吧……那你一定要小心。这把匕首你拿着，防身用。",
    Next = 12  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "进入矿洞后，沿着左边的主道走，第三个岔路口右转，就能找到塌方的地方。",
    Next = 13  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "如果发现怪物，不要硬拼，先回来报信。这是几个治疗药水，拿着。",
    Next = 14  -- 下一段对话ID
}

-- 提问类型（玩家需要选择回答）
DialogueConfig[14] = {
    Type = "Question",
    NpcName = "杂货商人",
    NpcSprite = "Merchant",
    Dialogue = "哎～小兄弟，要不要看看我的商品？火把、绳索、解毒草，应有尽有。",
    Options = {  -- 选项列表
        {Text = "买点东西（花费50金币）", Next = 15, BranchFlag = "BuyItems"},
        {Text = "不需要，直接出发", Next = 16, BranchFlag = "NoBuy"}
    }
}

-- 普通对话类型
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "杂货商人",
    NpcSprite = "Merchant",
    Dialogue = "承惠50金币。这些物资够你用一阵子了，祝你好运！",
    Next = 16  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang",
    Dialogue = "路上小心，我们在村里等你回来。",
    Next = 17  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "？？？",
    NpcSprite = "Shadow",
    Dialogue = "吼——！（黑暗中传来低吼声）",
    Next = 18  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "系统",
    NpcSprite = "System",
    Dialogue = "经过一场惊心动魄的战斗，你终于击退了怪物，救出了被困的矿工。",
    Next = 19  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang_Happy",
    Dialogue = "太好了！我就知道没有看错人。这是奖励的500金币和村里的荣誉徽章，谢谢你！",
    Next = -1  -- 下一段对话ID
}

-- 普通对话类型
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "老村长",
    NpcSprite = "CunZhang_Sad",
    Dialogue = "唉……我理解你的顾虑。那我会再找别人试试，你先去忙吧。",
    Next = -1  -- 下一段对话ID
}


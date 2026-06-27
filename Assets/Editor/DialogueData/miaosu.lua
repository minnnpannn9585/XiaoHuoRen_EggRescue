-- 对话配置文件
DialogueConfig = {}

-- 解锁短木炭
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "草地上有一截短木炭棒，炭尖磨平，周边草叶蹭着炭粉。",
    Next = -1  -- 下一段对话ID
}
-- 解锁黄色绒毛
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "几根蓬松的黄色绒毛散落在草丛里。",
    Next = -1  -- 下一段对话ID
}
-- 解锁悲伤蛙身下绿垫
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "蛙端坐的地方比周边荷叶略高，身下垫着一截绿色的东西，近闻有股奇异的气味。",
    Next = 4  -- 下一段对话ID
}
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那个气味……垫着什么？",
    Next = -1  -- 下一段对话ID
}

-- 解锁池塘边小鸡脚印
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "池塘边的软泥上印着几枚小小的三趾脚印，脚印边缘被水泡得有点散。",
    Next = 6  -- 下一段对话ID
}

DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "有鸡来过池塘边？",
    Next = -1  -- 下一段对话ID
}

-- 解锁池塘边小鸡脚印
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "蛙端坐的地方比周边荷叶略高，身下垫着一截绿色的东西，近闻有股奇异的气味。",
    Next = 8  -- 下一段对话ID
}

DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那个气味……垫着什么？",
    Next = -1  -- 下一段对话ID
}

-- 解锁梯子
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "这个地方爬不上去，需要一个梯子",
    UnlockBranches = {
        { NpcName = "大黄", BranchId = 2 }
    },
    Next = -1  -- 下一段对话ID
}


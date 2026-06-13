-- 对话配置文件
DialogueConfig = {}

-- 普通对话类型
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "这个地方爬不上去，需要一个梯子",
    UnlockBranches = {
        { NpcName = "大黄", BranchId = 2 }
    },
    Next = -1  -- 下一段对话ID
}


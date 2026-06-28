-- 对话配置文件
DialogueConfig = {}

-- 短木炭
DialogueConfig[1] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "草地上有一截短木炭棒，炭尖磨平，周边草叶蹭着炭粉。",
    Next = -1 -- 下一段对话ID
}

-- 黄色绒毛
DialogueConfig[2] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "几根蓬松的黄色绒毛散落在草丛里。",
    Next = -1 -- 下一段对话ID
}

-- 悲伤蛙身下绿垫
DialogueConfig[3] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "蛙端坐的地方比周边荷叶略高，身下垫着一截绿色的东西，近闻有股奇异的气味。",
    Next = 4 -- 下一段对话ID
}
DialogueConfig[4] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那个气味……垫着什么？",
    Next = -1 -- 下一段对话ID
}

-- 池塘边小鸡脚印
DialogueConfig[5] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "池塘边的软泥上印着几枚小小的三趾脚印，脚印边缘被水泡得有点散。",
    Next = 6 -- 下一段对话ID
}
DialogueConfig[6] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "有鸡来过池塘边？",
    Next = -1 -- 下一段对话ID
}

-- 池塘岸边蹚水痕迹
DialogueConfig[7] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "池塘近岸处有几处被踩进的浅坑，旁边留有一个圆底压印，底部粘着带水草腥气的湿泥。",
    Next = -1 -- 下一段对话ID
}

-- 发现缺少梯子
DialogueConfig[8] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "一道矮围墙，太高，爬不上去。",
    Next = 11 -- 下一段对话ID
}

DialogueConfig[11] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "缺个东西垫垫脚。",
    UnlockBranches = {
        { NpcName = "大黄", BranchId = 2 }
    },
    Next = -1 -- 下一段对话ID
}

-- 谷物泡水
DialogueConfig[9] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "水槽旁放着一桶浑浊的液体，水面浮着几粒胀开的谷粒，气味有点酸。",
    Next = 10 -- 下一段对话ID
}
DialogueConfig[10] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这个气味……说不定正是大黄需要的。",
    Next = -1 -- 下一段对话ID
}



--  烧焦稻草 / 皮毛
DialogueConfig[12] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "几根稻草尖端焦黑，旁边粘着一小撮被燎卷的深色毛。",
    Next = 13 -- 下一段对话ID
}

DialogueConfig[13] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这里被什么东西烫过，焦痕很浅，不像大火。",
    Next = -1 -- 下一段对话ID
}
--  午睡点
DialogueConfig[14] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "干草被压出一片圆形凹陷，边缘沾着几根深色细毛。",
    Next = 15 -- 下一段对话ID
}
DialogueConfig[15] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "谁经常在这里睡觉？",
    Next = -1 -- 下一段对话ID
}
-- 乌鸦巢前 · 动物爪印
DialogueConfig[16] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "乌鸦巢前的木板边缘有几枚浅浅的爪印，脚掌小而利。",
    Next = -1 -- 下一段对话ID
}

-- 谷仓高处玻璃珠反光
DialogueConfig[17] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "木梁缝里闪过一点彩色反光，角度一偏又看不见了。",
    Next = 18 -- 下一段对话ID
}

DialogueConfig[18] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "那是什么东西的反光——乌鸦在这里摆了什么亮晶晶的东西？",
    Next = -1 -- 下一段对话ID
}
-- 乌鸦巢白石头（假蛋）
DialogueConfig[19] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "一颗天然白色圆石，表面用木炭画着歪歪的爱心，背面还有一张笔画稚嫩的鬼脸。",
    Next = 20 -- 下一段对话ID
}
DialogueConfig[20] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这是……什么东西？？......反正不是蛋",
    Next = -1 -- 下一段对话ID
}
-- 门旁空水桶
DialogueConfig[21] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "倒扣着一只空水桶，桶底粘着湿泥和细沙，有股池塘边的水草味。",
    Next = 22 -- 下一段对话ID
}
DialogueConfig[22] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这桶刚装过池塘水。",
    Next = -1 -- 下一段对话ID
}
-- 雨靴泥脚印
DialogueConfig[23] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "几枚很重的泥脚印，鞋底纹路宽大，从门口延向鸡舍方向，泥边已经干了一圈。",
    Next = -1 -- 下一段对话ID
}

-- 精美猫门
DialogueConfig[24] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "一扇精致的小门，边缘磨得很亮，上面有个细小锁扣。",
    Next = 25 -- 下一段对话ID
}

DialogueConfig[25] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这是给谁专用的小门？",
    Next = -1 -- 下一段对话ID
}
--大橡树根抓痕
DialogueConfig[26] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "树皮上有几道细长抓痕。",
    Next = -1 -- 下一段对话ID
}

--门外陶瓷碗
DialogueConfig[27] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "一只干净的陶瓷小碗，碗沿印着小小的爪印花纹，碗底还残留一点细碎食渣。",
    Next = 28 -- 下一段对话ID
}
DialogueConfig[28] = {
    Type = "Normal",
    NpcName = "玩家",
    NpcSprite = "",
    Dialogue = "这里住着被照顾得很好的小动物。",
    Next = -1 -- 下一段对话ID
}
--门边兽毛
DialogueConfig[29] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "一撮深色兽毛，毛尖细软。",
    Next = -1 -- 下一段对话ID
}
--紧闭大门
DialogueConfig[30] = {
    Type = "Normal",
    NpcName = "描述",
    NpcSprite = "",
    Dialogue = "大门关得很紧，没有能钻进去的空隙。",
    Next = -1 -- 下一段对话ID
}

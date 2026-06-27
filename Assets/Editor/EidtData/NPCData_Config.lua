local NPCData = {
    npcList = {
        {
            id = "Player_001",
            name = "玩家",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
        }
        ,
        {
            id = "NPC_004",
            name = "描述",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "描述需要一个梯子",
                    luaModuleName = "miaosu",
                    luaAssetPath = "Assets/Editor/DialogueData/miaosu.lua"
                }
            }
        }
        ,
        {
            id = "NPC_005",
            name = "大黄",
            avatarPath = "Assets/Res/TouXiang_LiHui/Dog/大黄.png",
            currentBranchId = 1,
            isFolded = true,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "半睡复述（仅首次）",
                    luaModuleName = "dahuang_01",
                    luaAssetPath = "Assets/Editor/DialogueData/dahuang_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "解锁梯子",
                    luaModuleName = "dahuang_02",
                    luaAssetPath = "Assets/Editor/DialogueData/dahuang_02.lua"
                }
                ,
                {
                    branchId = 3,
                    storyDescription = "泡水叫醒",
                    luaModuleName = "dahuang_03",
                    luaAssetPath = "Assets/Editor/DialogueData/dahuang_03.lua"
                }
                ,
                {
                    branchId = 4,
                    storyDescription = "清醒回访",
                    luaModuleName = "dahuang_04",
                    luaAssetPath = "Assets/Editor/DialogueData/dahuang_04.lua"
                }
            }
        }
        ,
        {
            id = "NPC_488",
            name = "淑芬",
            avatarPath = "Assets/Res/TouXiang_LiHui/母鸡/守望.png",
            currentBranchId = 2,
            isFolded = true,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "初次相遇与委托",
                    luaModuleName = "shufang_01",
                    luaAssetPath = "Assets/Editor/DialogueData/shufang_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "默认回访R1",
                    luaModuleName = "shufang_02_R1",
                    luaAssetPath = "Assets/Editor/DialogueData/shufang_02_R1.lua"
                }
                ,
                {
                    branchId = 3,
                    storyDescription = "默认回访R2",
                    luaModuleName = "shufang_02_R2",
                    luaAssetPath = "Assets/Editor/DialogueData/shufang_02_R2.lua"
                }
                ,
                {
                    branchId = 4,
                    storyDescription = "默认回访R3",
                    luaModuleName = "shufang_02_R3",
                    luaAssetPath = "Assets/Editor/DialogueData/shufang_02_R3.lua"
                }
            }
        }
        ,
        {
            id = "NPC_142",
            name = "豆豆",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "身后偷听",
                    luaModuleName = "zttTouTing",
                    luaAssetPath = "Assets/Editor/DialogueData/zttTouTing.lua"
                }
            }
        }
        ,
        {
            id = "NPC_006",
            name = "米粒",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
        }
        ,
        {
            id = "NPC_007",
            name = "瓜子",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
        }
        ,
        {
            id = "NPC_008",
            name = "阿满",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
        }
        ,
        {
            id = "NPC_009",
            name = "小鸡侦探团",
            avatarPath = "",
            currentBranchId = 2,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "首次接触",
                    luaModuleName = "xiaojiZTT_01",
                    luaAssetPath = "Assets/Editor/DialogueData/xiaojiZTT_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "主菜单 hub",
                    luaModuleName = "xiaojiZTT_02",
                    luaAssetPath = "Assets/Editor/DialogueData/xiaojiZTT_02.lua"
                }
            }
        }
        ,
        {
            id = "NPC_010",
            name = "黑猫",
            avatarPath = "Assets/Res/TouXiang_LiHui/猫/高傲.png",
            currentBranchId = 1,
            isFolded = true,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "首次靠近",
                    luaModuleName = "heimao_01",
                    luaAssetPath = "Assets/Editor/DialogueData/heimao_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "2-B · 案情汇报线",
                    luaModuleName = "heimao_02",
                    luaAssetPath = "Assets/Editor/DialogueData/heimao_02.lua"
                }
                ,
                {
                    branchId = 3,
                    storyDescription = "2-B-hub · 回访菜单",
                    luaModuleName = "heimao_03",
                    luaAssetPath = "Assets/Editor/DialogueData/heimao_03.lua"
                }
            }
        }
        ,
        {
            id = "NPC_011",
            name = "大树",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = true,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "首次靠近",
                    luaModuleName = "heimao_01",
                    luaAssetPath = "Assets/Editor/DialogueData/heimao_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "大树（轮播）",
                    luaModuleName = "heimao_02",
                    luaAssetPath = "Assets/Editor/DialogueData/heimao_02.lua"
                }
            }
        }
        ,
        {
            id = "NPC_012",
            name = "悲伤蛙",
            avatarPath = "Assets/Res/TouXiang_LiHui/青蛙/介入.png",
            currentBranchId = 2,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "首次对话",
                    luaModuleName = "qingwa_01",
                    luaAssetPath = "Assets/Editor/DialogueData/qingwa_01.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "轮播",
                    luaModuleName = "qingwa_02",
                    luaAssetPath = "Assets/Editor/DialogueData/qingwa_02.lua"
                }
            }
        }
        ,
        {
            id = "NPC_013",
            name = "闪电蜗牛",
            avatarPath = "Assets/Res/TouXiang_LiHui/蜗牛/闪电蜗牛.png",
            currentBranchId = 1,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "首次对话",
                    luaModuleName = "wuniu_01",
                    luaAssetPath = "Assets/Editor/DialogueData/wuniu_01.lua"
                }
            }
        }
        ,
        {
            id = "NPC_014",
            name = "乌鸦",
            avatarPath = "Assets/Res/TouXiang_LiHui/乌鸦/得意.png",
            currentBranchId = 1,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "谷仓底部仰望",
                    luaModuleName = "wuya_01",
                    luaAssetPath = "Assets/Editor/DialogueData/wuya_01.lua"
                }
            }
        }
    }
}
return NPCData

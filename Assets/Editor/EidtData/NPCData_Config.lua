local NPCData = {
    npcList = {
        {
            id = "Player_001",
            name = "玩家",
            avatarPath = "Assets/DialogueSystem/UI/Npc1.png",
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
            avatarPath = "",
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
    }
}
return NPCData

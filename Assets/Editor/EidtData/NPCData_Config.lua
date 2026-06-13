local NPCData = {
    npcList = {
        {
            id = "Player_001",
            name = "玩家",
            avatarPath = "Assets/DialogueSystem/UI/Npc1.png",
            currentBranchId = 1,
            isFolded = true,
            storyGraphs = {
            }
        }
        ,
        {
            id = "NPC_900",
            name = "大树",
            avatarPath = "Assets/Res/UI/Black Cat.png",
            currentBranchId = 2,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "新剧情路由",
                    luaModuleName = "Dashu1-A",
                    luaAssetPath = "Assets/Editor/DialogueData/Dashu1-A.lua"
                }
                ,
                {
                    branchId = 2,
                    storyDescription = "新剧情路由",
                    luaModuleName = "Dashu1-B-1",
                    luaAssetPath = "Assets/Editor/DialogueData/Dashu1-B-1.lua"
                }
            }
        }
        ,
        {
            id = "NPC_003",
            name = "闪电蜗牛",
            avatarPath = "Assets/Plugins/Pixel Crushers/Dialogue System/Prefabs/Art/Textures/Circle/Circle Portrait.png",
            currentBranchId = 1,
            isFolded = false,
            storyGraphs = {
                {
                    branchId = 1,
                    storyDescription = "描述",
                    luaModuleName = "woniu",
                    luaAssetPath = "Assets/Editor/DialogueData/woniu.lua"
                }
            }
        }
        ,
        {
            id = "NPC_004",
            name = "描述",
            avatarPath = "",
            currentBranchId = 1,
            isFolded = false,
            storyGraphs = {
            }
        }
    }
}
return NPCData

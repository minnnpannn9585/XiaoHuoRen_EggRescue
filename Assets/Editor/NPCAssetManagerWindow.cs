using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.IO;

public class NPCAssetManagerWindow : EditorWindow
{
    // --- 1. 内存中运行的数据结构 ---
    [System.Serializable]
    public class DialogueGraphData
    {
        public int branchId;             // 触发分支ID
        public string storyDescription; // 剧情备注
        public Object luaAsset;          // 绑定的 Lua 脚本资产对象
        public string luaModuleName;     // 自动解析出的 Lua require 模块名
        public string luaAssetPath;      // Lua 文件的相对路径
    }

    [System.Serializable]
    public class NPCCharacter
    {
        public string id;                // 👁️ 前端已隐藏：但在后台和JSON中依然保留用于唯一标识
        public string name;              // 🌟 核心显示：NPC 名字
        public Texture2D avatar;         
        public string avatarPath;        
        public int currentBranchId = 1;  // 当前执行分支ID
        public bool isFolded = false;    
        public List<DialogueGraphData> storyGraphs = new List<DialogueGraphData>(); 
    }

    // --- 2. 用于导出干净 JSON 的数据结构 ---
    [System.Serializable]
    public class SerializableNPCData
    {
        public List<NPCCharacter> npcList;
    }

    private List<NPCCharacter> npcList = new List<NPCCharacter>();
    private string jsonSavePath = "Assets/Editor/EidtData/NPCData_Config.json"; // 指向正确的相对路径

    // UI 辅助变量（已移除 ID 和 搜索变量）
    private Vector2 scrollPosition;
    private string newNPCName = "新角色";

    // 配色
    private Color themeDarkBg = new Color(0.15f, 0.15f, 0.15f);
    private Color themeHeaderBg = new Color(0.2f, 0.23f, 0.27f);
    private Color themeCardBg = new Color(0.21f, 0.22f, 0.23f);
    private Color themeAccentLine = new Color(0.95f, 0.41f, 0.12f); 

    [MenuItem("抖音虚拟创作SDK/NpcEditor")]
    public static void ShowWindow()
    {
        NPCAssetManagerWindow window = GetWindow<NPCAssetManagerWindow>("NPCEdit");
        window.minSize = new Vector2(800, 600);
        window.Show();
    }

    private void OnEnable()
    {
        LoadFromJson();
    }

    private void OnFocus()
    {
        LoadFromJson();
    }

    private void OnGUI()
    {
        Rect windowRect = new Rect(0, 0, position.width, position.height);
        EditorGUI.DrawRect(windowRect, themeDarkBg);

        GUILayout.Space(10);
        DrawTopToolbar(); // 顶部注册栏
        GUILayout.Space(10);
        DrawNPCListContainer(); // 角色列表
        GUILayout.Space(5);
        DrawBottomJsonPanel(); // 底部存盘栏
    }

    /// <summary>
    /// 顶部纯名字注册栏（过滤已去掉，ID已去掉）
    /// </summary>
    private void DrawTopToolbar()
    {
        Rect headerRect = EditorGUILayout.BeginHorizontal("Box", GUILayout.Height(40));
        EditorGUI.DrawRect(headerRect, themeHeaderBg);
        
        GUILayout.Space(8);
        GUIStyle titleStyle = new GUIStyle(EditorStyles.boldLabel) { fontSize = 14, alignment = TextAnchor.MiddleLeft };
        titleStyle.normal.textColor = Color.white;
        EditorGUILayout.LabelField("👤 NPC 角色全局注册与 Lua 剧本捆绑中心", titleStyle, GUILayout.Width(320), GUILayout.Height(28));
        
        GUILayout.FlexibleSpace();

        // 快捷创建：仅保留姓名输入
        EditorGUILayout.LabelField("NPC 姓名:", GUILayout.Width(60), GUILayout.Height(28));
        newNPCName = EditorGUILayout.TextField(newNPCName, GUILayout.Width(150), GUILayout.Height(20));
        
        GUILayout.Space(10);

        GUI.backgroundColor = new Color(0.12f, 0.75f, 0.38f); 
        if (GUILayout.Button("➕ 注册新角色", GUILayout.Width(95), GUILayout.Height(22)))
        {
            // 🚀 核心设计：在后台通过总数自动计算出唯一的 ID 赋给数据，无需策划手动输入
            string autoId = "NPC_" + (npcList.Count + 1).ToString("D3");
            
            // 防御性确保 ID 绝对不重复
            while (npcList.Exists(x => x.id == autoId))
            {
                autoId = "NPC_" + (Random.Range(100, 999)).ToString();
            }

            npcList.Add(new NPCCharacter { id = autoId, name = newNPCName });
            newNPCName = "新角色";
            GUI.FocusControl(null);
            SaveToJson(false); // 新增后自动静默保存
            
            // 添加完毕后自动将滚动条拉到最底部
            scrollPosition.y = float.MaxValue;
        }
        GUI.backgroundColor = Color.white;
        EditorGUILayout.EndHorizontal();
    }

    /// <summary>
    /// NPC 滚动卡片列表（无 ID 显示，无过滤）
    /// </summary>
    private void DrawNPCListContainer()
    {
        scrollPosition = EditorGUILayout.BeginScrollView(scrollPosition, GUILayout.Height(position.height - 120));

        for (int i = 0; i < npcList.Count; i++)
        {
            NPCCharacter npc = npcList[i];

            Rect cardRect = EditorGUILayout.BeginVertical("HelpBox");
            EditorGUI.DrawRect(cardRect, themeCardBg);
            EditorGUI.DrawRect(new Rect(cardRect.x, cardRect.y, 4, cardRect.height), themeAccentLine);

            EditorGUILayout.BeginHorizontal();
            
            // 头像选择框
            EditorGUI.BeginChangeCheck();
            if (npc.avatar == null)
            {
                Rect avatarRect = GUILayoutUtility.GetRect(50, 50);
                EditorGUI.DrawRect(avatarRect, new Color(0.28f, 0.3f, 0.32f));
                GUI.Label(new Rect(avatarRect.x, avatarRect.y + 16, 50, 20), "无头像", new GUIStyle(EditorStyles.miniLabel) { alignment = TextAnchor.MiddleCenter });
                npc.avatar = (Texture2D)EditorGUI.ObjectField(avatarRect, npc.avatar, typeof(Texture2D), false);
            }
            else
            {
                npc.avatar = (Texture2D)EditorGUILayout.ObjectField(npc.avatar, typeof(Texture2D), false, GUILayout.Width(50), GUILayout.Height(50));
            }
            
            if (EditorGUI.EndChangeCheck())
            {
                npc.avatarPath = npc.avatar != null ? AssetDatabase.GetAssetPath(npc.avatar) : "";
                SaveToJson(false); // 头像改变时静默保存
            }
            
            GUILayout.Space(10);

            // 角色身份属性编辑（已干掉 ID）
            EditorGUILayout.BeginVertical();
            GUILayout.Space(2);
            EditorGUILayout.BeginHorizontal();
            
            // 折叠栏只显示名字
            EditorGUI.BeginChangeCheck();
            npc.isFolded = EditorGUILayout.Foldout(npc.isFolded, $" 角色名: {npc.name}", true, new GUIStyle(EditorStyles.foldout) { fontStyle = FontStyle.Bold, fontSize = 12 });
            if (EditorGUI.EndChangeCheck())
            {
                SaveToJson(false);
            }
            
            GUILayout.FlexibleSpace();
            
            EditorGUILayout.LabelField("修改角色名:", GUILayout.Width(70));
            EditorGUI.BeginChangeCheck();
            npc.name = EditorGUILayout.TextField(npc.name, GUILayout.Width(150));
            if (EditorGUI.EndChangeCheck())
            {
                SaveToJson(false);
            }
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.LabelField($"剧本绑定数: {npc.storyGraphs.Count} | 点击左侧名字可折叠/展开详细剧本", EditorStyles.miniLabel);

            GUILayout.Space(2);
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("🎯 当前执行分支ID:", GUILayout.Width(120));
            EditorGUI.BeginChangeCheck();
            
            // 构建下拉菜单选项
            if (npc.storyGraphs.Count > 0)
            {
                List<string> branchOptions = new List<string>();
                List<int> branchValues = new List<int>();
                int selectedIndex = 0;

                for (int j = 0; j < npc.storyGraphs.Count; j++)
                {
                    int bId = npc.storyGraphs[j].branchId;
                    string desc = string.IsNullOrEmpty(npc.storyGraphs[j].storyDescription) ? "未命名分支" : npc.storyGraphs[j].storyDescription;
                    branchOptions.Add($"[{bId}] {desc}");
                    branchValues.Add(bId);

                    if (npc.currentBranchId == bId)
                    {
                        selectedIndex = j;
                    }
                }

                // 如果当前保存的 ID 在列表中不存在，默认选择第一个
                if (!branchValues.Contains(npc.currentBranchId))
                {
                    npc.currentBranchId = branchValues[0];
                    selectedIndex = 0;
                }

                selectedIndex = EditorGUILayout.Popup(selectedIndex, branchOptions.ToArray(), GUILayout.Width(150));
                npc.currentBranchId = branchValues[selectedIndex];
            }
            else
            {
                GUI.enabled = false;
                EditorGUILayout.TextField("暂无分支", GUILayout.Width(150));
                GUI.enabled = true;
                npc.currentBranchId = 1; // 默认值
            }

            if (EditorGUI.EndChangeCheck())
            {
                SaveToJson(false);
            }
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.EndVertical();

            GUILayout.Space(15);

            // 注销整个角色按钮
            GUI.backgroundColor = new Color(0.85f, 0.25f, 0.25f);
            if (GUILayout.Button("❌ 注销角色", GUILayout.Width(85), GUILayout.Height(24)))
            {
                if (EditorUtility.DisplayDialog("警告", $"确定要完全注销【{npc.name}】并清空所有 Lua 映射吗？", "删除", "取消"))
                {
                    npcList.RemoveAt(i);
                    SaveToJson(false); // 删除后自动静默保存
                    EditorGUILayout.EndHorizontal();
                    EditorGUILayout.EndVertical();
                    continue;
                }
            }
            GUI.backgroundColor = Color.white;
            EditorGUILayout.EndHorizontal();

            // --- 展开折叠项：绑定的 Lua 脚本细则清单 ---
            if (!npc.isFolded)
            {
                GUILayout.Space(8);
                Rect innerBox = EditorGUILayout.BeginVertical("GroupBox");
                EditorGUI.DrawRect(innerBox, new Color(0.18f, 0.19f, 0.2f));
                
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField("📄 剧本分支路由配置 (Lua Module Bindings):", EditorStyles.miniBoldLabel);
                GUILayout.FlexibleSpace();
                if (GUILayout.Button("➕ 添加剧本分支", GUILayout.Width(110)))
                {
                    npc.storyGraphs.Add(new DialogueGraphData { branchId = npc.storyGraphs.Count + 1, storyDescription = "新剧情路由" });
                    SaveToJson(false);
                }
                EditorGUILayout.EndHorizontal();
                GUILayout.Space(5);

                if (npc.storyGraphs.Count == 0)
                {
                    EditorGUILayout.HelpBox("该角色目前没有绑定任何 Lua 剧本。请点击右上角添加。", MessageType.None);
                }

                // 循环渲染剧本单行
                for (int j = 0; j < npc.storyGraphs.Count; j++)
                {
                    DialogueGraphData graph = npc.storyGraphs[j];
                    EditorGUILayout.BeginHorizontal("box");
                    
                    EditorGUI.BeginChangeCheck();

                    EditorGUILayout.LabelField("🎬 分支ID:", GUILayout.Width(50));
                    graph.branchId = EditorGUILayout.IntField(graph.branchId, GUILayout.Width(30));

                    EditorGUILayout.LabelField("✍️ 备注:", GUILayout.Width(35));
                    graph.storyDescription = EditorGUILayout.TextField(graph.storyDescription, GUILayout.Width(120));

                    EditorGUILayout.LabelField("🔗 拖入Lua ────►", GUILayout.Width(95));
                    Object previousAsset = graph.luaAsset;
                    graph.luaAsset = EditorGUILayout.ObjectField(graph.luaAsset, typeof(Object), false);

                    if (graph.luaAsset != previousAsset)
                    {
                        if (graph.luaAsset != null)
                        {
                            string fullAssetPath = AssetDatabase.GetAssetPath(graph.luaAsset);
                            if (Path.GetExtension(fullAssetPath).ToLower() == ".lua")
                            {
                                graph.luaModuleName = Path.GetFileNameWithoutExtension(fullAssetPath);
                                graph.luaAssetPath = fullAssetPath; 
                            }
                            else
                            {
                                EditorUtility.DisplayDialog("格式拒绝", "这里是专门绑定 .lua 脚本的槽位，无法塞入其他格式！", "我知道了");
                                graph.luaAsset = null;
                                graph.luaModuleName = "";
                                graph.luaAssetPath = "";
                            }
                        }
                        else
                        {
                            graph.luaModuleName = "";
                            graph.luaAssetPath = "";
                        }
                    }

                    GUI.enabled = false;
                    EditorGUILayout.TextField(string.IsNullOrEmpty(graph.luaModuleName) ? "[空脚本]" : $"require \"{graph.luaModuleName}\"", GUILayout.Width(160));
                    GUI.enabled = true;

                    if (GUILayout.Button("🗑️", GUILayout.Width(26)))
                    {
                        npc.storyGraphs.RemoveAt(j);
                        SaveToJson(false);
                        break;
                    }

                    if (EditorGUI.EndChangeCheck())
                    {
                        SaveToJson(false);
                    }

                    EditorGUILayout.EndHorizontal();
                    if (j < npc.storyGraphs.Count) npc.storyGraphs[j] = graph; 
                }
                EditorGUILayout.EndVertical();
            }

            EditorGUILayout.EndVertical(); 
            GUILayout.Space(10);
        }

        EditorGUILayout.EndScrollView();
    }

    /// <summary>
    /// 底部固定的 本地 JSON 持久化面板
    /// </summary>
    private void DrawBottomJsonPanel()
    {
        GUILayout.FlexibleSpace();
        
        Rect bottomRect = EditorGUILayout.BeginVertical("Box", GUILayout.Height(50));
        EditorGUI.DrawRect(bottomRect, new Color(0.11f, 0.12f, 0.13f));
        
        EditorGUILayout.BeginHorizontal();
        
        EditorGUILayout.LabelField("💾 核心数据存盘路径 (JSON):", EditorStyles.boldLabel, GUILayout.Width(160));
        jsonSavePath = EditorGUILayout.TextField(jsonSavePath);

        if (GUILayout.Button("选择位置...", GUILayout.Width(80)))
        {
            string folder = Path.GetDirectoryName(jsonSavePath);
            string file = Path.GetFileName(jsonSavePath);
            string path = EditorUtility.SaveFilePanelInProject("选择JSON保存位置", file, "json", "请选择NPC数据文件的导出位置", folder);
            if (!string.IsNullOrEmpty(path))
            {
                jsonSavePath = path;
            }
        }

        GUILayout.Space(10);

        if (GUILayout.Button("🔄 载入/刷新 JSON", GUILayout.Width(120), GUILayout.Height(22)))
        {
            LoadFromJson();
        }

        GUI.backgroundColor = new Color(0.12f, 0.58f, 0.95f); 
        if (GUILayout.Button("💾 保存导出 JSON 数据", GUILayout.Width(150), GUILayout.Height(22)))
        {
            SaveToJson(true);
        }
        GUI.backgroundColor = Color.white;

        EditorGUILayout.EndHorizontal();
        EditorGUILayout.EndVertical();
    }

    private void SaveToJson(bool showDialog = true)
    {
        SerializableNPCData container = new SerializableNPCData { npcList = this.npcList };
        string jsonStr = JsonUtility.ToJson(container, true);
        
        string dir = Path.GetDirectoryName(jsonSavePath);
        if (!Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }

        File.WriteAllText(jsonSavePath, jsonStr);
        AssetDatabase.Refresh();
        
        if (showDialog)
        {
            EditorUtility.DisplayDialog("保存成功", $"数据已成功保存至本地项目路径：\n{jsonSavePath}", "完美");
        }
    }

    private void LoadFromJson()
    {
        if (!File.Exists(jsonSavePath))
            return;

        string jsonStr = File.ReadAllText(jsonSavePath);
        if (string.IsNullOrEmpty(jsonStr)) return;

        SerializableNPCData container = JsonUtility.FromJson<SerializableNPCData>(jsonStr);
        if (container != null && container.npcList != null)
        {
            this.npcList = container.npcList;

            foreach (var npc in npcList)
            {
                if (!string.IsNullOrEmpty(npc.avatarPath))
                {
                    npc.avatar = AssetDatabase.LoadAssetAtPath<Texture2D>(npc.avatarPath);
                }

                foreach (var graph in npc.storyGraphs)
                {
                    if (!string.IsNullOrEmpty(graph.luaAssetPath))
                    {
                        graph.luaAsset = AssetDatabase.LoadAssetAtPath<Object>(graph.luaAssetPath);
                    }
                }
            }
            Repaint(); 
        }
    }
}
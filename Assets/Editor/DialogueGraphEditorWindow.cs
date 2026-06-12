#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Experimental.GraphView;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UIElements;

namespace RPGDialogueEditor
{
    [Serializable]
    public class GlobalNPCCharacter
    {
        public string id;
        public string name;
        public string avatarPath;
        public int currentBranchId = 1;
    }

    [Serializable]
    public class GlobalNPCData
    {
        public List<GlobalNPCCharacter> npcList = new List<GlobalNPCCharacter>();
    }

    /// <summary>
    /// 剧情对话数据结构体
    /// </summary>
    [Serializable]
    public class DialogueNodeData
    {
        public int id;
        public string type = "Normal"; // Normal 或 Question
        public string npcName = "新NPC";
        public string npcSprite = "CunZhang";
        public string dialogue = "";
        public int next = -1;
        public List<OptionData> options = new List<OptionData>();
        
        // 记录节点在画布中的二维坐标，确保导入时完美还原排版
        public Vector2 position; 
    }

    [Serializable]
    public class OptionData
    {
        public string id;
        public string text = "新选项";
        public int next = -1;
        public string branchFlag = "NewBranch";
    }

    /// <summary>
    /// 主编辑器窗口类
    /// </summary>
    public class DialogueGraphEditorWindow : EditorWindow
    {
        private DialogueGraphView _graphView;
        private string _lastSavePath = "Assets/Editor/DialogueData";

        public GlobalNPCData NpcConfigList = new GlobalNPCData();
        
        private string _npcConfigFilePath = "Assets/Editor/EidtData/NPCData_Config.json";

        // --- 新增：对话文件管理状态 ---
        private string _dialogueDirectory = "Assets/Editor/DialogueData";
        private string _currentDialogueFile = "";
        private ScrollView _fileScrollView;

        [MenuItem("抖音虚拟创作SDK/DialogueEditor")]
        public static void OpenWindow()
        {
            var window = GetWindow<DialogueGraphEditorWindow>();
            window.titleContent = new GUIContent("DialogueEditor");
            window.minSize = new Vector2(850, 650);
        }

        private void OnEnable()
        {
            LoadNPCConfig();
            ConstructLayout();
            
            // 默认加载第一个文件，如果没有则加载示例数据
            if (!string.IsNullOrEmpty(_currentDialogueFile) && _currentDialogueFile != "无文件")
            {
                LoadDialogueFile(_currentDialogueFile);
            }
            else
            {
                LoadDefaultExample();
            }
        }

        private void OnFocus()
        {
            LoadNPCConfig();
            RefreshAllNodesNPCList();
        }

        private void LoadNPCConfig()
        {
            if (System.IO.File.Exists(_npcConfigFilePath))
            {
                string json = System.IO.File.ReadAllText(_npcConfigFilePath);
                if (!string.IsNullOrEmpty(json))
                {
                    NpcConfigList = JsonUtility.FromJson<GlobalNPCData>(json);
                }
            }

            if (NpcConfigList == null || NpcConfigList.npcList == null)
            {
                NpcConfigList = new GlobalNPCData();
            }
        }

        private void OnDisable()
        {
            if (_graphView != null)
            {
                rootVisualElement.Remove(_graphView);
            }
        }

        /// <summary>
        /// 构建左侧控制面板与右侧画布的整体布局
        /// </summary>
        private void ConstructLayout()
        {
            var root = rootVisualElement;
            root.style.flexDirection = FlexDirection.Row;

            // 1. 创建左侧控制中心面板 (Sidebar Panel)
            var sidebar = new VisualElement();
            sidebar.style.width = 240;
            sidebar.style.backgroundColor = new Color(0.08f, 0.11f, 0.16f, 1f);
            
            sidebar.style.borderRightWidth = 1.5f;
            sidebar.style.borderRightColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            
            sidebar.style.paddingLeft = 14;
            sidebar.style.paddingRight = 14;
            sidebar.style.paddingTop = 16;
            sidebar.style.paddingBottom = 16;

            // 标题区域
            var titleContainer = new VisualElement();
            titleContainer.style.marginBottom = 18;
            
            var titleLabel = new Label("剧情编辑器");
            titleLabel.style.fontSize = 15;
            titleLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
            titleLabel.style.color = Color.white;
            
            var subtitleLabel = new Label("Dialogue Toolbox v1.0");
            subtitleLabel.style.fontSize = 10;
            subtitleLabel.style.color = new Color(0.38f, 0.45f, 1f);
            subtitleLabel.style.marginTop = 2;
            
            titleContainer.Add(titleLabel);
            titleContainer.Add(subtitleLabel);
            sidebar.Add(titleContainer);

            // ==========================================
            // 新增：文件管理区域
            // ==========================================
            var sectionFile = new Label("对话文件管理");
            sectionFile.style.fontSize = 11;
            sectionFile.style.unityFontStyleAndWeight = FontStyle.Bold;
            sectionFile.style.color = new Color(0.55f, 0.62f, 0.75f);
            sectionFile.style.marginBottom = 8;
            sidebar.Add(sectionFile);

            _fileScrollView = new ScrollView();
            _fileScrollView.style.maxHeight = 200; // 限制最大高度，防止把下面的按钮顶出去
            _fileScrollView.style.marginBottom = 6;
            _fileScrollView.style.backgroundColor = new Color(0.1f, 0.12f, 0.18f);
            
            // 增加圆角和边框质感
            _fileScrollView.style.borderTopLeftRadius = 5;
            _fileScrollView.style.borderTopRightRadius = 5;
            _fileScrollView.style.borderBottomLeftRadius = 5;
            _fileScrollView.style.borderBottomRightRadius = 5;
            _fileScrollView.style.borderTopWidth = 1;
            _fileScrollView.style.borderBottomWidth = 1;
            _fileScrollView.style.borderLeftWidth = 1;
            _fileScrollView.style.borderRightWidth = 1;
            _fileScrollView.style.borderTopColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _fileScrollView.style.borderBottomColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _fileScrollView.style.borderLeftColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _fileScrollView.style.borderRightColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);

            sidebar.Add(_fileScrollView);

            var dividerFile = new VisualElement();
            dividerFile.style.height = 1;
            dividerFile.style.backgroundColor = new Color(0.18f, 0.22f, 0.33f, 0.5f);
            dividerFile.style.marginTop = 12;
            dividerFile.style.marginBottom = 16;
            sidebar.Add(dividerFile);

            RefreshFileList();

            // 分组A：快捷创建节点 (Beautified Card Style)
            var sectionCreate = new Label("快捷创建节点");
            sectionCreate.style.fontSize = 11;
            sectionCreate.style.unityFontStyleAndWeight = FontStyle.Bold;
            sectionCreate.style.color = new Color(0.55f, 0.62f, 0.75f);
            sectionCreate.style.marginBottom = 8;
            sidebar.Add(sectionCreate);

            // 创建普通对话节点按钮
            var btnAddNormal = new Button(() => _graphView.CreateNewNode("Normal", new Vector2(100, 200)));
            StyleCardButton(btnAddNormal, "✚ 普通对话 (Normal)", "单向顺序对话，展示NPC发言内容", new Color(0.38f, 0.45f, 1f));
            sidebar.Add(btnAddNormal);

            // 创建提问选择节点按钮
            var btnAddQuestion = new Button(() => _graphView.CreateNewNode("Question", new Vector2(100, 200)));
            StyleCardButton(btnAddQuestion, "✚ NPC提问 (Question)", "多分支剧情交织，支持玩家进行回答", new Color(0.1f, 0.72f, 0.5f));
            sidebar.Add(btnAddQuestion);

            // 分割线
            var divider = new VisualElement();
            divider.style.height = 1;
            divider.style.backgroundColor = new Color(0.18f, 0.22f, 0.33f, 0.5f);
            divider.style.marginTop = 12;
            divider.style.marginBottom = 16;
            sidebar.Add(divider);

            // 分组B：全局操作配置
            var sectionConfig = new Label("全局配置操作");
            sectionConfig.style.fontSize = 11;
            sectionConfig.style.unityFontStyleAndWeight = FontStyle.Bold;
            sectionConfig.style.color = new Color(0.55f, 0.62f, 0.75f);
            sectionConfig.style.marginBottom = 8;
            sidebar.Add(sectionConfig);

            // 导入 Lua 按钮
            var btnImport = CreateActionButton("导入外部Lua配置文件", 
                () =>
                {
                    ImportLuaFile();
                    var nodeList = _graphView.GetAllDialogueNodes();
                    var dataList = new List<DialogueNodeData>();
                    foreach (var node in nodeList)
                    {
                        dataList.Add(node.Data);
                    }
                    AutoArrangeNodes(dataList);
                    foreach (var node in nodeList)
                    {
                        node.SetPosition(new Rect(node.Data.position, new Vector2(280, 250)));
                    }
                    _graphView.RebuildEdgesFromDataIds();
                    _graphView.ShowToast("画布布局已自动整理完毕！");
                }, new Color(0.15f, 0.18f, 0.25f));
            sidebar.Add(btnImport);
            
            // 导出 Lua 按钮
            var btnExport = CreateActionButton("导出外部Lua配置文件", ExportLuaFile, new Color(0.24f, 0.3f, 0.6f));
            sidebar.Add(btnExport);

            // 清空画布按钮
            var btnClear = CreateActionButton("清空当前画布", () => {
                if (EditorUtility.DisplayDialog("确认操作", "确定要清空画布上所有对话节点吗？", "确认", "取消"))
                {
                    _graphView.ClearGraph();
                    _graphView.ShowToast("画布已完全清空");
                }
            }, new Color(0.45f, 0.15f, 0.15f));
            sidebar.Add(btnClear);

            root.Add(sidebar);

            // 2. 右侧填充主画布 - 加装独立的 canvasContainer 容器并重置定位基准
            var canvasContainer = new VisualElement();
            canvasContainer.style.flexGrow = 1;
            canvasContainer.style.position = Position.Relative; // 关键：建立相对定位体系，使绘制框不因 Sidebar 产生 X 轴偏移
            root.Add(canvasContainer);

            _graphView = new DialogueGraphView(this)
            {
                name = "Dialogue Graph"
            };
            _graphView.StretchToParentSize(); // 让 Graph 填满该局部相对容器
            canvasContainer.Add(_graphView);
        }



        public void RefreshAllNodesNPCList()
        {
            if (_graphView == null) return;
            var nodes = _graphView.GetAllDialogueNodes();
            foreach (var node in nodes)
            {
                node.RefreshNPCDropdown();
            }
        }

        private void StyleCardButton(Button btn, string title, string desc, Color accentColor)
        {
            btn.style.paddingTop = 8;
            btn.style.paddingBottom = 8;
            btn.style.paddingLeft = 10;
            btn.style.paddingRight = 10;
            btn.style.marginBottom = 10;
            btn.style.backgroundColor = new Color(0.12f, 0.15f, 0.22f);
            btn.style.alignItems = Align.FlexStart;

            btn.style.borderLeftColor = accentColor;
            btn.style.borderLeftWidth = 3.5f;
            btn.style.borderRightWidth = 0;
            btn.style.borderTopWidth = 0;
            btn.style.borderBottomWidth = 0;

            btn.style.borderTopLeftRadius = 4;
            btn.style.borderBottomLeftRadius = 4;
            btn.style.borderTopRightRadius = 0;
            btn.style.borderBottomRightRadius = 0;

            btn.Clear(); 

            var titleLabel = new Label(title);
            titleLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
            titleLabel.style.color = Color.white;
            titleLabel.style.fontSize = 11;

            var descLabel = new Label(desc);
            descLabel.style.color = new Color(0.6f, 0.65f, 0.75f);
            descLabel.style.fontSize = 9;
            descLabel.style.marginTop = 3;
            descLabel.style.whiteSpace = WhiteSpace.Normal;

            btn.Add(titleLabel);
            btn.Add(descLabel);
        }

        private Button CreateActionButton(string text, Action onClick, Color bgColor)
        {
            var btn = new Button(onClick) { text = text };
            btn.style.height = 28;
            btn.style.marginBottom = 6;
            btn.style.backgroundColor = bgColor;
            btn.style.color = Color.white;
            
            btn.style.borderTopLeftRadius = 5;
            btn.style.borderTopRightRadius = 5;
            btn.style.borderBottomLeftRadius = 5;
            btn.style.borderBottomRightRadius = 5;

            btn.style.borderLeftWidth = 0;
            btn.style.borderRightWidth = 0;
            btn.style.borderTopWidth = 0;
            btn.style.borderBottomWidth = 0;
            
            btn.style.fontSize = 11;
            btn.style.unityFontStyleAndWeight = FontStyle.Bold;
            return btn;
        }

        private void LoadDefaultExample()
        {
            if (_graphView == null) return;
            _graphView.ClearGraph();

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 1,
                type = "Normal",
                npcName = "老村长",
                npcSprite = "CunZhang",
                dialogue = "年轻人，你终于来了！我需要你的帮助。",
                next = 2,
                position = new Vector2(50, 150)
            });

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 2,
                type = "Question",
                npcName = "老村长",
                npcSprite = "CunZhang",
                dialogue = "村外的山洞里出现了怪物，你愿意去调查吗？",
                next = -1,
                position = new Vector2(400, 100),
                options = new List<OptionData>
                {
                    new OptionData { id = "opt-1", text = "当然愿意！为民除害是我的职责！", next = 3, branchFlag = "AcceptQuest" },
                    new OptionData { id = "opt-2", text = "太危险了，我还有其他事情要做。", next = 4, branchFlag = "RejectQuest" },
                    new OptionData { id = "opt-3", text = "有没有报酬？", next = 5, branchFlag = "AskReward" }
                }
            });

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 3,
                type = "Normal",
                npcName = "老村长",
                npcSprite = "CunZhang",
                dialogue = "太好了！这是村子的希望，请小心行事。",
                next = 6,
                position = new Vector2(850, 50)
            });

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 4,
                type = "Normal",
                npcName = "老村长",
                npcSprite = "CunZhang_Sad",
                dialogue = "唉...那好吧，我找别人帮忙。",
                next = -1,
                position = new Vector2(850, 300)
            });

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 5,
                type = "Normal",
                npcName = "老村长",
                npcSprite = "CunZhang",
                dialogue = "当然有！完成任务后奖励100金币！",
                next = 2,
                position = new Vector2(850, 500)
            });

            _graphView.CreateNodeWithData(new DialogueNodeData
            {
                id = 6,
                type = "Normal",
                npcName = "老村长",
                npcSprite = "CunZhang",
                dialogue = "这是地图和药水，祝你好运！",
                next = -1,
                position = new Vector2(1200, 50)
            });

            _graphView.RebuildEdgesFromDataIds();
        }

        private void RefreshFileList()
        {
            if (_fileScrollView == null) return;
            _fileScrollView.Clear();

            if (!System.IO.Directory.Exists(_dialogueDirectory))
            {
                System.IO.Directory.CreateDirectory(_dialogueDirectory);
            }

            string[] filePaths = System.IO.Directory.GetFiles(_dialogueDirectory, "*.lua");
            List<string> files = new List<string>();
            foreach (var path in filePaths)
            {
                files.Add(System.IO.Path.GetFileNameWithoutExtension(path));
            }

            if (files.Count > 0 && !files.Contains(_currentDialogueFile))
            {
                _currentDialogueFile = files[0];
            }

            if (files.Count == 0)
            {
                var emptyLabel = new Label("暂无文件配置");
                emptyLabel.style.color = new Color(0.5f, 0.5f, 0.5f);
                emptyLabel.style.paddingLeft = 8;
                emptyLabel.style.paddingTop = 8;
                emptyLabel.style.paddingBottom = 8;
                _fileScrollView.Add(emptyLabel);
                return;
            }

            foreach (var file in files)
            {
                var btn = new Button(() => {
                    if (_currentDialogueFile != file) {
                        _currentDialogueFile = file;
                        LoadDialogueFile(file);
                        RefreshFileList(); // 刷新以更新选中高亮状态
                    }
                });
                
                btn.text =file;
                btn.style.unityTextAlign = TextAnchor.MiddleLeft;
                btn.style.paddingLeft = 8;
                btn.style.height = 26;
                btn.style.borderLeftWidth = 0;
                btn.style.borderRightWidth = 0;
                btn.style.borderTopWidth = 0;
                btn.style.borderBottomWidth = 1;
                btn.style.borderBottomColor = new Color(0.15f, 0.18f, 0.25f);
                btn.style.borderTopLeftRadius = 0;
                btn.style.borderTopRightRadius = 0;
                btn.style.borderBottomLeftRadius = 0;
                btn.style.borderBottomRightRadius = 0;
                btn.style.marginLeft = 0;
                btn.style.marginRight = 0;
                btn.style.marginTop = 0;
                btn.style.marginBottom = 0;

                if (_currentDialogueFile == file)
                {
                    btn.style.backgroundColor = new Color(0.24f, 0.3f, 0.6f); // 高亮当前选中
                    btn.style.color = Color.white;
                    btn.style.unityFontStyleAndWeight = FontStyle.Bold;
                }
                else
                {
                    btn.style.backgroundColor = Color.clear;
                    btn.style.color = new Color(0.7f, 0.75f, 0.85f);
                    btn.style.unityFontStyleAndWeight = FontStyle.Normal;
                }
                
                _fileScrollView.Add(btn);
            }
        }

        private void LoadDialogueFile(string fileName)
        {
            if (string.IsNullOrEmpty(fileName) || fileName == "无文件") return;
            string path = System.IO.Path.Combine(_dialogueDirectory, fileName + ".lua");
            if (!System.IO.File.Exists(path)) return;

            try
            {
                string luaText = System.IO.File.ReadAllText(path);
                bool hasSavedPositions = luaText.Contains("Position:");
                List<DialogueNodeData> parsedNodes = ParseLuaConfig(luaText);

                _graphView.ClearGraph();

                if (parsedNodes != null && parsedNodes.Count > 0)
                {
                    if (!hasSavedPositions) AutoArrangeNodes(parsedNodes);
                    
                    bool npcAdded = false;
                    foreach (var data in parsedNodes)
                    {
                        if (!string.IsNullOrEmpty(data.npcName) && !NpcConfigList.npcList.Exists(n => n.name == data.npcName))
                        {
                            NpcConfigList.npcList.Add(new GlobalNPCCharacter { id = Guid.NewGuid().ToString(), name = data.npcName, avatarPath = data.npcSprite });
                            npcAdded = true;
                        }
                    }
                    if (npcAdded)
                    {
                        // SaveNPCConfig(); // 取消保存，NPC 数据现由全局管理器维护
                        // RefreshNPCListUI();
                    }

                    foreach (var data in parsedNodes) _graphView.CreateNodeWithData(data);
                    _graphView.RebuildEdgesFromDataIds();
                    _graphView.ShowToast($"已加载: {fileName}");
                }
                else
                {
                    _graphView.ShowToast($"文件 {fileName} 为空或解析失败");
                }
            }
            catch (Exception ex)
            {
                EditorUtility.DisplayDialog("加载失败", "错误详情: " + ex.Message, "确定");
            }
        }

        private void ImportLuaFile()
        {
            string path = EditorUtility.OpenFilePanel("导入 DialogueConfig Lua 配置", _lastSavePath, "lua");
            if (string.IsNullOrEmpty(path)) return;

            try
            {
                string luaText = System.IO.File.ReadAllText(path);
                
                // 检测 Lua 内容中是否包含以前编辑器保存的 Position 元数据
                bool hasSavedPositions = luaText.Contains("Position:");
                
                List<DialogueNodeData> parsedNodes = ParseLuaConfig(luaText);

                if (parsedNodes != null && parsedNodes.Count > 0)
                {
                    _graphView.ClearGraph();
                    
                    // 如果文件里不包含 Position，或者我们想自动排列他们
                    if (!hasSavedPositions)
                    {
                        AutoArrangeNodes(parsedNodes);
                    }
                    
                    // 0. 自动将导入的未知 NPC 加入到全局配置列表中
                    bool npcAdded = false;
                    foreach (var data in parsedNodes)
                    {
                        if (!string.IsNullOrEmpty(data.npcName) && !NpcConfigList.npcList.Exists(n => n.name == data.npcName))
                        {
                            NpcConfigList.npcList.Add(new GlobalNPCCharacter { id = Guid.NewGuid().ToString(), name = data.npcName, avatarPath = data.npcSprite });
                            npcAdded = true;
                        }
                    }
                    if (npcAdded)
                    {
                        // SaveNPCConfig(); // 取消保存，NPC 数据现由全局管理器维护
                        // RefreshNPCListUI();
                    }

                    // 1. 批量实例化所有解析出的数据节点
                    foreach (var data in parsedNodes)
                    {
                        _graphView.CreateNodeWithData(data);
                    }
                    
                    // 2. 此时所有物理端口已在 UI 上渲染完毕，安全链接网络
                    _graphView.RebuildEdgesFromDataIds();
                    _graphView.ShowToast("Lua 配置导入并完成布局排版！");
                    _lastSavePath = System.IO.Path.GetDirectoryName(path);
                }
                else
                {
                    EditorUtility.DisplayDialog("解析错误", "未能从该 Lua 文件中成功匹配到任何 DialogueConfig 节点配置，请检查格式。", "确定");
                }
            }
            catch (Exception ex)
            {
                EditorUtility.DisplayDialog("导入失败", "错误详情: " + ex.Message, "确定");
            }
        }

        private void ExportLuaFile()
        {
            string path = EditorUtility.SaveFilePanel("导出 DialogueConfig Lua 配置", _lastSavePath, "DialogueConfig", "lua");
            if (string.IsNullOrEmpty(path)) return;

            try
            {
                var nodeList = _graphView.GetAllDialogueNodes();
                var dataList = new List<DialogueNodeData>();
                foreach (var node in nodeList)
                {
                    node.Data.position = node.GetPosition().position;
                    dataList.Add(node.Data);
                }

                string luaContent = GenerateLuaConfigString(dataList);
                System.IO.File.WriteAllText(path, luaContent, new UTF8Encoding(false));

                _graphView.ShowToast("Lua 配置文件成功导出！");
                _lastSavePath = System.IO.Path.GetDirectoryName(path);
                AssetDatabase.Refresh();
            }
            catch (Exception ex)
            {
                EditorUtility.DisplayDialog("导出失败", "错误详情: " + ex.Message, "确定");
            }
        }

        #region 高强弹性 LUA 语法深度嵌套解析器 & 智能流式拓扑排版算法
        private struct RawLuaBlock
        {
            public int id;
            public string content;
        }

        /// <summary>
        /// 基于有向流程图对输入节点进行自动树状流式拓扑排版（核心新增）
        /// </summary>
        private void AutoArrangeNodes(List<DialogueNodeData> nodes)
        {
            if (nodes == null || nodes.Count == 0) return;

            var adj = new Dictionary<int, List<int>>();
            var inDegree = new Dictionary<int, int>();
            var nodeMap = new Dictionary<int, DialogueNodeData>();

            foreach (var node in nodes)
            {
                adj[node.id] = new List<int>();
                inDegree[node.id] = 0;
                nodeMap[node.id] = node;
            }

            // 建立逻辑有向边关系
            foreach (var node in nodes)
            {
                if (node.type == "Normal")
                {
                    if (node.next > 0 && nodeMap.ContainsKey(node.next))
                    {
                        adj[node.id].Add(node.next);
                        inDegree[node.next]++;
                    }
                }
                else if (node.type == "Question" && node.options != null)
                {
                    foreach (var opt in node.options)
                    {
                        if (opt.next > 0 && nodeMap.ContainsKey(opt.next))
                        {
                            adj[node.id].Add(opt.next);
                            inDegree[opt.next]++;
                        }
                    }
                }
            }

            // 寻找入度为 0 的节点（也就是流程的最开始起点）
            var roots = new List<int>();
            foreach (var node in nodes)
            {
                if (inDegree[node.id] == 0)
                {
                    roots.Add(node.id);
                }
            }

            // 兜底机制：无根节点则使用 ID=1，或列表中的首个节点
            if (roots.Count == 0 && nodeMap.ContainsKey(1)) roots.Add(1);
            if (roots.Count == 0 && nodes.Count > 0) roots.Add(nodes[0].id);

            // 层次计算 (用 BFS 分层级列)
            var depths = new Dictionary<int, int>();
            var queue = new Queue<int>();
            var visited = new HashSet<int>();

            foreach (var r in roots)
            {
                depths[r] = 0;
                queue.Enqueue(r);
                visited.Add(r);
            }

            while (queue.Count > 0)
            {
                int curr = queue.Dequeue();
                int currDepth = depths[curr];

                foreach (var neighbor in adj[curr])
                {
                    // 始终取最长的逻辑链路作为深度，防止反向或循环连线把后续节点拉到前面重叠
                    if (!depths.ContainsKey(neighbor))
                    {
                        depths[neighbor] = currDepth + 1;
                    }
                    else
                    {
                        depths[neighbor] = Math.Max(depths[neighbor], currDepth + 1);
                    }

                    if (!visited.Contains(neighbor))
                    {
                        queue.Enqueue(neighbor);
                        visited.Add(neighbor);
                    }
                }
            }

            // 处理独立断开的废弃节点，让它们堆叠在最后一列
            int maxDepth = 0;
            foreach (var d in depths.Values)
            {
                if (d > maxDepth) maxDepth = d;
            }

            nodes.Sort((a, b) => a.id.CompareTo(b.id));

            foreach (var node in nodes)
            {
                if (!depths.ContainsKey(node.id))
                {
                    depths[node.id] = maxDepth + 1;
                }
            }

            // 将节点按计算好的 Depth 分列分组
            var depthLevels = new Dictionary<int, List<DialogueNodeData>>();
            foreach (var node in nodes)
            {
                int d = depths[node.id];
                if (!depthLevels.ContainsKey(d))
                {
                    depthLevels[d] = new List<DialogueNodeData>();
                }
                depthLevels[d].Add(node);
            }

            // 树形垂直对称排版渲染
            float startX = 50f;
            float startY = 150f;
            float xSpacing = 350f;
            float ySpacing = 300f; // 保证卡片加端口有充足的垂直间距

            foreach (var pair in depthLevels)
            {
                int depth = pair.Key;
                var levelNodes = pair.Value;

                // 重点：计算当前列的总高度，并相对于基准 Y 点进行对称对齐
                float totalHeight = (levelNodes.Count - 1) * ySpacing;
                float columnStartY = startY - (totalHeight / 2f);
                if (columnStartY < 50f) columnStartY = 50f; // 下限保护

                for (int i = 0; i < levelNodes.Count; i++)
                {
                    var n = levelNodes[i];
                    float x = startX + depth * xSpacing;
                    float y = columnStartY + i * ySpacing;
                    n.position = new Vector2(x, y);
                }
            }
        }

        /// <summary>
        /// 基于花括号堆栈计数的完美数据块提取器，避免了 Regex 无法支持括号嵌套的死穴
        /// </summary>
        private List<RawLuaBlock> ExtractLuaBlocks(string luaText)
        {
            var blocks = new List<RawLuaBlock>();
            // 匹配 "DialogueConfig[ID] = {"
            var blockStartRegex = new Regex(@"DialogueConfig\s*\[\s*(\d+)\s*\]\s*=\s*\{", RegexOptions.IgnoreCase);
            var matches = blockStartRegex.Matches(luaText);

            foreach (Match match in matches)
            {
                int id = int.Parse(match.Groups[1].Value);
                int openBraceIndex = match.Index + match.Length - 1; // 捕获到的 '{' 所在物理位置

                // 开始追踪花括号匹配，找到外层闭合大括号
                int braceCount = 1;
                int scan = openBraceIndex + 1;
                while (scan < luaText.Length && braceCount > 0)
                {
                    char c = luaText[scan];
                    if (c == '{') braceCount++;
                    else if (c == '}') braceCount--;
                    scan++;
                }

                if (braceCount == 0)
                {
                    // 完美提取出当前 ID 的配置块
                    string blockContent = luaText.Substring(openBraceIndex + 1, scan - openBraceIndex - 2);
                    blocks.Add(new RawLuaBlock { id = id, content = blockContent });
                }
            }
            return blocks;
        }

        private string ExtractStringField(string body, string key)
        {
            // 兼容单双引号
            var matchDouble = Regex.Match(body, key + @"\s*=\s*""([^""]*)""", RegexOptions.IgnoreCase);
            if (matchDouble.Success) return matchDouble.Groups[1].Value;

            var matchSingle = Regex.Match(body, key + @"\s*=\s*'([^']*)'", RegexOptions.IgnoreCase);
            if (matchSingle.Success) return matchSingle.Groups[1].Value;

            return "";
        }

        private int ExtractIntField(string body, string key, int defaultValue = -1)
        {
            var match = Regex.Match(body, key + @"\s*=\s*(-?\d+)", RegexOptions.IgnoreCase);
            return match.Success ? int.Parse(match.Groups[1].Value) : defaultValue;
        }

        private List<DialogueNodeData> ParseLuaConfig(string luaText)
        {
            var nodes = new List<DialogueNodeData>();
            var rawBlocks = ExtractLuaBlocks(luaText);
            int index = 0;

            foreach (var block in rawBlocks)
            {
                int id = block.id;
                string body = block.content;

                // 1. 独立解析排版坐标 (因为坐标在注释里，必须在过滤注释之前完成匹配)
                var posM = Regex.Match(body, @"Position\s*:\s*\{\s*([\d\.-]+)\s*,\s*([\d\.-]+)\s*\}", RegexOptions.IgnoreCase);
                Vector2 pos = posM.Success 
                    ? new Vector2(float.Parse(posM.Groups[1].Value), float.Parse(posM.Groups[2].Value)) 
                    : new Vector2(50 + (index % 3) * 350, 60 + (index / 3) * 350);

                // 2. 清理当前数据块的所有 Lua 注释，防止干扰字段值提取
                string cleanBody = Regex.Replace(body, @"--.*", "");

                // 3. 提取常规属性
                string type = ExtractStringField(cleanBody, "Type");
                if (string.IsNullOrEmpty(type)) type = "Normal";

                string npcName = ExtractStringField(cleanBody, "NpcName");
                string npcSprite = ExtractStringField(cleanBody, "NpcSprite");
                string dialogue = ExtractStringField(cleanBody, "Dialogue");
                int next = ExtractIntField(cleanBody, "Next", -1);

                var nodeData = new DialogueNodeData
                {
                    id = id,
                    type = type,
                    npcName = npcName,
                    npcSprite = npcSprite,
                    dialogue = dialogue.Replace("\\\"", "\""),
                    next = next,
                    position = pos,
                    options = new List<OptionData>()
                };

                // 4. 如果是问题选择节点，提取并解析 Options 数据
                if (type == "Question")
                {
                    string optionsText = "";
                    int optIndex = cleanBody.IndexOf("Options", StringComparison.OrdinalIgnoreCase);
                    if (optIndex != -1)
                    {
                        int openBrace = cleanBody.IndexOf("{", optIndex);
                        if (openBrace != -1)
                        {
                            int braceCount = 1;
                            int scan = openBrace + 1;
                            while (scan < cleanBody.Length && braceCount > 0)
                            {
                                char c = cleanBody[scan];
                                if (c == '{') braceCount++;
                                else if (c == '}') braceCount--;
                                scan++;
                            }
                            if (braceCount == 0)
                            {
                                optionsText = cleanBody.Substring(openBrace + 1, scan - openBrace - 2);
                            }
                        }
                    }

                    // 如果成功获取了 Options 区域的内容，进行子结构体反向解析
                    if (!string.IsNullOrEmpty(optionsText))
                    {
                        // 匹配 `{ Text = "...", Next = ..., BranchFlag = "..." }`
                        var optMatches = Regex.Matches(optionsText, @"\{([\s\S]*?)\}");
                        int optIdx = 1;
                        foreach (Match optMatch in optMatches)
                        {
                            string optBody = optMatch.Groups[1].Value;
                            
                            string text = ExtractStringField(optBody, "Text");
                            int nextVal = ExtractIntField(optBody, "Next", -1);
                            string flag = ExtractStringField(optBody, "BranchFlag");

                            nodeData.options.Add(new OptionData
                            {
                                id = $"opt-{id}-{optIdx++}",
                                text = text,
                                next = nextVal,
                                branchFlag = flag
                            });
                        }
                    }
                }

                nodes.Add(nodeData);
                index++;
            }

            return nodes;
        }

        private string GenerateLuaConfigString(List<DialogueNodeData> nodes)
        {
            var sb = new StringBuilder();
            sb.AppendLine("-- 对话配置文件");
            sb.AppendLine("DialogueConfig = {}\n");

            nodes.Sort((a, b) => a.id.CompareTo(b.id));

            foreach (var node in nodes)
            {
                bool isNormal = node.type == "Normal";
                sb.AppendLine(isNormal ? "-- 普通对话类型" : "-- 提问类型（玩家需要选择回答）");
                sb.AppendLine($"DialogueConfig[{node.id}] = {{");
                // sb.AppendLine($"    -- Position: {{{node.position.x:F0}, {node.position.y:F0}}}");
                sb.AppendLine($"    Type = \"{node.type}\",");
                sb.AppendLine($"    NpcName = \"{node.npcName}\",");
                sb.AppendLine($"    NpcSprite = \"{node.npcSprite}\",");
                
                string escapedDiag = (node.dialogue ?? "").Replace("\"", "\\\"");
                sb.AppendLine($"    Dialogue = \"{ escapedDiag }\",");

                if (isNormal)
                {
                    sb.AppendLine($"    Next = {node.next}  -- 下一段对话ID");
                }
                else
                {
                    sb.AppendLine("    Options = {  -- 选项列表");
                    if (node.options != null && node.options.Count > 0)
                    {
                        for (int i = 0; i < node.options.Count; i++)
                        {
                            var opt = node.options[i];
                            string comma = (i == node.options.Count - 1) ? "" : ",";
                            string escapedOptText = (opt.text ?? "").Replace("\"", "\\\"");
                            sb.AppendLine($"        {{Text = \"{escapedOptText}\", Next = {opt.next}, BranchFlag = \"{opt.branchFlag}\"}}{comma}");
                        }
                    }
                    sb.AppendLine("    }");
                }
                sb.AppendLine("}\n");
            }

            return sb.ToString();
        }
        #endregion
    }

    /// <summary>
    /// 可视化节点画布类
    /// </summary>
    public class DialogueGraphView : GraphView
    {
        private readonly DialogueGraphEditorWindow _editorWindow;
        public DialogueGraphEditorWindow EditorWindow => _editorWindow;

        public DialogueGraphView(DialogueGraphEditorWindow window)
        {
            _editorWindow = window;

            SetupZoom(ContentZoomer.DefaultMinScale, ContentZoomer.DefaultMaxScale);
            this.AddManipulator(new ContentDragger());
            this.AddManipulator(new SelectionDragger());
            this.AddManipulator(new RectangleSelector());

            var grid = new GridBackground();
            Insert(0, grid);
            grid.StretchToParentSize();

            graphViewChanged = OnGraphViewChanged;
        }

        private GraphViewChange OnGraphViewChanged(GraphViewChange graphViewChange)
        {
            if (graphViewChange.edgesToCreate != null)
            {
                foreach (var edge in graphViewChange.edgesToCreate)
                {
                    UpdateEdgeDataAssociation(edge, disconnect: false);
                }
            }

            if (graphViewChange.elementsToRemove != null)
            {
                foreach (var element in graphViewChange.elementsToRemove)
                {
                    if (element is Edge edge)
                    {
                        UpdateEdgeDataAssociation(edge, disconnect: true);
                    }
                }
            }

            return graphViewChange;
        }

        private void UpdateEdgeDataAssociation(Edge edge, bool disconnect)
        {
            var outputNode = edge.output?.node as DialogueGraphNode;
            var inputNode = edge.input?.node as DialogueGraphNode;

            if (outputNode == null || inputNode == null) return;

            int targetId = disconnect ? -1 : inputNode.Data.id;

            if (outputNode.Data.type == "Normal")
            {
                outputNode.Data.next = targetId;
                outputNode.RefreshNextFieldWithoutRebuild();
            }
            else if (outputNode.Data.type == "Question")
            {
                if (edge.output.userData is OptionData opt)
                {
                    opt.next = targetId;
                }
            }
        }

        public DialogueGraphNode CreateNewNode(string type, Vector2 position)
        {
            var nodeData = new DialogueNodeData
            {
                id = GetNextUniqueId(),
                type = type,
                position = position
            };

            if (type == "Question")
            {
                nodeData.options.Add(new OptionData { id = $"opt-{nodeData.id}-1", text = "分支选项 A", next = -1, branchFlag = "Branch_A" });
                nodeData.options.Add(new OptionData { id = $"opt-{nodeData.id}-2", text = "分支选项 B", next = -1, branchFlag = "Branch_B" });
            }

            return CreateNodeWithData(nodeData);
        }

        public DialogueGraphNode CreateNodeWithData(DialogueNodeData nodeData)
        {
            var node = new DialogueGraphNode(nodeData, this);
            node.SetPosition(new Rect(nodeData.position, new Vector2(280, 250)));
            AddElement(node);
            return node;
        }

        private int GetNextUniqueId()
        {
            int maxId = 0;
            var nodes = GetAllDialogueNodes();
            foreach (var n in nodes)
            {
                if (n.Data.id > maxId) maxId = n.Data.id;
            }
            return maxId + 1;
        }

        public List<DialogueGraphNode> GetAllDialogueNodes()
        {
            var list = new List<DialogueGraphNode>();
            foreach (var element in graphElements)
            {
                if (element is DialogueGraphNode node)
                {
                    list.Add(node);
                }
            }
            return list;
        }

        public void RebuildEdgesFromDataIds()
        {
            var edgesToRemove = new List<Edge>();
            foreach (var element in graphElements)
            {
                if (element is Edge edge)
                {
                    edgesToRemove.Add(edge);
                }
            }
            foreach (var edge in edgesToRemove)
            {
                RemoveElement(edge);
            }

            var nodes = GetAllDialogueNodes();

            foreach (var sourceNode in nodes)
            {
                if (sourceNode.Data.type == "Normal")
                {
                    if (sourceNode.Data.next > 0)
                    {
                        var targetNode = nodes.Find(n => n.Data.id == sourceNode.Data.next);
                        if (targetNode != null && targetNode.InputPort != null && sourceNode.NextPort != null)
                        {
                            LinkPorts(sourceNode.NextPort, targetNode.InputPort);
                        }
                    }
                }
                else if (sourceNode.Data.type == "Question")
                {
                    foreach (var option in sourceNode.Data.options)
                    {
                        if (option.next > 0)
                        {
                            var targetNode = nodes.Find(n => n.Data.id == option.next);
                            var optionPort = sourceNode.GetPortByOption(option);
                            if (targetNode != null && targetNode.InputPort != null && optionPort != null)
                            {
                                LinkPorts(optionPort, targetNode.InputPort);
                            }
                        }
                    }
                }
            }
        }

        private void LinkPorts(Port output, Port input)
        {
            var edge = output.ConnectTo(input);
            AddElement(edge);
        }

        public void ClearGraph()
        {
            var elementsToRemove = new List<GraphElement>(graphElements);
            foreach (var element in elementsToRemove)
            {
                RemoveElement(element);
            }
        }

        public override List<Port> GetCompatiblePorts(Port startPort, NodeAdapter nodeAdapter)
        {
            var compatiblePorts = new List<Port>();
            ports.ForEach(port =>
            {
                if (startPort != port && startPort.node != port.node && startPort.direction != port.direction)
                {
                    compatiblePorts.Add(port);
                }
            });
            return compatiblePorts;
        }

        public void ShowToast(string message)
        {
            _editorWindow.ShowNotification(new GUIContent(message));
        }
    }

    /// <summary>
    /// 自定义可视化节点卡片类
    /// </summary>
    public class DialogueGraphNode : Node
    {
        public DialogueNodeData Data { get; private set; }
        private readonly DialogueGraphView _graphView;

        public Port InputPort { get; private set; }
        public Port NextPort { get; private set; } // Normal 专用
        private readonly List<Port> _optionPorts = new List<Port>(); // Question 专用

        private VisualElement _customContainer;
        private IntegerField _idField;
        private DropdownField _npcDropdown;
        private Label _spriteLabel;
        private TextField _dialogueField;
        private IntegerField _nextIdField; // Normal 专用

        public DialogueGraphNode(DialogueNodeData data, DialogueGraphView graphView)
        {
            Data = data;
            _graphView = graphView;

            title = data.type == "Normal" ? "普通对话 (Normal)" : "NPC提问 (Question)";
            style.width = 280;
            
            style.borderTopLeftRadius = 10;
            style.borderTopRightRadius = 10;
            style.borderBottomLeftRadius = 10;
            style.borderBottomRightRadius = 10;

            style.borderLeftWidth = 1.5f;
            style.borderRightWidth = 1.5f;
            style.borderTopWidth = 1.5f;
            style.borderBottomWidth = 1.5f;

            Color nodeBorderColor = data.type == "Normal" ? new Color(0.38f, 0.45f, 1f, 0.8f) : new Color(0.1f, 0.72f, 0.5f, 0.8f);
            style.borderLeftColor = nodeBorderColor;
            style.borderRightColor = nodeBorderColor;
            style.borderTopColor = nodeBorderColor;
            style.borderBottomColor = nodeBorderColor;

            style.overflow = Overflow.Hidden;

            ConstructNodeUI();
            
            // 核心生命周期：实例化节点卡片时，一旦 options 数据存在，立刻完整触发 UI 刷新及 Output 端口建立
            if (Data.type == "Question" && Data.options != null)
            {
                RefreshOptionsContainerUI();
            }
        }

        private void BeautifyField(VisualElement field)
        {
            field.style.marginBottom = 6;
            var label = field.Q<Label>();
            if (label != null)
            {
                label.style.color = new Color(0.65f, 0.72f, 0.85f);
                label.style.fontSize = 11;
                label.style.minWidth = 70;
            }
            var textInput = field.Q("unity-text-input");
            if (textInput == null) textInput = field.Q(className: "unity-base-popup-field__input");
            
            if (textInput != null)
            {
                textInput.style.backgroundColor = new Color(0.05f, 0.06f, 0.1f, 1.0f);
                
                Color inputBorderCol = new Color(0.18f, 0.22f, 0.33f, 1.0f);
                textInput.style.borderLeftColor = inputBorderCol;
                textInput.style.borderRightColor = inputBorderCol;
                textInput.style.borderTopColor = inputBorderCol;
                textInput.style.borderBottomColor = inputBorderCol;

                textInput.style.borderTopLeftRadius = 5;
                textInput.style.borderTopRightRadius = 5;
                textInput.style.borderBottomLeftRadius = 5;
                textInput.style.borderBottomRightRadius = 5;

                textInput.style.paddingLeft = 5;
                textInput.style.color = Color.white;
            }
        }

        private void ConstructNodeUI()
        {
            ConstructInputPort();

            _customContainer = new VisualElement();
            _customContainer.style.paddingLeft = 10;
            _customContainer.style.paddingRight = 10;
            _customContainer.style.paddingTop = 8;
            _customContainer.style.paddingBottom = 8;
            _customContainer.style.backgroundColor = new Color(0.09f, 0.11f, 0.16f, 0.95f);
            
            _idField = new IntegerField("唯一编号") { value = Data.id };
            _idField.RegisterValueChangedCallback(evt =>
            {
                int oldId = Data.id;
                Data.id = evt.newValue;
                _graphView.ShowToast($"节点 ID 已变更: {evt.newValue}");
                
                if (oldId == 1 || evt.newValue == 1)
                {
                    ConstructInputPort();
                }
            });
            BeautifyField(_idField);
            _customContainer.Add(_idField);

            _npcDropdown = new DropdownField("选择NPC");
            _npcDropdown.RegisterValueChangedCallback(evt =>
            {
                Data.npcName = evt.newValue;
                var npc = _graphView.EditorWindow.NpcConfigList.npcList.Find(n => n.name == evt.newValue);
                if (npc != null)
                {
                    string spriteName = string.IsNullOrEmpty(npc.avatarPath) ? "" : System.IO.Path.GetFileNameWithoutExtension(npc.avatarPath);
                    Data.npcSprite = spriteName;
                    if (_spriteLabel != null) _spriteLabel.text = $"[立绘] {spriteName}";
                }
            });
            BeautifyField(_npcDropdown);
            _customContainer.Add(_npcDropdown);

            _spriteLabel = new Label($"[立绘] {Data.npcSprite}");
            _spriteLabel.style.color = new Color(0.5f, 0.6f, 0.7f);
            _spriteLabel.style.fontSize = 10;
            _spriteLabel.style.marginBottom = 6;
            _spriteLabel.style.marginLeft = 75; // 对齐下拉框
            _customContainer.Add(_spriteLabel);

            RefreshNPCDropdown();

            _dialogueField = new TextField("对话文本")
            {
                value = Data.dialogue,
                multiline = true
            };
            _dialogueField.style.maxHeight = 60;
            BeautifyField(_dialogueField);
            _dialogueField.RegisterValueChangedCallback(evt => Data.dialogue = evt.newValue);
            _customContainer.Add(_dialogueField);

            if (Data.type == "Normal")
            {
                // 创建极客蓝 NextPort 连线物理圆点
                NextPort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                NextPort.portName = " ";
                NextPort.portColor = new Color(0.38f, 0.45f, 1f); 

                // 重点：将 NextPort 直接集成并对齐在“跳转ID”行右侧，不依赖单独的 outputContainer，实现物理效果
                var nextIdRow = new VisualElement();
                nextIdRow.style.flexDirection = FlexDirection.Row;
                nextIdRow.style.alignItems = Align.Center;

                _nextIdField = new IntegerField("跳转ID") { value = Data.next };
                _nextIdField.style.flexGrow = 1;
                _nextIdField.style.marginBottom = 0; // 消除底部边距，使之一行平齐
                _nextIdField.RegisterValueChangedCallback(evt => Data.next = evt.newValue);
                BeautifyField(_nextIdField);
                nextIdRow.Add(_nextIdField);

                // 将端口追加在最右侧，稍微往右边界外拉出实现悬浮效果
                NextPort.style.width = 18;
                NextPort.style.height = 18;
                NextPort.style.alignSelf = Align.Center;
                NextPort.style.marginLeft = 6;
                NextPort.style.marginRight = -14; 
                nextIdRow.Add(NextPort);

                _customContainer.Add(nextIdRow);
            }
            else if (Data.type == "Question")
            {
                var btnAddOpt = new Button(AddNewOption)
                {
                    text = "✚ 添加玩家选择分支"
                };
                btnAddOpt.style.marginTop = 6;
                btnAddOpt.style.marginBottom = 6;
                btnAddOpt.style.height = 24;

                btnAddOpt.style.borderTopLeftRadius = 6;
                btnAddOpt.style.borderTopRightRadius = 6;
                btnAddOpt.style.borderBottomLeftRadius = 6;
                btnAddOpt.style.borderBottomRightRadius = 6;

                btnAddOpt.style.borderLeftWidth = 0;
                btnAddOpt.style.borderRightWidth = 0;
                btnAddOpt.style.borderTopWidth = 0;
                btnAddOpt.style.borderBottomWidth = 0;

                btnAddOpt.style.backgroundColor = new Color(0.08f, 0.45f, 0.28f, 1f); 
                btnAddOpt.style.color = Color.white;
                btnAddOpt.style.unityFontStyleAndWeight = FontStyle.Bold;
                _customContainer.Add(btnAddOpt);

                var optContainer = new VisualElement { name = "OptionsContainer" };
                _customContainer.Add(optContainer);
            }

            mainContainer.Add(_customContainer);
            
            titleContainer.style.backgroundColor = Data.type == "Normal" 
                ? new Color(0.12f, 0.16f, 0.28f, 1.0f) 
                : new Color(0.08f, 0.24f, 0.16f, 1.0f);
            var titleLabel = titleContainer.Q<Label>();
            if (titleLabel != null)
            {
                titleLabel.style.fontSize = 12;
                titleLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
                titleLabel.style.color = Color.white;
            }
        }

        private void ConstructInputPort()
        {
            inputContainer.Clear();
            InputPort = null;

            if (Data.id != 1)
            {
                InputPort = Port.Create<Edge>(Orientation.Horizontal, Direction.Input, Port.Capacity.Multi, typeof(float));
                InputPort.portName = " ";
                InputPort.portColor = new Color(0.38f, 0.45f, 1f); 
                inputContainer.Add(InputPort);
            }
            inputContainer.MarkDirtyRepaint();
        }

        /// <summary>
        /// 全量刷新选项 UI 容器布局，并将每个 Option 的 Output 物理连接口直接嵌入到分支右侧！
        /// </summary>
        public void RefreshOptionsContainerUI()
        {
            var optContainer = _customContainer.Q<VisualElement>("OptionsContainer");
            if (optContainer == null) return;

            optContainer.Clear();
            _optionPorts.Clear();

            for (int i = 0; i < Data.options.Count; i++)
            {
                var option = Data.options[i];
                var localIndex = i;

                // 大结构体盒模型：水平横向排列，最左侧放置控制内容，最右侧嵌入连线物理口
                var optBox = new VisualElement();
                optBox.style.flexDirection = FlexDirection.Row;
                optBox.style.alignItems = Align.Center;
                optBox.style.height = 54;
                optBox.style.marginTop = 4;
                optBox.style.paddingBottom = 4;
                optBox.style.borderBottomWidth = 1;
                optBox.style.borderBottomColor = new Color(0.2f, 0.25f, 0.35f, 0.4f);

                // 左侧主要配置区域容器
                var fieldsContainer = new VisualElement();
                fieldsContainer.style.flexGrow = 1;

                var tfText = new TextField($"选项#{localIndex + 1}") { value = option.text };
                tfText.RegisterValueChangedCallback(evt => option.text = evt.newValue);
                BeautifyField(tfText);
                fieldsContainer.Add(tfText);

                var innerRow = new VisualElement();
                innerRow.style.flexDirection = FlexDirection.Row;

                var nfNext = new IntegerField("跳转") { value = option.next };
                nfNext.style.width = 95;
                nfNext.RegisterValueChangedCallback(evt => option.next = evt.newValue);
                BeautifyField(nfNext);
                innerRow.Add(nfNext);

                var tfFlag = new TextField("标签") { value = option.branchFlag };
                tfFlag.style.flexGrow = 1;
                tfFlag.RegisterValueChangedCallback(evt => option.branchFlag = evt.newValue);
                BeautifyField(tfFlag);
                innerRow.Add(tfFlag);

                var btnDel = new Button(() => DeleteOption(option))
                {
                    text = "✕"
                };
                btnDel.style.backgroundColor = new Color(0.72f, 0.15f, 0.15f, 1f);
                btnDel.style.color = Color.white;
                btnDel.style.borderTopLeftRadius = 4;
                btnDel.style.borderTopRightRadius = 4;
                btnDel.style.borderBottomLeftRadius = 4;
                btnDel.style.borderBottomRightRadius = 4;
                btnDel.style.borderLeftWidth = 0;
                btnDel.style.borderRightWidth = 0;
                btnDel.style.borderTopWidth = 0;
                btnDel.style.borderBottomWidth = 0;
                btnDel.style.marginLeft = 4;
                btnDel.style.width = 20;
                btnDel.style.height = 18;
                innerRow.Add(btnDel);

                optBox.Add(fieldsContainer);

                // 创建专属于选项的 Output 物理连线小圆点（翡翠绿）并放置于最右边，略微拉出卡片外部实现完美平齐
                var optPort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                optPort.portName = " ";
                optPort.portColor = new Color(0.1f, 0.72f, 0.5f); // 翡翠绿连线配色
                optPort.userData = option;
                
                // 细节美化：微调端口位置让圆点自然嵌入在卡片右边框外围，实现极高的质感
                optPort.style.width = 18;
                optPort.style.height = 18;
                optPort.style.alignSelf = Align.Center;
                optPort.style.marginLeft = 6;
                optPort.style.marginRight = -14; 
                
                optBox.Add(optPort);
                _optionPorts.Add(optPort);

                optContainer.Add(optBox);
            }

            RefreshExpandedState();
        }

        public void RefreshNextFieldWithoutRebuild()
        {
            if (_nextIdField != null)
            {
                _nextIdField.SetValueWithoutNotify(Data.next);
            }
        }

        public void RefreshNPCDropdown()
        {
            if (_npcDropdown == null) return;
            var npcs = _graphView.EditorWindow.NpcConfigList.npcList;
            var names = new List<string>();
            foreach (var n in npcs) names.Add(n.name);
            
            if (names.Count == 0) names.Add("None");
            
            _npcDropdown.choices = names;
            
            if (names.Contains(Data.npcName))
            {
                _npcDropdown.SetValueWithoutNotify(Data.npcName);
                var npc = npcs.Find(n => n.name == Data.npcName);
                if (npc != null && _spriteLabel != null)
                {
                    string spriteName = string.IsNullOrEmpty(npc.avatarPath) ? "" : System.IO.Path.GetFileNameWithoutExtension(npc.avatarPath);
                    _spriteLabel.text = $"[立绘] {spriteName}";
                    Data.npcSprite = spriteName;
                }
            }
            else
            {
                Data.npcName = names[0];
                _npcDropdown.SetValueWithoutNotify(Data.npcName);
                var npc = npcs.Find(n => n.name == Data.npcName);
                if (npc != null)
                {
                    string spriteName = string.IsNullOrEmpty(npc.avatarPath) ? "" : System.IO.Path.GetFileNameWithoutExtension(npc.avatarPath);
                    Data.npcSprite = spriteName;
                    if (_spriteLabel != null) _spriteLabel.text = $"[立绘] {spriteName}";
                }
            }
        }

        private void AddNewOption()
        {
            int nextIdx = Data.options.Count + 1;
            Data.options.Add(new OptionData
            {
                id = $"opt-{Data.id}-{DateTime.Now.Ticks}",
                text = $"新建选项 {nextIdx}",
                next = -1,
                branchFlag = $"Flag_{nextIdx}"
            });

            RefreshOptionsContainerUI();
            _graphView.ShowToast("添加新选项分支成功");
        }

        private void DeleteOption(OptionData option)
        {
            Data.options.Remove(option);
            RefreshOptionsContainerUI();
            
            _graphView.RebuildEdgesFromDataIds();
            _graphView.ShowToast("分支已成功移除");
        }

        public Port GetPortByOption(OptionData option)
        {
            return _optionPorts.Find(p => p.userData == option);
        }
    }
}
#endif
#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Linq;
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
    public class GlobalNPCStoryGraph
    {
        public int branchId = 1;
        public string storyDescription = "";
        public string luaModuleName = "";
        public string luaAssetPath = "";
    }

    [Serializable]
    public class GlobalNPCCharacter
    {
        public string id;
        public string name;
        public string avatarPath;
        public int currentBranchId = 1;
        public List<GlobalNPCStoryGraph> storyGraphs = new List<GlobalNPCStoryGraph>();
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
        public List<UnlockBranchData> unlockBranches = new List<UnlockBranchData>(); // 执行到该节点时，将指定 NPC 的 currentBranchId 改为对应值
        public List<ConditionBranch> conditionBranches = new List<ConditionBranch>(); // 基于全局变量的条件分支：按顺序判断，第一个满足条件的分支生效

        // 记录节点在画布中的二维坐标，确保导入时完美还原排版
        public Vector2 position;
    }

    [Serializable]
    public class UnlockBranchData
    {
        public string npcName = "";  // 要解锁的 NPC 名称
        public int branchId = 0;     // 解锁到的分支 ID（>0 才有效）
    }

    [Serializable]
    public class GlobalVariable
    {
        public string name = "";
        public string type = "bool"; // "bool" 或 "int"
        public bool boolValue = false;
        public int intValue = 0;
    }

    [Serializable]
    public class ConditionBranch
    {
        public string varName = "";       // 引用的全局变量名
        // bool 模式：两个独立端口，分别对应 true 和 false 分支
        public int trueNextNodeId = -1;
        public int falseNextNodeId = -1;
        // int 模式：操作符 + 比较值 + 一个端口
        public string op = "==";
        public int intCompareValue = 0;
        public int intNextNodeId = -1;
    }

    // 条件分支端口绑定标记：区分 true/false/int 三种端口
    public class ConditionBranchPortTag
    {
        public ConditionBranch branch;
        public string tag; // "true" / "false" / "int"
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
        
        private string _npcConfigFilePath = "Assets/Editor/EidtData/NPCData_Config.lua";

        // --- 新增：全局变量管理 ---
        private string _globalVarsFilePath = "Assets/Editor/EidtData/GlobalVariables.lua";
        public List<GlobalVariable> GlobalVariables = new List<GlobalVariable>();
        private ScrollView _globalVarScrollView;

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
            LoadGlobalVariables();
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
            LoadGlobalVariables();
            RefreshAllNodesNPCList();
            RefreshGlobalVariablesUI();
        }

        private void LoadNPCConfig()
        {
            if (System.IO.File.Exists(_npcConfigFilePath))
            {
                string luaContent = System.IO.File.ReadAllText(_npcConfigFilePath);
                if (!string.IsNullOrEmpty(luaContent))
                {
                    NpcConfigList = ParseLuaNPCConfig(luaContent);
                }
            }

            if (NpcConfigList == null || NpcConfigList.npcList == null)
            {
                NpcConfigList = new GlobalNPCData();
            }
        }

        // ============ 全局变量：读取文件 ============
        private void LoadGlobalVariables()
        {
            if (System.IO.File.Exists(_globalVarsFilePath))
            {
                string luaContent = System.IO.File.ReadAllText(_globalVarsFilePath);
                if (!string.IsNullOrEmpty(luaContent))
                {
                    GlobalVariables = ParseGlobalVariablesLuaString(luaContent);
                }
            }
            if (GlobalVariables == null)
            {
                GlobalVariables = new List<GlobalVariable>();
            }
        }

        // ============ 全局变量：写入文件 ============
        private void SaveGlobalVariables()
        {
            if (GlobalVariables == null) GlobalVariables = new List<GlobalVariable>();
            string dir = System.IO.Path.GetDirectoryName(_globalVarsFilePath);
            if (!System.IO.Directory.Exists(dir))
            {
                System.IO.Directory.CreateDirectory(dir);
            }
            string content = GenerateGlobalVariablesLuaString(GlobalVariables);
            System.IO.File.WriteAllText(_globalVarsFilePath, content);
            AssetDatabase.Refresh();
        }

        // ============ 全局变量：序列化为 Lua 文本 ============
        private string GenerateGlobalVariablesLuaString(List<GlobalVariable> variables)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("local GlobalVariables = {");
            if (variables != null)
            {
                for (int i = 0; i < variables.Count; i++)
                {
                    var v = variables[i];
                    sb.Append("    ");
                    sb.Append("{ ");
                    sb.Append("name = \"");
                    sb.Append(v.name);
                    sb.Append("\", type = \"");
                    sb.Append(v.type);
                    sb.Append("\", ");
                    if (v.type == "int")
                    {
                        sb.Append("value = ");
                        sb.Append(v.intValue);
                    }
                    else
                    {
                        sb.Append("value = ");
                        sb.Append(v.boolValue ? "true" : "false");
                    }
                    sb.Append(" }");
                    if (i < variables.Count - 1) sb.Append(",");
                    sb.AppendLine();
                }
            }
            sb.AppendLine("}");
            sb.AppendLine("return GlobalVariables");
            return sb.ToString();
        }

        // ============ 全局变量：从 Lua 文本解析 ============
        private List<GlobalVariable> ParseGlobalVariablesLuaString(string luaText)
        {
            List<GlobalVariable> result = new List<GlobalVariable>();
            try
            {
                int pos = 0;
                SkipLuaWhitespace(luaText, ref pos);
                // 跳到第一个 "{"
                while (pos < luaText.Length && luaText[pos] != '{') pos++;
                if (pos >= luaText.Length) return result;
                pos++; // 跳过 {

                while (pos < luaText.Length)
                {
                    SkipLuaWhitespace(luaText, ref pos);
                    if (pos >= luaText.Length) break;
                    if (luaText[pos] == '}') break;
                    if (luaText[pos] == ',') { pos++; continue; }

                    // 找到一个 { ... } 变量块
                    if (luaText[pos] == '{')
                    {
                        pos++;
                        GlobalVariable gv = new GlobalVariable();
                        while (pos < luaText.Length)
                        {
                            SkipLuaWhitespace(luaText, ref pos);
                            if (pos >= luaText.Length) break;
                            if (luaText[pos] == '}') { pos++; break; }
                            if (luaText[pos] == ',') { pos++; continue; }

                            // 读取 key
                            int keyStart = pos;
                            while (pos < luaText.Length && char.IsLetterOrDigit(luaText[pos])) pos++;
                            string key = luaText.Substring(keyStart, pos - keyStart);

                            SkipLuaWhitespace(luaText, ref pos);
                            if (pos < luaText.Length && luaText[pos] == '=') pos++;
                            SkipLuaWhitespace(luaText, ref pos);

                            if (key == "name")
                            {
                                gv.name = ParseLuaString(luaText, ref pos);
                            }
                            else if (key == "type")
                            {
                                gv.type = ParseLuaString(luaText, ref pos);
                            }
                            else if (key == "value")
                            {
                                // 可能是 bool 也可能是 int，根据 type 判断 + 直接读
                                if (pos < luaText.Length && (luaText[pos] == 't' || luaText[pos] == 'T' || luaText[pos] == 'f' || luaText[pos] == 'F'))
                                {
                                    // bool 值
                                    int valStart = pos;
                                    while (pos < luaText.Length && char.IsLetter(luaText[pos])) pos++;
                                    string valStr = luaText.Substring(valStart, pos - valStart).ToLower();
                                    gv.boolValue = (valStr == "true");
                                    gv.intValue = gv.boolValue ? 1 : 0;
                                }
                                else
                                {
                                    // int 值
                                    gv.intValue = ParseLuaInt(luaText, ref pos);
                                    gv.boolValue = (gv.intValue != 0);
                                }
                            }
                            else
                            {
                                // 跳过未知值
                                if (pos < luaText.Length && luaText[pos] == '"')
                                {
                                    ParseLuaString(luaText, ref pos);
                                }
                                else
                                {
                                    while (pos < luaText.Length && luaText[pos] != ',' && luaText[pos] != '}') pos++;
                                }
                            }
                        }
                        if (!string.IsNullOrEmpty(gv.name))
                        {
                            result.Add(gv);
                        }
                    }
                    else
                    {
                        pos++;
                    }
                }
            }
            catch (Exception)
            {
            }
            return result;
        }

        // ============ 全局变量：刷新右侧面板 UI ============
        public void RefreshGlobalVariablesUI()
        {
            if (_globalVarScrollView == null) return;
            _globalVarScrollView.Clear();

            if (GlobalVariables == null || GlobalVariables.Count == 0)
            {
                var emptyLabel = new Label("— 无变量 —");
                emptyLabel.style.fontSize = 10;
                emptyLabel.style.color = new Color(0.45f, 0.5f, 0.6f);
                emptyLabel.style.unityTextAlign = TextAnchor.MiddleCenter;
                emptyLabel.style.paddingTop = 20;
                emptyLabel.style.paddingBottom = 20;
                _globalVarScrollView.Add(emptyLabel);
                return;
            }

            for (int i = 0; i < GlobalVariables.Count; i++)
            {
                var gv = GlobalVariables[i];
                int captureIdx = i;

                var card = new VisualElement();
                card.style.backgroundColor = new Color(0.12f, 0.15f, 0.22f);
                card.style.borderTopLeftRadius = 4;
                card.style.borderTopRightRadius = 4;
                card.style.borderBottomLeftRadius = 4;
                card.style.borderBottomRightRadius = 4;
                card.style.paddingTop = 6;
                card.style.paddingBottom = 6;
                card.style.paddingLeft = 6;
                card.style.paddingRight = 6;
                card.style.marginBottom = 6;
                card.style.marginLeft = 4;
                card.style.marginRight = 4;

                // 第一行：变量名 + 删除按钮
                var row1 = new VisualElement();
                row1.style.flexDirection = FlexDirection.Row;
                row1.style.alignItems = Align.Center;
                row1.style.marginBottom = 4;

                var nameField = new TextField("名字");
                nameField.value = gv.name;
                nameField.style.maxWidth = 100;
                nameField.style.minWidth = 70;
                nameField.style.marginRight = 4;
                nameField.labelElement.style.minWidth = 28;
                nameField.labelElement.style.width = 28;
                nameField.RegisterValueChangedCallback(evt =>
                {
                    gv.name = evt.newValue;
                    SaveGlobalVariables();
                });
                BeautifyField_Small(nameField);
                row1.Add(nameField);

                var typeField = new PopupField<string>("类型", new List<string> { "bool", "int" }, gv.type);
                typeField.style.width = 78;
                typeField.style.minWidth = 78;
                typeField.style.flexGrow = 0;
                typeField.labelElement.style.minWidth = 28;
                typeField.labelElement.style.width = 28;
                typeField.RegisterValueChangedCallback(evt =>
                {
                    gv.type = evt.newValue;
                    RefreshGlobalVariablesUI();
                    SaveGlobalVariables();
                });
                BeautifyField_Small(typeField);
                row1.Add(typeField);

                var delBtn = new Button(() =>
                {
                    GlobalVariables.RemoveAt(captureIdx);
                    RefreshGlobalVariablesUI();
                    SaveGlobalVariables();
                }) { text = "✕" };
                delBtn.style.width = 22;
                delBtn.style.height = 20;
                delBtn.style.minWidth = 22;
                delBtn.style.marginLeft = 2;
                delBtn.style.flexGrow = 0;
                delBtn.style.backgroundColor = new Color(0.55f, 0.2f, 0.2f, 0.9f);
                row1.Add(delBtn);

                card.Add(row1);

                // 第二行：值输入
                var row2 = new VisualElement();
                row2.style.flexDirection = FlexDirection.Row;
                row2.style.alignItems = Align.Center;

                if (gv.type == "bool")
                {
                    var toggle = new Toggle("值");
                    toggle.value = gv.boolValue;
                    toggle.style.flexGrow = 1;
                    toggle.style.height = 22;
                    toggle.labelElement.style.minWidth = 28;
                    toggle.labelElement.style.width = 28;
                    toggle.style.color = new Color(1f, 0.85f, 0.6f);
                    toggle.RegisterValueChangedCallback(evt =>
                    {
                        gv.boolValue = evt.newValue;
                        gv.intValue = evt.newValue ? 1 : 0;
                        SaveGlobalVariables();
                    });
                    row2.Add(toggle);
                }
                else
                {
                    var intField = new IntegerField("值");
                    intField.value = gv.intValue;
                    intField.style.flexGrow = 1;
                    intField.labelElement.style.minWidth = 28;
                    intField.labelElement.style.width = 28;
                    intField.RegisterValueChangedCallback(evt =>
                    {
                        gv.intValue = evt.newValue;
                        gv.boolValue = (evt.newValue != 0);
                        SaveGlobalVariables();
                    });
                    BeautifyField_Small(intField);
                    row2.Add(intField);
                }

                card.Add(row2);
                _globalVarScrollView.Add(card);
            }
        }

        // 小型字段样式辅助
        private void BeautifyField_Small(VisualElement field)
        {
            field.style.fontSize = 10;
        }

        private static GlobalNPCData ParseLuaNPCConfig(string luaContent)
        {
            GlobalNPCData result = new GlobalNPCData();
            try
            {
                int pos = 0;
                SkipLuaWhitespace(luaContent, ref pos);
                SkipThroughKey(luaContent, "npcList", ref pos);
                SkipLuaWhitespace(luaContent, ref pos);
                if (pos < luaContent.Length && luaContent[pos] == '=') pos++;
                SkipLuaWhitespace(luaContent, ref pos);
                if (pos < luaContent.Length && luaContent[pos] == '{') pos++;

                while (pos < luaContent.Length)
                {
                    SkipLuaWhitespace(luaContent, ref pos);
                    if (pos >= luaContent.Length) break;
                    if (luaContent[pos] == '}') break;

                    if (luaContent[pos] == ',') { pos++; continue; }

                    SkipLuaWhitespace(luaContent, ref pos);
                    if (pos < luaContent.Length && luaContent[pos] == '{')
                    {
                        pos++;
                        GlobalNPCCharacter npc = ParseLuaNPC(luaContent, ref pos);
                        if (npc != null)
                        {
                            result.npcList.Add(npc);
                        }
                    }
                    else
                    {
                        pos++;
                    }
                }
            }
            catch (Exception)
            {
            }
            return result;
        }

        private static GlobalNPCCharacter ParseLuaNPC(string luaContent, ref int pos)
        {
            GlobalNPCCharacter npc = new GlobalNPCCharacter();
            while (pos < luaContent.Length)
            {
                SkipLuaWhitespace(luaContent, ref pos);
                if (pos >= luaContent.Length) break;
                if (luaContent[pos] == '}') { pos++; break; }
                if (luaContent[pos] == ',') { pos++; continue; }

                int keyStart = pos;
                while (pos < luaContent.Length && char.IsLetterOrDigit(luaContent[pos])) pos++;
                string key = luaContent.Substring(keyStart, pos - keyStart);

                SkipLuaWhitespace(luaContent, ref pos);
                if (pos < luaContent.Length && luaContent[pos] == '=') pos++;
                SkipLuaWhitespace(luaContent, ref pos);

                if (key == "id") npc.id = ParseLuaString(luaContent, ref pos);
                else if (key == "name") npc.name = ParseLuaString(luaContent, ref pos);
                else if (key == "avatarPath") npc.avatarPath = ParseLuaString(luaContent, ref pos);
                else if (key == "currentBranchId") npc.currentBranchId = ParseLuaInt(luaContent, ref pos);
                else if (key == "storyGraphs") npc.storyGraphs = ParseLuaStoryGraphList(luaContent, ref pos);
                else SkipLuaValue(luaContent, ref pos);
            }
            return npc;
        }

        private static List<GlobalNPCStoryGraph> ParseLuaStoryGraphList(string luaContent, ref int pos)
        {
            List<GlobalNPCStoryGraph> list = new List<GlobalNPCStoryGraph>();
            SkipLuaWhitespace(luaContent, ref pos);
            if (pos < luaContent.Length && luaContent[pos] == '=') pos++;
            SkipLuaWhitespace(luaContent, ref pos);
            if (pos < luaContent.Length && luaContent[pos] == '{') pos++;

            while (pos < luaContent.Length)
            {
                SkipLuaWhitespace(luaContent, ref pos);
                if (pos >= luaContent.Length) break;
                if (luaContent[pos] == '}') { pos++; break; }
                if (luaContent[pos] == ',') { pos++; continue; }

                SkipLuaWhitespace(luaContent, ref pos);
                if (pos < luaContent.Length && luaContent[pos] == '{')
                {
                    pos++;
                    var sg = ParseLuaStoryGraph(luaContent, ref pos);
                    if (sg != null) list.Add(sg);
                }
                else pos++;
            }
            return list;
        }

        private static GlobalNPCStoryGraph ParseLuaStoryGraph(string luaContent, ref int pos)
        {
            var sg = new GlobalNPCStoryGraph();
            while (pos < luaContent.Length)
            {
                SkipLuaWhitespace(luaContent, ref pos);
                if (pos >= luaContent.Length) break;
                if (luaContent[pos] == '}') { pos++; break; }
                if (luaContent[pos] == ',') { pos++; continue; }

                int keyStart = pos;
                while (pos < luaContent.Length && char.IsLetterOrDigit(luaContent[pos])) pos++;
                string key = luaContent.Substring(keyStart, pos - keyStart);

                SkipLuaWhitespace(luaContent, ref pos);
                if (pos < luaContent.Length && luaContent[pos] == '=') pos++;
                SkipLuaWhitespace(luaContent, ref pos);

                if (key == "branchId") sg.branchId = ParseLuaInt(luaContent, ref pos);
                else if (key == "storyDescription") sg.storyDescription = ParseLuaString(luaContent, ref pos);
                else if (key == "luaModuleName") sg.luaModuleName = ParseLuaString(luaContent, ref pos);
                else if (key == "luaAssetPath") sg.luaAssetPath = ParseLuaString(luaContent, ref pos);
                else SkipLuaValue(luaContent, ref pos);
            }
            return sg;
        }

        private static string ParseLuaString(string luaContent, ref int pos)
        {
            SkipLuaWhitespace(luaContent, ref pos);
            if (pos >= luaContent.Length) return "";
            if (luaContent[pos] == '"' || luaContent[pos] == '\'')
            {
                char quote = luaContent[pos];
                pos++;
                int start = pos;
                while (pos < luaContent.Length && luaContent[pos] != quote)
                {
                    if (luaContent[pos] == '\\' && pos + 1 < luaContent.Length)
                    {
                        pos += 2;
                    }
                    else
                    {
                        pos++;
                    }
                }
                string result = luaContent.Substring(start, pos - start);
                if (pos < luaContent.Length) pos++;
                return result;
            }
            return "";
        }

        private static int ParseLuaInt(string luaContent, ref int pos)
        {
            SkipLuaWhitespace(luaContent, ref pos);
            int start = pos;
            if (pos < luaContent.Length && luaContent[pos] == '-') pos++;
            while (pos < luaContent.Length && char.IsDigit(luaContent[pos])) pos++;
            string numStr = luaContent.Substring(start, pos - start);
            int result;
            if (int.TryParse(numStr, out result)) return result;
            return 1;
        }

        private static void SkipLuaValue(string luaContent, ref int pos)
        {
            SkipLuaWhitespace(luaContent, ref pos);
            if (pos >= luaContent.Length) return;
            if (luaContent[pos] == '"' || luaContent[pos] == '\'')
            {
                char quote = luaContent[pos]; pos++;
                while (pos < luaContent.Length && luaContent[pos] != quote)
                {
                    if (luaContent[pos] == '\\' && pos + 1 < luaContent.Length) pos += 2; else pos++;
                }
                if (pos < luaContent.Length) pos++;
            }
            else if (luaContent[pos] == '{')
            {
                int depth = 1; pos++;
                while (pos < luaContent.Length && depth > 0)
                {
                    if (luaContent[pos] == '{') depth++;
                    else if (luaContent[pos] == '}') depth--;
                    pos++;
                }
            }
            else
            {
                while (pos < luaContent.Length && luaContent[pos] != ',' && luaContent[pos] != '}') pos++;
            }
        }

        private static void SkipLuaWhitespace(string luaContent, ref int pos)
        {
            while (pos < luaContent.Length && (luaContent[pos] == ' ' || luaContent[pos] == '\t' || luaContent[pos] == '\n' || luaContent[pos] == '\r')) pos++;
        }

        private static void SkipThroughKey(string luaContent, string targetKey, ref int pos)
        {
            while (pos < luaContent.Length)
            {
                if (pos + targetKey.Length < luaContent.Length &&
                    luaContent.Substring(pos, targetKey.Length) == targetKey)
                {
                    pos += targetKey.Length;
                    return;
                }
                pos++;
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
            var btnAddNormal = new Button(() => _graphView.CreateNewNode("Normal", Vector2.zero));
            StyleCardButton(btnAddNormal, "✚ 普通对话 (Normal)", "单向顺序对话，展示NPC发言内容", new Color(0.38f, 0.45f, 1f));
            sidebar.Add(btnAddNormal);

            // 创建提问选择节点按钮
            var btnAddQuestion = new Button(() => _graphView.CreateNewNode("Question", Vector2.zero));
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
                        node.SetPosition(new Rect(node.Data.position, new Vector2(340, 250)));
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

            // 2. 中间填充主画布 - 加装独立的 canvasContainer 容器并重置定位基准
            var canvasContainer = new VisualElement();
            canvasContainer.style.flexGrow = 1;
            canvasContainer.style.position = Position.Relative;
            root.Add(canvasContainer);

            _graphView = new DialogueGraphView(this)
            {
                name = "Dialogue Graph"
            };
            _graphView.StretchToParentSize();
            canvasContainer.Add(_graphView);

            // 3. 右侧：全局变量管理面板
            var rightSidebar = new VisualElement();
            rightSidebar.style.width = 260;
            rightSidebar.style.backgroundColor = new Color(0.08f, 0.11f, 0.16f, 1f);
            rightSidebar.style.borderLeftWidth = 1.5f;
            rightSidebar.style.borderLeftColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            rightSidebar.style.paddingLeft = 14;
            rightSidebar.style.paddingRight = 14;
            rightSidebar.style.paddingTop = 16;
            rightSidebar.style.paddingBottom = 16;

            var gvTitleContainer = new VisualElement();
            gvTitleContainer.style.marginBottom = 14;

            var gvTitle = new Label("全局变量");
            gvTitle.style.fontSize = 15;
            gvTitle.style.unityFontStyleAndWeight = FontStyle.Bold;
            gvTitle.style.color = Color.white;

            var gvSub = new Label("Global Variables");
            gvSub.style.fontSize = 10;
            gvSub.style.color = new Color(1f, 0.7f, 0.3f);
            gvSub.style.marginTop = 2;

            gvTitleContainer.Add(gvTitle);
            gvTitleContainer.Add(gvSub);
            rightSidebar.Add(gvTitleContainer);

            var gvFileLabel = new Label("保存路径");
            gvFileLabel.style.fontSize = 10;
            gvFileLabel.style.color = new Color(0.55f, 0.62f, 0.75f);
            gvFileLabel.style.marginBottom = 4;
            rightSidebar.Add(gvFileLabel);

            var gvFileText = new Label(_globalVarsFilePath);
            gvFileText.style.fontSize = 9;
            gvFileText.style.color = new Color(0.4f, 0.45f, 0.55f);
            gvFileText.style.marginBottom = 12;
            rightSidebar.Add(gvFileText);

            _globalVarScrollView = new ScrollView();
            _globalVarScrollView.style.flexGrow = 1;
            _globalVarScrollView.style.backgroundColor = new Color(0.1f, 0.12f, 0.18f);
            _globalVarScrollView.style.borderTopLeftRadius = 5;
            _globalVarScrollView.style.borderTopRightRadius = 5;
            _globalVarScrollView.style.borderBottomLeftRadius = 5;
            _globalVarScrollView.style.borderBottomRightRadius = 5;
            _globalVarScrollView.style.borderTopWidth = 1;
            _globalVarScrollView.style.borderBottomWidth = 1;
            _globalVarScrollView.style.borderLeftWidth = 1;
            _globalVarScrollView.style.borderRightWidth = 1;
            _globalVarScrollView.style.borderTopColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _globalVarScrollView.style.borderBottomColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _globalVarScrollView.style.borderLeftColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _globalVarScrollView.style.borderRightColor = new Color(0.18f, 0.22f, 0.33f, 1.0f);
            _globalVarScrollView.style.paddingTop = 6;
            _globalVarScrollView.style.paddingBottom = 6;
            rightSidebar.Add(_globalVarScrollView);

            // 操作按钮区域
            var btnAddBool = new Button(() =>
            {
                GlobalVariables.Add(new GlobalVariable { name = "newBool", type = "bool", boolValue = false });
                RefreshGlobalVariablesUI();
                SaveGlobalVariables();
            });
            StyleCardButton(btnAddBool, "+ Bool (True/False)", "添加一个 bool 类型的变量", new Color(0.7f, 0.55f, 0.3f));
            btnAddBool.style.marginTop = 8;
            rightSidebar.Add(btnAddBool);

            var btnAddInt = new Button(() =>
            {
                GlobalVariables.Add(new GlobalVariable { name = "newInt", type = "int", intValue = 0 });
                RefreshGlobalVariablesUI();
                SaveGlobalVariables();
            });
            StyleCardButton(btnAddInt, "+ Int (整数)", "添加一个 int 类型的变量", new Color(0.45f, 0.65f, 0.9f));
            rightSidebar.Add(btnAddInt);

            var btnSaveVars = new Button(() =>
            {
                SaveGlobalVariables();
                _graphView.ShowToast("全局变量已保存");
            });
            StyleCardButton(btnSaveVars, "保存变量", "立即把所有变量写入 GlobalVariables.lua", new Color(0.18f, 0.5f, 0.3f));
            rightSidebar.Add(btnSaveVars);

            var btnClearVars = new Button(() =>
            {
                if (EditorUtility.DisplayDialog("确认", "是否清空全部全局变量？", "确认", "取消"))
                {
                    GlobalVariables.Clear();
                    RefreshGlobalVariablesUI();
                    SaveGlobalVariables();
                }
            });
            StyleCardButton(btnClearVars, "清空全部", "清空所有变量", new Color(0.5f, 0.15f, 0.15f));
            rightSidebar.Add(btnClearVars);

            root.Add(rightSidebar);

            RefreshGlobalVariablesUI();
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

                // 条件分支边：无论 Normal 还是 Question 节点都可能有
                if (node.conditionBranches != null && node.conditionBranches.Count > 0)
                {
                    foreach (var cb in node.conditionBranches)
                    {
                        string varType = "bool";
                        var gv = GlobalVariables?.FirstOrDefault(v => v.name == cb.varName);
                        if (gv != null) varType = gv.type;

                        if (varType == "bool")
                        {
                            if (cb.trueNextNodeId > 0 && nodeMap.ContainsKey(cb.trueNextNodeId))
                            {
                                adj[node.id].Add(cb.trueNextNodeId);
                                inDegree[cb.trueNextNodeId]++;
                            }
                            if (cb.falseNextNodeId > 0 && nodeMap.ContainsKey(cb.falseNextNodeId))
                            {
                                adj[node.id].Add(cb.falseNextNodeId);
                                inDegree[cb.falseNextNodeId]++;
                            }
                        }
                        else
                        {
                            if (cb.intNextNodeId > 0 && nodeMap.ContainsKey(cb.intNextNodeId))
                            {
                                adj[node.id].Add(cb.intNextNodeId);
                                inDegree[cb.intNextNodeId]++;
                            }
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

                // 3.5 解析 UnlockBranches 数组（新格式）
                var unlockList = new List<UnlockBranchData>();
                int ubIndex = cleanBody.IndexOf("UnlockBranches", StringComparison.OrdinalIgnoreCase);
                if (ubIndex != -1)
                {
                    int ubBrace = cleanBody.IndexOf('{', ubIndex);
                    if (ubBrace != -1)
                    {
                        int ubDepth = 1;
                        int ubScan = ubBrace + 1;
                        while (ubScan < cleanBody.Length && ubDepth > 0)
                        {
                            if (cleanBody[ubScan] == '{') ubDepth++;
                            else if (cleanBody[ubScan] == '}') ubDepth--;
                            ubScan++;
                        }
                        // ubScan 现在指向最外层 '}' 的下一位
                        string ubText = cleanBody.Substring(ubBrace + 1, ubScan - ubBrace - 2);

                        // 匹配每一个 { NpcName = "...", BranchId = N } 形式
                        var ubMatches = Regex.Matches(ubText, @"NpcName\s*=\s*""([^""]*)""[^}]*?BranchId\s*=\s*(\d+)");
                        foreach (Match ubm in ubMatches)
                        {
                            unlockList.Add(new UnlockBranchData
                            {
                                npcName = ubm.Groups[1].Value,
                                branchId = int.Parse(ubm.Groups[2].Value)
                            });
                        }
                    }
                }

                // 兼容旧格式：UnlockBranchId（单个整数）
                if (unlockList.Count == 0)
                {
                    int legacyUnlockId = ExtractIntField(cleanBody, "UnlockBranchId", 0);
                    if (legacyUnlockId > 0)
                    {
                        unlockList.Add(new UnlockBranchData
                        {
                            npcName = npcName,
                            branchId = legacyUnlockId
                        });
                    }
                }

                // 3.7 解析 ConditionBranches 条件分支（基于全局变量的条件跳转）
                var condList = new List<ConditionBranch>();
                int cbIndex = cleanBody.IndexOf("ConditionBranches", StringComparison.OrdinalIgnoreCase);
                if (cbIndex != -1)
                {
                    int cbBrace = cleanBody.IndexOf('{', cbIndex);
                    if (cbBrace != -1)
                    {
                        int cbDepth = 1;
                        int cbScan = cbBrace + 1;
                        while (cbScan < cleanBody.Length && cbDepth > 0)
                        {
                            if (cleanBody[cbScan] == '{') cbDepth++;
                            else if (cleanBody[cbScan] == '}') cbDepth--;
                            cbScan++;
                        }
                        string cbText = cleanBody.Substring(cbBrace + 1, cbScan - cbBrace - 2);

                        // 匹配每一个 { VarName = "...", ... }
                        var cbMatches = Regex.Matches(cbText, @"\{([\s\S]*?)\}");
                        foreach (Match cbm in cbMatches)
                        {
                            string cbBody = cbm.Groups[1].Value;
                            string vName = ExtractStringField(cbBody, "VarName");
                            string vType = ExtractStringField(cbBody, "VarType");

                            if (string.IsNullOrEmpty(vName)) continue;

                            var cond = new ConditionBranch { varName = vName };

                            if (vType == "int")
                            {
                                cond.op = ExtractStringField(cbBody, "Op");
                                if (string.IsNullOrEmpty(cond.op)) cond.op = "==";
                                // 解析 Value 字段 — 可能是整数
                                var valMatch = Regex.Match(cbBody, @"Value\s*=\s*(\S+)", RegexOptions.IgnoreCase);
                                if (valMatch.Success)
                                {
                                    string valRaw = valMatch.Groups[1].Value.Trim().TrimEnd(',', ' ');
                                    if (int.TryParse(valRaw, out int iv)) cond.intCompareValue = iv;
                                }
                                cond.intNextNodeId = ExtractIntField(cbBody, "Next", -1);
                            }
                            else // 默认 bool 模式
                            {
                                cond.trueNextNodeId = ExtractIntField(cbBody, "TrueNext", -1);
                                cond.falseNextNodeId = ExtractIntField(cbBody, "FalseNext", -1);
                            }
                            condList.Add(cond);
                        }
                    }
                }

                var nodeData = new DialogueNodeData
                {
                    id = id,
                    type = type,
                    npcName = npcName,
                    npcSprite = npcSprite,
                    dialogue = dialogue.Replace("\\\"", "\""),
                    next = next,
                    unlockBranches = unlockList,
                    conditionBranches = condList,
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

                if (node.unlockBranches != null && node.unlockBranches.Count > 0)
                {
                    // 只输出有效条目（npcName 非空 且 branchId > 0）
                    var validEntries = node.unlockBranches.Where(u => !string.IsNullOrEmpty(u.npcName) && u.branchId > 0).ToList();
                    if (validEntries.Count > 0)
                    {
                        sb.AppendLine($"    UnlockBranches = {{");
                        for (int i = 0; i < validEntries.Count; i++)
                        {
                            var u = validEntries[i];
                            string comma = (i == validEntries.Count - 1) ? "" : ",";
                            sb.AppendLine($"        {{ NpcName = \"{u.npcName}\", BranchId = {u.branchId} }}{comma}");
                        }
                        sb.AppendLine("    },");
                    }
                }

                if (node.conditionBranches != null && node.conditionBranches.Count > 0)
                {
                    var validEntries = node.conditionBranches
                        .Where(c => !string.IsNullOrEmpty(c.varName)
                            && (c.trueNextNodeId > 0 || c.falseNextNodeId > 0 || c.intNextNodeId > 0))
                        .ToList();
                    if (validEntries.Count > 0)
                    {
                        sb.AppendLine($"    ConditionBranches = {{");
                        for (int i = 0; i < validEntries.Count; i++)
                        {
                            var c = validEntries[i];
                            string comma = (i == validEntries.Count - 1) ? "" : ",";
                            string varType = "bool";
                            var gv = GlobalVariables.FirstOrDefault(v => v.name == c.varName);
                            if (gv != null) varType = gv.type;

                            if (varType == "bool")
                            {
                                sb.AppendLine($"        {{ VarName = \"{c.varName}\", VarType = \"bool\", TrueNext = {c.trueNextNodeId}, FalseNext = {c.falseNextNodeId} }}{comma}");
                            }
                            else
                            {
                                sb.AppendLine($"        {{ VarName = \"{c.varName}\", VarType = \"int\", Op = \"{c.op}\", Value = {c.intCompareValue}, Next = {c.intNextNodeId} }}{comma}");
                            }
                        }
                        sb.AppendLine("    },");
                    }
                }

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

            // 先检查是否是条件分支端口（任何类型节点都可能有）
            if (edge.output.userData is ConditionBranchPortTag portTag)
            {
                if (portTag.tag == "true")
                    portTag.branch.trueNextNodeId = targetId;
                else if (portTag.tag == "false")
                    portTag.branch.falseNextNodeId = targetId;
                else if (portTag.tag == "int")
                    portTag.branch.intNextNodeId = targetId;

                RefreshConditionBranchFieldWithoutRebuild(outputNode, portTag.branch, portTag.tag);
                return;
            }

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

        private void RefreshConditionBranchFieldWithoutRebuild(DialogueGraphNode node, ConditionBranch targetCond, string fieldTag)
        {
            var condContainer = node.Q<VisualElement>("ConditionBranchesContainer");
            if (condContainer == null) return;

            // 按索引找到对应字段并刷新值
            int idx = node.Data.conditionBranches.IndexOf(targetCond);
            if (idx < 0) return;
            int cardCount = 0;
            foreach (var child in condContainer.Children())
            {
                if (child is Label) continue;
                if (cardCount == idx)
                {
                    // bool 模式：两个整数输入框
                    var allFields = child.Query<IntegerField>().ToList();
                    if (fieldTag == "true" && allFields.Count >= 1)
                    {
                        allFields[0].SetValueWithoutNotify(targetCond.trueNextNodeId);
                    }
                    else if (fieldTag == "false" && allFields.Count >= 2)
                    {
                        allFields[1].SetValueWithoutNotify(targetCond.falseNextNodeId);
                    }
                    else if (fieldTag == "int" && allFields.Count >= 2)
                    {
                        allFields[1].SetValueWithoutNotify(targetCond.intNextNodeId);
                    }
                    return;
                }
                cardCount++;
            }
        }

        public DialogueGraphNode CreateNewNode(string type, Vector2 position)
        {
            // 如果传入的是 Vector2.zero（默认位置），则自动放到视图中心
            Vector2 finalPos = position;
            if (finalPos == Vector2.zero)
            {
                finalPos = GetViewCenterPosition();
            }

            var nodeData = new DialogueNodeData
            {
                id = GetNextUniqueId(),
                type = type,
                position = finalPos
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
            node.SetPosition(new Rect(nodeData.position, new Vector2(340, 250)));
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

        // 获取当前视图中心的内容坐标（新节点会创建在这里）
        public Vector2 GetViewCenterPosition()
        {
            // 屏幕坐标 = 内容坐标 * scale + position
            // 内容坐标 = (屏幕坐标 - position) / scale
            Vector2 viewCenterScreen = contentRect.size * 0.5f;
            Vector3 viewPos = viewTransform.position;
            Vector3 viewScale = viewTransform.scale;
            float scale = viewScale.x > 0.1f ? viewScale.x : 1f;

            Vector2 centerContent = new Vector2(
                (viewCenterScreen.x - viewPos.x) / scale,
                (viewCenterScreen.y - viewPos.y) / scale
            );

            // 减去节点尺寸的一半，使节点中心对齐视图中心（节点约 340x250）
            return new Vector2(centerContent.x - 170f, centerContent.y - 125f);
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

                // 条件分支连线（任何类型节点都可能有）
                if (sourceNode.Data.conditionBranches != null && sourceNode.Data.conditionBranches.Count > 0)
                {
                    foreach (var cb in sourceNode.Data.conditionBranches)
                    {
                        string varType = "bool";
                        var gv = EditorWindow?.GlobalVariables?.FirstOrDefault(v => v.name == cb.varName);
                        if (gv != null) varType = gv.type;

                        if (varType == "bool")
                        {
                            // true 分支
                            if (cb.trueNextNodeId > 0)
                            {
                                var targetNode = nodes.Find(n => n.Data.id == cb.trueNextNodeId);
                                var truePort = sourceNode.GetPortByConditionBranch(cb, "true");
                                if (targetNode != null && targetNode.InputPort != null && truePort != null)
                                {
                                    LinkPorts(truePort, targetNode.InputPort);
                                }
                            }
                            // false 分支
                            if (cb.falseNextNodeId > 0)
                            {
                                var targetNode = nodes.Find(n => n.Data.id == cb.falseNextNodeId);
                                var falsePort = sourceNode.GetPortByConditionBranch(cb, "false");
                                if (targetNode != null && targetNode.InputPort != null && falsePort != null)
                                {
                                    LinkPorts(falsePort, targetNode.InputPort);
                                }
                            }
                        }
                        else // int 模式
                        {
                            if (cb.intNextNodeId > 0)
                            {
                                var targetNode = nodes.Find(n => n.Data.id == cb.intNextNodeId);
                                var intPort = sourceNode.GetPortByConditionBranch(cb, "int");
                                if (targetNode != null && targetNode.InputPort != null && intPort != null)
                                {
                                    LinkPorts(intPort, targetNode.InputPort);
                                }
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
        private readonly List<Port> _conditionBranchPorts = new List<Port>(); // 条件分支专用

        private VisualElement _customContainer;
        private VisualElement _nextPortRow; // 跳转ID行容器（便于动态移除/重建）
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
            style.width = 340;
            
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

            style.overflow = Overflow.Visible;

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
            label.style.minWidth = 55;
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
            _customContainer.style.overflow = Overflow.Visible;
            
            _idField = new IntegerField("ID") { value = Data.id };
            _idField.style.maxWidth = 110;
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

            _npcDropdown = new DropdownField("NPC");
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

            // 把 ID 和 NPC 选择器放在同一行，节省空间
            var headerRow = new VisualElement();
            headerRow.style.flexDirection = FlexDirection.Row;
            headerRow.style.marginBottom = 2;
            headerRow.Add(_idField);
            headerRow.Add(_npcDropdown);
            _customContainer.Add(headerRow);

            _spriteLabel = new Label($"[立绘] {Data.npcSprite}");
            _spriteLabel.style.color = new Color(0.5f, 0.6f, 0.7f);
            _spriteLabel.style.fontSize = 10;
            _spriteLabel.style.marginBottom = 6;
            _spriteLabel.style.marginLeft = 5; // 与上面一行对齐
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

            // 解锁规则：NPC下拉 + 分支下拉
            var unlockHeader = new Label("✦ 解锁分支（执行该节点后自动更新 NPC 配置）");
            unlockHeader.style.color = new Color(0.9f, 0.7f, 0.35f);
            unlockHeader.style.fontSize = 11;
            unlockHeader.style.marginBottom = 4;
            unlockHeader.style.unityFontStyleAndWeight = FontStyle.Bold;
            _customContainer.Add(unlockHeader);

            var unlockContainer = new VisualElement();
            unlockContainer.name = "UnlockBranchesContainer";
            unlockContainer.style.marginBottom = 6;
            _customContainer.Add(unlockContainer);

            void RefreshUnlockUI()
            {
                unlockContainer.Clear();

                if (Data.unlockBranches == null)
                    Data.unlockBranches = new List<UnlockBranchData>();

                // 拿到所有 NPC 名字列表
                var npcNames = new List<string>();
                if (_graphView.EditorWindow.NpcConfigList != null && _graphView.EditorWindow.NpcConfigList.npcList != null)
                {
                    foreach (var n in _graphView.EditorWindow.NpcConfigList.npcList)
                    {
                        if (!string.IsNullOrEmpty(n.name)) npcNames.Add(n.name);
                    }
                }

                for (int i = 0; i < Data.unlockBranches.Count; i++)
                {
                    int localIdx = i;
                    var ubData = Data.unlockBranches[localIdx];

                    var row = new VisualElement();
                    row.style.flexDirection = FlexDirection.Column;
                    row.style.marginBottom = 6;
                    row.style.backgroundColor = new Color(0.1f, 0.12f, 0.18f, 0.8f);
                    row.style.borderTopLeftRadius = 6;
                    row.style.borderTopRightRadius = 6;
                    row.style.borderBottomLeftRadius = 6;
                    row.style.borderBottomRightRadius = 6;
                    row.style.paddingTop = 4;
                    row.style.paddingBottom = 4;
                    row.style.paddingLeft = 4;
                    row.style.paddingRight = 4;

                    // NPC 下拉框
                    var npcDropdown = new DropdownField("NPC", npcNames, ubData.npcName);
                    npcDropdown.style.flexGrow = 1;
                    npcDropdown.style.marginRight = 6;
                    npcDropdown.style.marginBottom = 2;
                    BeautifyField(npcDropdown);
                    row.Add(npcDropdown);

                    // 分支下拉框（根据选中的 NPC 动态变化，显示 storyDescription）
                    DropdownField branchDropdown = null;
                    // 保存描述到 branchId 的映射
                    Dictionary<string, int> descToBranchId = new Dictionary<string, int>();
                    System.Action refreshBranchDropdown = () =>
                    {
                        var branches = new List<string>();
                        descToBranchId.Clear();
                        var currentNPC = _graphView.EditorWindow.NpcConfigList?.npcList?.FirstOrDefault(n => n.name == npcDropdown.value);
                        if (currentNPC != null && currentNPC.storyGraphs != null)
                        {
                            foreach (var sg in currentNPC.storyGraphs)
                            {
                                string desc = string.IsNullOrEmpty(sg.storyDescription) ? $"分支 {sg.branchId}" : sg.storyDescription;
                                branches.Add(desc);
                                descToBranchId[desc] = sg.branchId;
                            }
                        }
                        if (branchDropdown != null)
                        {
                            branchDropdown.choices = branches;
                            // 用 ubData.branchId 反查对应的描述
                            string wanted = branches.FirstOrDefault(b => descToBranchId.ContainsKey(b) && descToBranchId[b] == ubData.branchId);
                            branchDropdown.value = wanted ?? (branches.Count > 0 ? branches[0] : "");
                            if (!string.IsNullOrEmpty(branchDropdown.value) && descToBranchId.TryGetValue(branchDropdown.value, out int bId))
                            {
                                ubData.branchId = bId;
                            }
                        }
                    };

                    branchDropdown = new DropdownField("分支", new List<string>(), "");
                    branchDropdown.style.flexGrow = 1;
                    branchDropdown.style.marginRight = 6;
                    branchDropdown.style.marginBottom = 2;
                    BeautifyField(branchDropdown);
                    row.Add(branchDropdown);

                    npcDropdown.RegisterValueChangedCallback(evt =>
                    {
                        ubData.npcName = evt.newValue;
                        refreshBranchDropdown();
                    });

                    branchDropdown.RegisterValueChangedCallback(evt =>
                    {
                        if (!string.IsNullOrEmpty(evt.newValue) && descToBranchId.TryGetValue(evt.newValue, out int bId))
                        {
                            ubData.branchId = bId;
                        }
                    });

                    // 初次渲染分支下拉
                    refreshBranchDropdown();

                    // 删除按钮（单独一行右对齐）
                    var btnRow = new VisualElement();
                    btnRow.style.flexDirection = FlexDirection.Row;
                    btnRow.style.justifyContent = Justify.FlexEnd;
                    var removeBtn = new Button(() =>
                    {
                        Data.unlockBranches.RemoveAt(localIdx);
                        RefreshUnlockUI();
                    })
                    { text = "✕ 删除此规则" };
                    removeBtn.style.height = 20;
                    removeBtn.style.fontSize = 10;
                    removeBtn.style.backgroundColor = new Color(0.6f, 0.25f, 0.25f, 0.9f);
                    btnRow.Add(removeBtn);
                    row.Add(btnRow);

                    unlockContainer.Add(row);
                }

                var hintLabel = new Label(Data.unlockBranches.Count(u => !string.IsNullOrEmpty(u.npcName) && u.branchId > 0) > 0
                    ? $"✓ 共 {Data.unlockBranches.Count(u => !string.IsNullOrEmpty(u.npcName) && u.branchId > 0)} 条解锁规则"
                    : "（当前无解锁规则，点击下方按钮添加）");
                hintLabel.style.color = new Color(0.55f, 0.75f, 0.55f);
                hintLabel.style.fontSize = 10;
                hintLabel.style.marginLeft = 4;
                hintLabel.style.marginTop = 2;
                unlockContainer.Add(hintLabel);
            }

            var addUnlockBtn = new Button(() =>
            {
                if (Data.unlockBranches == null)
                    Data.unlockBranches = new List<UnlockBranchData>();

                // 默认用当前节点的 NPC，如果它有分支的话
                var defaultBranchId = 1;
                var npc = _graphView.EditorWindow.NpcConfigList?.npcList?.FirstOrDefault(n => n.name == Data.npcName);
                if (npc != null && npc.storyGraphs != null && npc.storyGraphs.Count > 0)
                {
                    // 选一个不同于当前 currentBranchId 的分支
                    var other = npc.storyGraphs.FirstOrDefault(s => s.branchId != npc.currentBranchId);
                    defaultBranchId = other != null ? other.branchId : npc.storyGraphs[0].branchId;
                }

                Data.unlockBranches.Add(new UnlockBranchData { npcName = Data.npcName, branchId = defaultBranchId });
                RefreshUnlockUI();
            })
            { text = "✚ 添加解锁规则" };
            addUnlockBtn.style.marginTop = 0;
            addUnlockBtn.style.marginBottom = 4;
            addUnlockBtn.style.height = 24;
            addUnlockBtn.style.backgroundColor = new Color(0.15f, 0.35f, 0.5f, 0.9f);
            _customContainer.Add(addUnlockBtn);

            RefreshUnlockUI();

            // ========= 条件分支：基于全局变量的跳转规则 =========
            var condHeader = new Label("✦ 条件分支（满足条件时跳转到指定节点，优先于默认 Next）");
            condHeader.style.color = new Color(0.75f, 0.9f, 1f);
            condHeader.style.fontSize = 11;
            condHeader.style.marginTop = 2;
            condHeader.style.marginBottom = 4;
            condHeader.style.unityFontStyleAndWeight = FontStyle.Bold;
            _customContainer.Add(condHeader);

            var condContainer = new VisualElement();
            condContainer.name = "ConditionBranchesContainer";
            condContainer.style.marginBottom = 6;
            condContainer.style.overflow = Overflow.Visible;
            _customContainer.Add(condContainer);

            void RefreshConditionUI()
            {
                condContainer.Clear();
                _conditionBranchPorts.Clear();
                if (Data.conditionBranches == null)
                    Data.conditionBranches = new List<ConditionBranch>();

                // 拿到全局变量名列表
                var varNames = new List<string>();
                if (_graphView.EditorWindow.GlobalVariables != null)
                {
                    foreach (var gv in _graphView.EditorWindow.GlobalVariables)
                    {
                        if (!string.IsNullOrEmpty(gv.name)) varNames.Add(gv.name);
                    }
                }

                for (int i = 0; i < Data.conditionBranches.Count; i++)
                {
                    int localIdx = i;
                    var cond = Data.conditionBranches[localIdx];

                    // 根据变量类型决定布局
                    string currentVarType = "bool";
                    var curVar = _graphView.EditorWindow.GlobalVariables?.FirstOrDefault(v => v.name == cond.varName);
                    if (curVar != null) currentVarType = curVar.type;

                    if (currentVarType == "bool")
                    {
                        // ============ bool 模式：一张卡片 + 两个端口 ============
                        var card = new VisualElement();
                        card.name = "CondCard_" + localIdx;
                        card.style.backgroundColor = new Color(0.1f, 0.14f, 0.22f, 0.9f);
                        card.style.borderTopLeftRadius = 6;
                        card.style.borderTopRightRadius = 6;
                        card.style.borderBottomLeftRadius = 6;
                        card.style.borderBottomRightRadius = 6;
                        card.style.paddingTop = 6;
                        card.style.paddingBottom = 6;
                        card.style.paddingLeft = 6;
                        card.style.paddingRight = 0;
                        card.style.marginBottom = 4;
                        card.style.overflow = Overflow.Visible;

                        // 第一行：变量名 + 删除按钮
                        var row0 = new VisualElement();
                        row0.style.flexDirection = FlexDirection.Row;
                        row0.style.alignItems = Align.Center;
                        row0.style.marginBottom = 4;
                        row0.style.paddingRight = 6;

                        var varDropdown = new DropdownField("变量", varNames,
                            string.IsNullOrEmpty(cond.varName) ? (varNames.Count > 0 ? varNames[0] : "") : cond.varName);
                        varDropdown.style.flexGrow = 1;
                        varDropdown.style.maxWidth = 220;
                        varDropdown.style.marginRight = 6;
                        BeautifyField(varDropdown);
                        varDropdown.RegisterValueChangedCallback(evt =>
                        {
                            cond.varName = evt.newValue;
                        });
                        row0.Add(varDropdown);

                        var delBtn = new Button(() =>
                        {
                            Data.conditionBranches.RemoveAt(localIdx);
                            RefreshConditionUI();
                            RefreshNextPortUI();
                            _graphView.RebuildEdgesFromDataIds();
                        })
                        { text = "✕" };
                        delBtn.style.width = 20;
                        delBtn.style.height = 20;
                        delBtn.style.backgroundColor = new Color(0.6f, 0.25f, 0.25f, 0.9f);
                        row0.Add(delBtn);

                        card.Add(row0);

                        // 第二行：true 分支 + 绿色端口
                        var rowTrue = new VisualElement();
                        rowTrue.style.flexDirection = FlexDirection.Row;
                        rowTrue.style.alignItems = Align.Center;
                        rowTrue.style.marginBottom = 3;
                        rowTrue.style.overflow = Overflow.Visible;
                        rowTrue.style.paddingRight = 6;

                        var trueLabel = new Label("✓ true");
                        trueLabel.style.color = new Color(0.35f, 0.85f, 0.45f);
                        trueLabel.style.fontSize = 11;
                        trueLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
                        trueLabel.style.minWidth = 40;
                        trueLabel.style.width = 40;
                        rowTrue.Add(trueLabel);

                        var arrow1 = new Label("→");
                        arrow1.style.color = new Color(0.7f, 0.7f, 0.7f);
                        arrow1.style.fontSize = 11;
                        arrow1.style.marginLeft = 4;
                        arrow1.style.marginRight = 4;
                        rowTrue.Add(arrow1);

                        var trueNextField = new IntegerField("跳转到") { value = cond.trueNextNodeId };
                        trueNextField.style.flexGrow = 1;
                        trueNextField.style.maxWidth = 200;
                        trueNextField.style.marginRight = 6;
                        BeautifyField(trueNextField);
                        trueNextField.RegisterValueChangedCallback(evt => cond.trueNextNodeId = evt.newValue);
                        rowTrue.Add(trueNextField);

                        // true 端口（绿色）— 伸出卡片右侧，便于连线
                        var truePort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                        truePort.portName = " ";
                        truePort.portColor = new Color(0.35f, 0.85f, 0.45f);
                        truePort.userData = new ConditionBranchPortTag { branch = cond, tag = "true" };
                        truePort.style.width = 22;
                        truePort.style.height = 22;
                        truePort.style.alignSelf = Align.Center;
                        truePort.style.marginRight = -28;
                        rowTrue.Add(truePort);
                        _conditionBranchPorts.Add(truePort);

                        card.Add(rowTrue);

                        // 第三行：false 分支 + 红色端口
                        var rowFalse = new VisualElement();
                        rowFalse.style.flexDirection = FlexDirection.Row;
                        rowFalse.style.alignItems = Align.Center;
                        rowFalse.style.overflow = Overflow.Visible;
                        rowFalse.style.paddingRight = 6;

                        var falseLabel = new Label("✗ false");
                        falseLabel.style.color = new Color(0.9f, 0.35f, 0.35f);
                        falseLabel.style.fontSize = 11;
                        falseLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
                        falseLabel.style.minWidth = 40;
                        falseLabel.style.width = 40;
                        rowFalse.Add(falseLabel);

                        var arrow2 = new Label("→");
                        arrow2.style.color = new Color(0.7f, 0.7f, 0.7f);
                        arrow2.style.fontSize = 11;
                        arrow2.style.marginLeft = 4;
                        arrow2.style.marginRight = 4;
                        rowFalse.Add(arrow2);

                        var falseNextField = new IntegerField("跳转到") { value = cond.falseNextNodeId };
                        falseNextField.style.flexGrow = 1;
                        falseNextField.style.maxWidth = 200;
                        falseNextField.style.marginRight = 6;
                        BeautifyField(falseNextField);
                        falseNextField.RegisterValueChangedCallback(evt => cond.falseNextNodeId = evt.newValue);
                        rowFalse.Add(falseNextField);

                        // false 端口（红色）— 伸出卡片右侧，便于连线
                        var falsePort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                        falsePort.portName = " ";
                        falsePort.portColor = new Color(0.9f, 0.35f, 0.35f);
                        falsePort.userData = new ConditionBranchPortTag { branch = cond, tag = "false" };
                        falsePort.style.width = 22;
                        falsePort.style.height = 22;
                        falsePort.style.alignSelf = Align.Center;
                        falsePort.style.marginRight = -28;
                        rowFalse.Add(falsePort);
                        _conditionBranchPorts.Add(falsePort);

                        card.Add(rowFalse);

                        condContainer.Add(card);
                    }
                    else
                    {
                        // ============ int 模式：一张卡片 + 一个端口 ============
                        var card = new VisualElement();
                        card.name = "CondCard_" + localIdx;
                        card.style.backgroundColor = new Color(0.1f, 0.14f, 0.22f, 0.9f);
                        card.style.borderTopLeftRadius = 6;
                        card.style.borderTopRightRadius = 6;
                        card.style.borderBottomLeftRadius = 6;
                        card.style.borderBottomRightRadius = 6;
                        card.style.paddingTop = 6;
                        card.style.paddingBottom = 6;
                        card.style.paddingLeft = 6;
                        card.style.paddingRight = 0;
                        card.style.marginBottom = 4;
                        card.style.overflow = Overflow.Visible;

                        // 第一行：变量名 + 操作符 + 比较值
                        var row1 = new VisualElement();
                        row1.style.flexDirection = FlexDirection.Row;
                        row1.style.alignItems = Align.Center;
                        row1.style.marginBottom = 4;
                        row1.style.paddingRight = 6;

                        var varDropdown = new DropdownField("变量", varNames,
                            string.IsNullOrEmpty(cond.varName) ? (varNames.Count > 0 ? varNames[0] : "") : cond.varName);
                        varDropdown.style.flexGrow = 1;
                        varDropdown.style.maxWidth = 160;
                        varDropdown.style.marginRight = 6;
                        BeautifyField(varDropdown);
                        varDropdown.RegisterValueChangedCallback(evt => cond.varName = evt.newValue);
                        row1.Add(varDropdown);

                        var ops = new List<string> { "==", "!=", ">", "<", ">=", "<=" };
                        var opDropdown = new DropdownField("操作", ops, string.IsNullOrEmpty(cond.op) ? "==" : cond.op);
                        opDropdown.style.flexGrow = 0;
                        opDropdown.style.width = 65;
                        opDropdown.style.marginRight = 6;
                        BeautifyField(opDropdown);
                        opDropdown.RegisterValueChangedCallback(evt => cond.op = evt.newValue);
                        row1.Add(opDropdown);

                        var intField = new IntegerField("值");
                        intField.value = cond.intCompareValue;
                        intField.style.flexGrow = 1;
                        intField.style.maxWidth = 120;
                        BeautifyField(intField);
                        intField.RegisterValueChangedCallback(evt => cond.intCompareValue = evt.newValue);
                        row1.Add(intField);

                        card.Add(row1);

                        // 第二行：目标节点 + 删除按钮 + 品红色端口
                        var row2 = new VisualElement();
                        row2.style.flexDirection = FlexDirection.Row;
                        row2.style.alignItems = Align.Center;
                        row2.style.overflow = Overflow.Visible;
                        row2.style.paddingRight = 6;

                        var condLabel = new Label("→ 跳转到");
                        condLabel.style.color = new Color(0.85f, 0.3f, 0.75f);
                        condLabel.style.fontSize = 11;
                        condLabel.style.unityFontStyleAndWeight = FontStyle.Bold;
                        condLabel.style.minWidth = 60;
                        condLabel.style.width = 60;
                        row2.Add(condLabel);

                        var nextField = new IntegerField("") { value = cond.intNextNodeId };
                        nextField.style.flexGrow = 1;
                        nextField.style.maxWidth = 200;
                        nextField.style.marginRight = 6;
                        BeautifyField(nextField);
                        nextField.RegisterValueChangedCallback(evt => cond.intNextNodeId = evt.newValue);
                        row2.Add(nextField);

                        var delBtn = new Button(() =>
                        {
                            Data.conditionBranches.RemoveAt(localIdx);
                            RefreshConditionUI();
                            RefreshNextPortUI();
                            _graphView.RebuildEdgesFromDataIds();
                        })
                        { text = "✕" };
                        delBtn.style.width = 20;
                        delBtn.style.height = 20;
                        delBtn.style.backgroundColor = new Color(0.6f, 0.25f, 0.25f, 0.9f);
                        delBtn.style.marginRight = 6;
                        row2.Add(delBtn);

                        // int 端口（品红色）— 伸出卡片右侧，便于连线
                        var intPort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                        intPort.portName = " ";
                        intPort.portColor = new Color(0.85f, 0.3f, 0.75f);
                        intPort.userData = new ConditionBranchPortTag { branch = cond, tag = "int" };
                        intPort.style.width = 22;
                        intPort.style.height = 22;
                        intPort.style.alignSelf = Align.Center;
                        intPort.style.marginRight = -28;
                        row2.Add(intPort);
                        _conditionBranchPorts.Add(intPort);

                        card.Add(row2);
                        condContainer.Add(card);
                    }
                }

                var hintLabel2 = new Label(Data.conditionBranches.Count > 0
                    ? $"✓ 共 {Data.conditionBranches.Count} 条条件规则（bool 双分支，int 单分支）"
                    : "（当前无条件规则，点击下方按钮添加）");
                hintLabel2.style.color = new Color(0.55f, 0.7f, 0.9f);
                hintLabel2.style.fontSize = 10;
                hintLabel2.style.marginLeft = 4;
                hintLabel2.style.marginTop = 2;
                condContainer.Add(hintLabel2);

                RefreshExpandedState();
            }

            var addCondBtn = new Button(() =>
            {
                if (Data.conditionBranches == null)
                    Data.conditionBranches = new List<ConditionBranch>();

                // 默认用第一个全局变量，没有则留空
                string defaultVar = "";
                if (_graphView.EditorWindow.GlobalVariables != null && _graphView.EditorWindow.GlobalVariables.Count > 0)
                {
                    defaultVar = _graphView.EditorWindow.GlobalVariables[0].name;
                }

                Data.conditionBranches.Add(new ConditionBranch
                {
                    varName = defaultVar,
                    op = "==",
                    intCompareValue = 0,
                    intNextNodeId = -1,
                    trueNextNodeId = -1,
                    falseNextNodeId = -1
                });
                RefreshConditionUI();
                RefreshNextPortUI();
                _graphView.RebuildEdgesFromDataIds();
            })
            { text = "✚ 添加条件分支规则" };
            addCondBtn.style.marginTop = 0;
            addCondBtn.style.marginBottom = 4;
            addCondBtn.style.height = 24;
            addCondBtn.style.backgroundColor = new Color(0.15f, 0.45f, 0.6f, 0.9f);
            _customContainer.Add(addCondBtn);

            RefreshConditionUI();

            if (Data.type == "Normal")
            {
                RefreshNextPortUI();
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

        /// <summary>
        /// 动态刷新 Normal 节点的"跳转ID"字段和输出口
        /// - 没有条件分支规则时：显示跳转ID + 输出口
        /// - 有条件分支规则时：隐藏跳转ID + 输出口
        /// </summary>
        public void RefreshNextPortUI()
        {
            if (Data.type != "Normal")
                return;

            // 先移除已有的跳转ID行
            if (_nextPortRow != null)
            {
                _customContainer.Remove(_nextPortRow);
                _nextPortRow = null;
            }

            _nextIdField = null;

            bool hasCond = Data.conditionBranches != null && Data.conditionBranches.Count > 0;

            if (hasCond)
            {
                // 有条件分支：不显示跳转ID和输出口
                NextPort = null;
            }
            else
            {
                // 没有条件分支：显示跳转ID + 输出口
                NextPort = Port.Create<Edge>(Orientation.Horizontal, Direction.Output, Port.Capacity.Single, typeof(float));
                NextPort.portName = " ";
                NextPort.portColor = new Color(0.38f, 0.45f, 1f);

                _nextPortRow = new VisualElement();
                _nextPortRow.style.flexDirection = FlexDirection.Row;
                _nextPortRow.style.alignItems = Align.Center;
                _nextPortRow.style.overflow = Overflow.Visible;

                _nextIdField = new IntegerField("跳转ID") { value = Data.next };
                _nextIdField.style.flexGrow = 1;
                _nextIdField.style.maxWidth = 270;
                _nextIdField.style.marginBottom = 0;
                _nextIdField.style.marginRight = 6;
                _nextIdField.RegisterValueChangedCallback(evt => Data.next = evt.newValue);
                BeautifyField(_nextIdField);
                _nextPortRow.Add(_nextIdField);

                NextPort.style.width = 22;
                NextPort.style.height = 22;
                NextPort.style.alignSelf = Align.Center;
                NextPort.style.marginLeft = 6;
                NextPort.style.marginRight = -28;
                _nextPortRow.Add(NextPort);

                _customContainer.Add(_nextPortRow);
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

        public Port GetPortByConditionBranch(ConditionBranch cond, string tag)
        {
            return _conditionBranchPorts.FirstOrDefault(p =>
                p.userData is ConditionBranchPortTag t && t.branch == cond && t.tag == tag);
        }
    }
}
#endif
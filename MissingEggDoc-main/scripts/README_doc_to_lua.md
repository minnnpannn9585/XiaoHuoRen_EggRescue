# doc_to_lua.py — 树状 md → DialogueConfig lua（Phase 2）

## 用途

从 [`docs/characters/`](../docs/characters/) 中的**树状对话 md** 生成符合 `DialogueGraphEditorWindow` 导入契约的 lua 文件。  
Phase 2 支持 **大黄 · 谷仓 + 红顶 + NGPlus** 全量 `--all` 生成，输出到独立文件，**不覆盖**现有 `dahuang_01.lua` ~ `dahuang_04.lua`。

## 用法

```bash
# 一键生成样章全量（推荐）
python3 MissingEggDoc-main/scripts/doc_to_lua.py \
  --input MissingEggDoc-main/docs/characters/大黄-对话脚本-树状样章.md \
  --output Assets/Editor/DialogueData/dahuang_01_FROM_DOC.lua \
  --all

# 指定章节
python3 MissingEggDoc-main/scripts/doc_to_lua.py \
  --input MissingEggDoc-main/docs/characters/大黄-对话脚本-树状样章.md \
  --output Assets/Editor/DialogueData/dahuang_01_FROM_DOC.lua \
  --sections "1-A,1-A',1-B,1-C"
```

生成后在 Unity DialogueEditor 中 **Import** 该文件。Scene 中 `DialogueTrigger` **起始 ID 应为 0**（入口判定 dispatcher）。

## 能生成什么

| 支持 | 说明 |
|------|------|
| `Normal` 对白链 | 解析 `玩家：` / `大黄：` / `描述：（…）` 等说话行 |
| `Question` hub | 【回访】+【菜单】→ 单 Question 节点 + Options |
| `SetVariables` | 【变量】块中的 `· VarName = value` |
| `DisplayConditions` | 菜单行括号内条件 |
| `ConditionBranches` | 节点内【条件】bool/int 分支（1-A E06、1-C OS、1-F 双返链等） |
| `RotatePool` | 【轮播】变体等权重随机（2-C、NGPlus）；运行时由 `NpcDialogueManager` 处理 |
| `UnlockBranches` | 跨 NPC 指针（如 2-B → 黑猫），映射见 [`cross_npc_map.json`](./cross_npc_map.json) |
| `DialogueConfig[0]` | 入口判定 dispatcher（谷仓 DogStatus / 红顶 NGPlus 等） |
| 节点注释 | `-- doc:1-A#3` 保留语义 ID 映射 |

## 仍须人工（&lt;5%）

| 项目 | 原因 |
|------|------|
| Scene `DialogueTrigger` 起始 ID → **0** | Unity Inspector |
| NPCData 分支临时指向 `_FROM_DOC` | 测试接线 |
| 核对 `cross_npc_map.json` BranchId | 与 `NPCData_Config.lua` 对齐 |
| **2-D** | doc 无对白，由黑猫脚本触发，生成器跳过 |

## md 与 lua 的结构差异

1. **语义 ID**（`1-A`、`1-A′`）→ 整数 `DialogueConfig[n]`，文件头注释保留映射
2. **树状前缀**（`├─`、`│`）→ 解析时剥离
3. **prime 符号** `1-A′` 与 ASCII `1-A'` 等价（内部归一化）

## 验收

```bash
# 生成
python3 MissingEggDoc-main/scripts/doc_to_lua.py --input ... --output ... --all

# 台词对照（目标：missing = 0）
python3 MissingEggDoc-main/scripts/compare_doc_lua.py \
  --input MissingEggDoc-main/docs/characters/大黄-对话脚本-树状样章.md \
  --lua Assets/Editor/DialogueData/dahuang_01_FROM_DOC.lua
```

1. Unity DialogueEditor 导入，无解析错误
2. `compare_doc_lua.py` 无缺失台词
3. 导出 → 再导入，`RotatePool` / `ConditionBranches` / bool 值不丢失
4. 现有 `dahuang_01.lua` ~ `dahuang_04.lua` **不修改**

## 关联脚本与文档

- [`compare_doc_lua.py`](./compare_doc_lua.py) — md 与 lua 台词对照
- [`validate_lua_vars.py`](./validate_lua_vars.py) — 校验 Data 对话中的 `VarName`
- [`docs/TREE_TO_LUA_SPEC.md`](../../docs/TREE_TO_LUA_SPEC.md) — **树状 md→lua 生成规范**（推荐新 NPC 先读）
- [`docs/DIALOGUE_PIPELINE.md`](../../docs/DIALOGUE_PIPELINE.md) — 完整发布流程

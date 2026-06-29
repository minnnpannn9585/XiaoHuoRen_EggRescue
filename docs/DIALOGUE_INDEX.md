# Lua 对话文件 · 角色对照表

> **用途**：把拼音/缩写文件名对应到游戏内角色，避免改错脚本。  
> **数据路径**：运行时 `Assets/Data/DialogueData/` · 编辑源 `Assets/Editor/DialogueData/`  
> **NPC 分支注册**：`Assets/Data/GlobalData/NPCData_Config.lua`  
> **Scene 挂载**：`ArtTest_MRL` → `DialogueData/{文件名}` DouyinScript

---

## 1. 拼音 / 缩写命名规则

前程序员用**汉语拼音**或**首字母缩写**命名文件，部分与标准拼音不一致（口音/笔误）：

| 文件名片段 | 实际含义 | 标准拼音参考 | 备注 |
|-----------|---------|-------------|------|
| `dahuang` | **大黄**（狗） | dà huáng | ✓ 一致 |
| `shufang` | **淑芬**（母鸡） | shū fēn | ⚠️ 应为 `shufen`，`ang/fen` 混用 |
| `heimao` | **黑猫** | hēi māo | ✓；也复用于「大树」NPC |
| `qingwa` | **青蛙** → 角色名 **悲伤蛙** | qīng wā | 文件名用动物名，NPC 用绰号 |
| `wuniu` | **蜗牛** → 角色名 **闪电蜗牛** | wō niú | ⚠️ 写成 `wuniu`，口语「乌牛」 |
| `wuya` | **乌鸦** | wū yā | ✓ 一致 |
| `xiaoji` | **小鸡** | xiǎo jī | 小鸡侦探团 |
| `ZTT` | **侦探团** | zhēn tàn tuán | 首字母缩写 |
| `TouTing` | **偷听** | tōu tīng | 场景 E03 偷听演出 |
| `miaosu` | **描述** | miáo shù | 旁白/系统叙述，非角色 |
| `_R1` `_R2` `_R3` | **回访**轮播分支 | huí fǎng | Random / Return 回访台词池 |

**特殊说话者**（出现在对话 `NpcName` 字段，不一定有独立 lua 文件）：

| NpcName | 含义 |
|---------|------|
| `玩家` | 小火人侦探（玩家） |
| `描述` | 旁白 / 动作描写 |
| `阿满` | 小鸡侦探团成员（hub 主声） |
| `米粒` | 小鸡侦探团成员 |
| `瓜子` | 小鸡侦探团成员 |
| `豆豆` | 小鸡侦探团成员；E03 偷听单独 NPC |
| `大树` | 大橡树交互（第一章黑猫伏笔，复用 heimao lua） |

---

## 2. 按角色汇总

### 大黄（狗）`dahuang_*.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `dahuang_01.lua` | 分支 1 | 半睡复述，首次目击乌鸦 | 点 **大黄** |
| `dahuang_02.lua` | 分支 2 | 索要短木梯 / 解锁分支 3 | 点 **大黄**（需 `E06_ViewNeedLadder` 等） |
| `dahuang_03.lua` | 分支 3 | 谷物泡水醒酒 | 点 **大黄** |
| `dahuang_04.lua` | 分支 4 | 清醒后回访 / 质询 | 点 **大黄** |
| `miaosu.lua` | —（属 **描述** NPC） | 环境叙述：缺梯、借梯流程；会 Unlock **大黄** 分支 2 | E 点 / 描述触发，`npcname=描述` |

### 淑芬（母鸡）`shufang_*.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `shufang_01.lua` | 分支 1 | 初次相遇与丢蛋委托 | 点 **淑芬** |
| `shufang_02_R1.lua` | 分支 2 | 默认回访池 1 | 点 **淑芬** |
| `shufang_02_R2.lua` | 分支 3 | 默认回访池 2 | 点 **淑芬** |
| `shufang_02_R3.lua` | 分支 4 | 默认回访池 3 | 点 **淑芬** |
| `shufang_02.lua` | ⚠️ **未注册** | 实为池塘旁 **悲伤蛙** 氛围独白；Unlock 悲伤蛙分支 2 | 可能由 E 点触发，文件名误用 `shufang` |

### 小鸡侦探团 `xiaojiZTT_*.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `xiaojiZTT_01.lua` | 分支 1 | 首次接触 | 点 **小鸡侦探团** |
| `xiaojiZTT_02.lua` | 分支 2 | 主菜单 hub（质询、叫醒大黄、谷仓等选项） | 点 **小鸡侦探团** |

团内四人名（对话内 `NpcName`）：**阿满**、**米粒**、**瓜子**、**豆豆** — 同文件内切换说话者，无独立 lua。

### 豆豆 / E03 偷听 `zttTouTing.lua`

| 文件 | NPCData 加载键 | 剧情说明 | Scene 触发 |
|------|---------------|---------|-----------|
| `zttTouTing.lua` | **E03_Eavesdrop**（`name` 字段） | E03 身后偷听：水怪说 / 换蛋伏笔 | E03 `npcname=E03_Eavesdrop` |

> **加载键 vs 显示名**：Scene / NPCData 使用 `E03_Eavesdrop`；节点内 `NpcName` 仍为 **豆豆**、**阿满** 等叙事说话人。  
> 文件名 = **Z**hen **T**an **T**uan + **TouTing**（侦探团偷听）。

### 黑猫 `heimao_*.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `heimao_01.lua` | 黑猫 分支 1 · **大树** 分支 1 | 首次靠近大橡树 / 黑猫伏笔 | 点 **黑猫** 或 **大树** |
| `heimao_02.lua` | 黑猫 分支 2 · **大树** 分支 2 | 大树轮播 / 第二章案情线入口 | 点 **大树**（说话者为 `NpcName=大树`） |
| `heimao_03.lua` | 黑猫 分支 3 | 2-B-hub 回访菜单、薄荷鱼线、开窗等 | 点 **黑猫** |

> **注意**：`heimao_01/02` 同时绑在 **黑猫** 和 **大树** 两个 NPC 上；`heimao_02` 内说话者是「大树」，内容是树/黑猫相关轮播。

### 悲伤蛙（青蛙）`qingwa_*.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `qingwa_01.lua` | 分支 1 | 首次对话、水怪质询、三轮对暗号取薄荷鱼 | 点 **悲伤蛙** |
| `qingwa_02.lua` | 分支 2 | 轮播 / hub 菜单 | 点 **悲伤蛙** |

文件名 `qingwa` = 青蛙；游戏内 NPC 名 **悲伤蛙**。

### 闪电蜗牛 `wuniu_01.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `wuniu_01.lua` | 分支 1 | 慢语速 meta 对白 | 点 **闪电蜗牛** |

文件名 `wuniu` ≈ 蜗牛（口语）；角色名 **闪电蜗牛**。

### 乌鸦 `wuya_01.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `wuya_01.lua` | 分支 1 | 谷仓底仰望 / 屋顶对峙 | 点 **乌鸦** |

### 描述（旁白）`miaosu.lua`

| 文件 | NPCData 分支 | 剧情说明 | Scene 触发 |
|------|-------------|---------|-----------|
| `miaosu.lua` | **描述** 分支 1 | 缺梯、借梯等环境叙述 | 多数 E 点，`npcname=描述` |

---

## 3. 尚未有独立 lua 的 NPC

| 角色 | 说明 |
|------|------|
| 米粒 / 瓜子 / 阿满 | 台词在 `xiaojiZTT_*` 内；已从 NPCData 删除空占位 |
| 玩家 | 无独立脚本；`NpcName=玩家` 散布各文件 |

**老鼠兄弟**（策划有完整树状脚本）在 NPCData 中**尚未注册**，无 lua 文件。

---

## 4. 全文件速查表

| Lua 文件 | 主角色 | 拼音/缩写解码 | 注册 NPC | 分支 ID |
|----------|--------|--------------|---------|--------|
| `dahuang_01.lua` | 大黄 | 大黄_01 | 大黄 | 1 |
| `dahuang_02.lua` | 大黄 | 大黄_02 | 大黄 | 2 |
| `dahuang_03.lua` | 大黄 | 大黄_03 | 大黄 | 3 |
| `dahuang_04.lua` | 大黄 | 大黄_04 | 大黄 | 4 |
| `shufang_01.lua` | 淑芬 | 淑芬_01（shufang≈shufen） | 淑芬 | 1 |
| `shufang_02_R1.lua` | 淑芬 | 淑芬_回访1 | 淑芬 | 2 |
| `shufang_02_R2.lua` | 淑芬 | 淑芬_回访2 | 淑芬 | 3 |
| `shufang_02_R3.lua` | 淑芬 | 淑芬_回访3 | 淑芬 | 4 |
| `shufang_02.lua` | ⚠️ 悲伤蛙 | 文件名误标；Unlock 悲伤蛙→2 | **未注册** | — |
| `xiaojiZTT_01.lua` | 小鸡侦探团 | 小鸡+侦探团_01 | 小鸡侦探团 | 1 |
| `xiaojiZTT_02.lua` | 小鸡侦探团 | 小鸡+侦探团_02 hub | 小鸡侦探团 | 2 |
| `zttTouTing.lua` | 豆豆（显示） | 侦探团+偷听 | **E03_Eavesdrop** | 1 |
| `heimao_01.lua` | 黑猫 / 大树 | 黑猫_01 | 黑猫 1 · 大树 1 | 1 |
| `heimao_02.lua` | 大树（轮播） | 黑猫_02 | 黑猫 2 · 大树 2 | 2 |
| `heimao_03.lua` | 黑猫 | 黑猫_03 hub | 黑猫 | 3 |
| `qingwa_01.lua` | 悲伤蛙 | 青蛙_01 | 悲伤蛙 | 1 |
| `qingwa_02.lua` | 悲伤蛙 | 青蛙_02 | 悲伤蛙 | 2 |
| `wuniu_01.lua` | 闪电蜗牛 | 蜗牛_01 | 闪电蜗牛 | 1 |
| `wuya_01.lua` | 乌鸦 | 乌鸦_01 | 乌鸦 | 1 |
| `miaosu.lua` | 描述 | 描述 | 描述 | 1 |

---

## 5. Scene 中 `npcname` 触发对照

`DialogueTrigger` 的 Inspector 字段 `npcname` → 决定加载哪个 NPC 的 `currentBranchId` 分支：

| Scene `npcname` | 加载的 NPC 配置 | 典型 lua |
|----------------|----------------|---------|
| 大黄 | 大黄 | `dahuang_*` |
| 淑芬 | 淑芬 | `shufang_*` |
| 小鸡侦探团 | 小鸡侦探团 | `xiaojiZTT_*` |
| **E03_Eavesdrop** | E03 偷听（原「豆豆」加载键） | `zttTouTing` |
| 黑猫 | 黑猫 | `heimao_*` |
| 悲伤蛙 | 悲伤蛙 | `qingwa_*` |
| 闪电蜗牛 | 闪电蜗牛 | `wuniu_01` |
| 乌鸦 | 乌鸦 | `wuya_01` |
| 描述 | 描述 | `miaosu`（或指定 ID 的其他描述段） |

环境 E 点多数设 `npcname=描述`，再配合起始节点 `ID` 跳转到对应对话段。

---

## 6. 已知命名问题（后续重构可参考）

1. **`shufang` → 淑芬**：标准拼音 `shufen`，`_fang` 为历史笔误，全套淑芬文件均受影响。
2. **`shufang_02.lua`**：内容属悲伤蛙，未进 NPCData；建议重命名为 `qingwa_00_intro.lua` 或类似。
3. **`heimao_*.lua` 绑大树**：黑猫第一章内容挂在「大树」NPC 上，文件名仍用 heimao。
4. **`qingwa` vs 悲伤蛙** / **`wuniu` vs 闪电蜗牛**：文件名用动物通名，NPC 配置用角色绰号。
5. **小鸡成员**（阿满/米粒/瓜子/豆豆）：无独立 lua；E03 偷听用加载键 `E03_Eavesdrop`，节点内仍写成员名。

---

## 7. 加载键 vs NpcName（Phase 1 规范）

| 层级 | 字段 | 示例 |
|------|------|------|
| **加载键** | `DialogueTrigger.npcname` = `NPCData.name` | `大黄` / `E03_Eavesdrop` |
| **显示键** | 节点 `NpcName` | `豆豆` / `阿满` / `描述` |

详见 [`DIALOGUE_PIPELINE.md`](./DIALOGUE_PIPELINE.md) §5。

---

*关联：[IMPLEMENTATION.md](./IMPLEMENTATION.md) · [NPCData_Config.lua](../Assets/Data/GlobalData/NPCData_Config.lua) · [06-角色与关系网](../MissingEggDoc-main/docs/06-角色与关系网.md)*

# 汉化修改点地图

本文档记录当前补丁主要改动位置。游戏更新后，先按这里重新定位差异，再决定是否需要从新版资源包重新合并。

## 入口与加载

| 路径 | 用途 | 更新后检查点 |
| --- | --- | --- |
| `src/loader/global.gd` | 注入外部资源包加载逻辑，启动时加载 `poa_zh.pck`。 | 原版 `global.gd` 若有初始化顺序变化，需要确认 loader 仍会足够早执行。 |
| `zh_patch_src/MyFont.tres` | 默认 GUI 字体资源。 | 字体路径应指向 `res://Fonts/zh-CN.ttf`。 |
| `zh_patch_src/MyFont2.tres` | 备用/不同字号字体资源。 | 同上。 |
| `zh_patch_src/MyFont3t.tres` | 备用/不同字号字体资源。 | 同上。 |
| `local_assets/Fonts/zh-CN.ttf` | 本地字体源文件，不提交。 | 换字体时保持文件名为 `zh-CN.ttf`。 |

## 构建脚本

| 路径 | 用途 | 更新后检查点 |
| --- | --- | --- |
| `scripts/Build-Patch.ps1` | 编译 `.gd` 为 Godot 3.5 bytecode，生成 loader 主包和外部汉化包。 | 新增覆盖脚本时，需要加入 `$sceneScripts` 或 `$topLevelScripts`。 |
| `compiled_loader/` | loader 编译临时输出，不提交。 | 自动生成。 |
| `zh_patch_external/` | 外部 PCK 临时源目录，不提交。 | 自动生成。 |
| `build/` | 最终 PCK 输出目录，不提交。 | 自动生成。 |

## 通用翻译层

| 路径 | 用途 | 更新后检查点 |
| --- | --- | --- |
| `zh_patch_src/translate.gd` | 全局翻译辅助函数。包含伤害类型、元素、状态、能力名、装备名、要求文本和通用短语替换。 | 这是优先合并文件。不要把可能被逻辑依赖的 `title`、buff key、trait key 直接改成中文。 |

重点函数：

| 函数 | 用途 |
| --- | --- |
| `damage_type()` | 伤害类型显示，例如 Slash、Blunt、Fire。 |
| `element()` | 元素/能力系别显示，例如 Martial、Astral、Life。 |
| `element_to_resist_description()` | 学习能力页底部“每投入 1 点元素获得抗性”的说明。 |
| `trait_name()` / `trait_name_plain()` | 能力、物品特性、进阶职业名显示层翻译。 |
| `trait_name_by_title()` | 当显示名不足以识别时，按逻辑 title 兜底翻译。 |
| `item_name()` | 装备名显示层翻译，用于背包、军械库、结算页等。 |
| `visible_text()` | 装备说明、状态说明、图鉴描述中的通用短语替换。 |
| `prestige_requirement_text()` | 进阶职业要求文本翻译。 |

## 场景脚本覆盖

| 路径 | 当前用途 |
| --- | --- |
| `zh_patch_src/Scenes/First_Menu.gd` | 首屏标题/版本提示。 |
| `zh_patch_src/Scenes/Start_Menu.gd` | 主菜单、角色创建、文化/职业/信仰说明、轮回提示。 |
| `zh_patch_src/Scenes/UI_GameMenu.gd` | ESC 暂停菜单动态选项、保存退出、音量/设置状态。 |
| `zh_patch_src/Scenes/UI_Inv.gd` | 背包、装备详情、状态说明、献祭说明、装备名显示层翻译。包含背包内抗性名和状态名的本地显示翻译。 |
| `zh_patch_src/Scenes/UI_Traits_Basic.gd` | 学习能力界面、能力名、元素、能力说明、元素抗性说明。 |
| `zh_patch_src/Scenes/UI_Prestige.gd` | 进阶职业界面、要求文本、效果说明。 |
| `zh_patch_src/Scenes/UI_Level_Up.gd` | 升级界面、属性和升级说明。 |
| `zh_patch_src/Scenes/AbilityBook.gd` | 能力书/进阶职业图鉴说明。 |
| `zh_patch_src/Scenes/Armory.gd` | 军械库装备详情、装备名显示层翻译。 |
| `zh_patch_src/Scenes/Bestiary.gd` | 图鉴敌人说明。 |
| `zh_patch_src/Scenes/Feats.gd` | 事迹界面。 |
| `zh_patch_src/Scenes/ScoreScreen.gd` | 失败/胜利/放弃后的总结页。 |
| `zh_patch_src/Scenes/DeathScreen.gd` | 死亡/胜利弹层。 |
| `zh_patch_src/Scenes/Graveyard.gd` | 墓地与历史角色信息。 |
| `zh_patch_src/Scenes/Continent.gd` | 世界地图与轮回/区域提示。 |
| `zh_patch_src/Scenes/GameBars.gd` | 游戏内顶部条和祈祷/状态提示。 |
| `zh_patch_src/Scenes/UI_Enemies.gd` | 敌人详情与单位标签显示。 |
| `zh_patch_src/Scenes/InfoButtons.gd` | 属性按钮说明入口。 |
| `zh_patch_src/Scenes/ButtonAutoLevel.gd` | 自动加点按钮显示。 |
| `zh_patch_src/Scenes/UI_Log.gd` | 消息日志界面。 |
| `zh_patch_src/Scenes/UI_Popup.gd` | 游戏内弹窗。 |
| `zh_patch_src/Scenes/UI_Popup_Nongame.gd` | 非战斗弹窗。 |
| `zh_patch_src/Scenes/UI_God.gd` | 信仰/祈祷界面。 |
| `zh_patch_src/Scenes/Player.gd` | 角色数据与显示相关逻辑。 |
| `zh_patch_src/Scenes/Tile.gd` | 地块/悬停信息。 |
| `zh_patch_src/Scenes/SummonButton.gd` | 召唤盟友相关按钮。 |

## 静态场景覆盖

| 路径 | 当前用途 |
| --- | --- |
| `zh_patch_src/Scenes/First_Menu.tscn` | 首屏静态文本与字体。 |
| `zh_patch_src/Scenes/Start_Menu.tscn` | 主菜单/角色创建静态文本与字体。 |
| `zh_patch_src/Scenes/UI_GameMenu.tscn` | 暂停菜单设置、控制、指南静态文本。 |
| `zh_patch_src/Scenes/UI_Inv.tscn` | 背包界面布局与静态文本。 |
| `zh_patch_src/Scenes/UI_Level_Up.tscn` | 升级界面布局与静态文本。 |
| `zh_patch_src/Scenes/UI_Traits_Basic.tscn` | 学习能力界面布局与静态文本。 |
| `zh_patch_src/Scenes/UI_Prestige.tscn` | 进阶职业界面布局与静态文本。 |
| `zh_patch_src/Scenes/AbilityBook.tscn` | 能力书界面布局与静态文本。 |
| `zh_patch_src/Scenes/Armory.tscn` | 军械库界面布局与占位文本。 |
| `zh_patch_src/Scenes/Bestiary.tscn` | 图鉴界面布局与静态文本。 |
| `zh_patch_src/Scenes/Feats.tscn` | 事迹界面布局与静态文本。 |

## 顶层事件与工具脚本

这些脚本主要处理战斗日志、触发文本、结算数据和召唤/升级等非场景逻辑。

| 路径 | 当前用途 |
| --- | --- |
| `zh_patch_src/ToolMessageCreator.gd` | 消息日志组装。 |
| `zh_patch_src/ToolLevelUp.gd` | 升级奖励说明。 |
| `zh_patch_src/ToolInvokes.gd` | 祈祷/调用说明。 |
| `zh_patch_src/ToolCycler.gd` | 轮回名称和轮回增幅说明。 |
| `zh_patch_src/ToolScoreMaker.gd` | 结算页数据组装。 |
| `zh_patch_src/RouterEvents_GameTurn.gd` | 回合触发事件日志。 |
| `zh_patch_src/RouterEvents_OnAttack.gd` | 攻击触发事件日志。 |
| `zh_patch_src/RouterEvents_OnDamage.gd` | 伤害触发事件日志。 |
| `zh_patch_src/RouterEvents_OnHit.gd` | 命中触发事件日志。 |
| `zh_patch_src/RouterEvents_OnMove.gd` | 移动触发事件日志。 |
| `zh_patch_src/RouterEvents_OnDeath.gd` | 死亡触发事件日志。 |
| `zh_patch_src/RouterEvents_OnPickup.gd` | 拾取触发事件日志。 |
| `zh_patch_src/RouterEvents_OnInvoke.gd` | 祈祷触发事件日志。 |
| `zh_patch_src/RouterEvents_OnIntervention.gd` | 神圣干预事件日志。 |
| `zh_patch_src/RouterEvents_OnLevelUp.gd` | 升级触发事件日志。 |
| `zh_patch_src/RouterEvents_OnEnterLevel.gd` | 进入楼层触发事件日志。 |
| `zh_patch_src/RouterEvents_OnLearn.gd` | 学习能力触发事件日志。 |
| `zh_patch_src/RouterEvents_OnHeal.gd` | 治疗触发事件日志。 |
| `zh_patch_src/RouterEvents_OnApplyBuff.gd` | 状态施加事件日志。 |
| `zh_patch_src/RouterEvents_OnRemoveBuff.gd` | 状态移除事件日志。 |
| `zh_patch_src/RouterEvents_OnTeleport.gd` | 传送事件日志。 |
| `zh_patch_src/RouterEvents_Summon.gd` | 召唤事件日志。 |

## 数据表覆盖

| 路径 | 当前用途 | 风险 |
| --- | --- | --- |
| `zh_patch_src/Data/Table_InfoButtons.json` | 属性/机制说明。 | 低。 |
| `zh_patch_src/Data/Table_Feats.json` | 事迹说明。 | 中，注意 title/key。 |
| `zh_patch_src/Data/Table_Invokes.json` | 祈祷说明。 | 中，注意 title/key。 |
| `zh_patch_src/Data/Table_Buffs.json` | 状态说明。 | 高，不要改 `title` 和 `name`。两者都会被战斗逻辑按英文匹配，只翻 `description`、`message` 等显示文本。 |
| `zh_patch_src/Data/Table_Traits.json` | 基础能力说明。 | 高，不要改 `title`；能力名优先走 `translate.trait_name()`。 |
| `zh_patch_src/Data/Table_TraitsGeneric.json` | 进阶职业、文化/职业/神祇说明、物品特性说明。 | 高，不要改 `title`；文化、基础职业、神祇名称保留原文。 |
| `zh_patch_src/Data/Table_Weapons.json` | 部分装备显示名。 | 中，优先只改 `name`，不要改 `title`、sprite、abilities。 |
| `zh_patch_src/Data/Table_Armor.json` | 部分装备显示名。 | 中，优先只改 `name`，不要改 `title`、sprite、abilities。 |
| `zh_patch_src/Data/Table_Races.json` | 文化说明。 | 中，名称保留原文。 |
| `zh_patch_src/Data/Table_Classes.json` | 职业说明。 | 中，名称保留原文。 |
| `zh_patch_src/Data/Table_Gods.json` | 信仰/神祇说明。 | 中，名称保留原文。 |
| `zh_patch_src/Data/Table_Enemies.json` | 敌人数据/说明。 | 高，暂未系统翻译。 |
| `zh_patch_src/Data/Table_Allies.json` | 盟友数据/说明。 | 高，暂未系统翻译。 |
| `zh_patch_src/Data/Table_Tilesets.json` | 区域/地块说明。 | 中。 |
| `zh_patch_src/Data/Table_Lore.json` | 剧情文本。 | 低到中，文本量大。 |
| `zh_patch_src/Data/Table_Verses.json` | 文本/诗句。 | 低到中，文本量大。 |

## 当前翻译策略

- UI、说明、机制文本优先翻译。
- 文化、基础职业、信仰/神祇名称保留原文，只翻说明。
- 能力名、进阶职业名、物品特性名优先用 `translate.trait_name()` 显示层翻译。
- 装备名优先用 `translate.item_name()` 显示层翻译；少量已直接改 `Table_Weapons.json` / `Table_Armor.json` 的 `name`。
- 不直接改 `title`、数据表 key、sprite、icon、abilities、reference 等逻辑字段。
- `Table_Buffs.json` 的 `title/name` 是逻辑字段，必须保持英文；状态显示名走场景脚本的显示层函数，例如 `UI_Inv.gd` 的 `buff_name_text()`。
- `translate.gd` 是 Godot 全局类，外部 PCK 不一定能覆盖早期已注册版本；若某个已覆盖场景必须立即显示中文，可在该场景脚本内做局部显示翻译，例如 `UI_Inv.gd` 的 `damage_type_text()`。

## 游戏更新后的重定位步骤

1. 备份新版原始 `PathofAchra.pck` 为 `PathofAchra.pck.orig-backup`。
2. 用 GDRETools 解包新版资源到临时目录。
3. 对比新版资源中的同名 `.gd`、`.tscn`、`Data/Table_*.json` 与本仓库 `zh_patch_src/`。
4. 先合并 loader、字体和 `translate.gd`。
5. 再按场景脚本覆盖表逐个合并 UI/日志改动。
6. 最后合并数据表文本字段，避免覆盖新版新增字段。
7. 运行 JSON 检查、`git diff --check`、完整构建部署和哈希核对。
8. 进游戏重点检查主菜单、ESC 设置、背包、学习能力、能力书、军械库、失败/胜利总结页。

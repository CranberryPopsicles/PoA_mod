# Path of Achra 中文补丁工具

这是一个面向 Godot 版 Path of Achra 的中文补丁工作区。当前方案不是完整替换原资源包，而是在主包里注入一个很小的 loader，并把汉化内容放到外部 `poa_zh.pck`。

## 当前状态

- 游戏版本基线：Path of Achra 1.4.4
- Godot 版本：3.5.x
- 字体：本地中文字体，统一命名为 `zh-CN.ttf`
- 已汉化：主菜单、角色创建界面的一部分 UI、悬停说明、基础机制说明、事迹界面、能力书、军械库、图鉴、背包/装备界面、能力学习界面、升级界面、进阶职业界面的一部分 UI、ESC 暂停菜单、失败/胜利总结页、文化/职业/神祇说明、祈祷说明、状态说明、基础能力说明、部分通用/进阶能力说明、部分装备名、部分物品特性名和进阶职业名
- 未汉化：敌人、盟友、剧情文本、诗句文本，以及仍未覆盖的装备名、能力名和说明文本
- 翻译规则：文化、职业、信仰/神祇名称保留原文，只翻简介、描述和机制说明。

## 目录说明

```text
src/loader/          主资源包注入用 loader 源码
zh_patch_src/        汉化资源源码，包含菜单场景、脚本、字体资源引用和数据表覆盖
local_assets/        本地字体等不提交资源，已被 .gitignore 忽略
docs/glossary.md     术语表，翻译前优先维护这里
docs/patch-map.md    汉化修改点地图，游戏更新后按这里重新定位改动
scripts/             构建脚本
build/               本地生成物，已被 .gitignore 忽略
compiled_loader/     loader 编译输出，已被 .gitignore 忽略
zh_patch_external/   外部 PCK 临时源目录，已被 .gitignore 忽略
extracted/           GDRETools 解包结果，已被 .gitignore 忽略
```

## to Human

```text
如果汉化失效（比如游戏更新了），告诉 AI（桌面 AI 工具，如 codex、claude code 或其他 Agent）：请阅读项目中的文档，游戏更新了，帮我重新进行翻译工作。
```

## 依赖

需要本机准备：

- Path of Achra 游戏目录
- GDRETools 可执行文件
- 原版资源包备份：`PathofAchra.pck.orig-backup`
- 中文字体文件：`local_assets\Fonts\zh-CN.ttf`

下面的命令使用变量表示本机路径，请按自己的安装位置修改：

```powershell
$GameDir = '<Path of Achra 游戏目录>'
$GDRETools = '<GDRETools 可执行文件路径>'
$FontSource = '<任意支持简体中文的 .ttf 字体路径>'
```

如果第一次使用，请先在游戏目录备份原包：

```powershell
Copy-Item `
  -Path (Join-Path $GameDir 'PathofAchra.pck') `
  -Destination (Join-Path $GameDir 'PathofAchra.pck.orig-backup') `
  -Force
```

然后准备字体文件。可以使用 MiSans Medium，也可以换成其他支持简体中文的字体；只要最终文件名是 `zh-CN.ttf` 即可：

```powershell
New-Item -ItemType Directory -Path .\local_assets\Fonts -Force | Out-Null
Copy-Item `
  -Path $FontSource `
  -Destination '.\local_assets\Fonts\zh-CN.ttf' `
  -Force
```

## 构建

在仓库根目录运行：

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\Build-Patch.ps1
```

生成结果：

```text
build/PathofAchra.loader.pck
build/poa_zh.pck
```

构建过程中会临时生成 `.gdc` 和 `.gd.remap` 文件，它们都是 GDRETools 编译资源，不需要提交到 Git。

默认构建不打印 `poa_zh.pck` 的完整文件列表。如需检查外部包内容：

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\Build-Patch.ps1 -ListFiles
```

如果你的路径不同：

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\Build-Patch.ps1 `
  -GameDir $GameDir `
  -GDRETools $GDRETools
```

## 构建并部署

确认游戏已关闭后运行：

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\Build-Patch.ps1 -Deploy
```

部署后游戏目录应包含：

```text
PathofAchra.pck      注入 loader 和字体的主包
poa_zh.pck           外部汉化资源包
```

构建完成后可以核对哈希：

```powershell
Get-FileHash -Algorithm SHA256 `
  '.\build\PathofAchra.loader.pck', `
  (Join-Path $GameDir 'PathofAchra.pck'), `
  '.\build\poa_zh.pck', `
  (Join-Path $GameDir 'poa_zh.pck')
```

## 方案说明

`src/loader/global.gd` 会在游戏启动早期执行：

```gdscript
ProjectSettings.load_resource_pack("poa_zh.pck", true)
```

主包里同时放入 `zh-CN.ttf` 和 `MyFont*.tres`，因为 Godot 的默认 GUI 字体加载很早。如果字体只放在外部包里，菜单中文会被加载但显示为空白。

外部 `poa_zh.pck` 目前放汉化场景、脚本和数据表覆盖。完整维护清单见 `docs/patch-map.md`。

主要资源类型：

```text
res://Scenes/First_Menu.tscn
res://Scenes/AbilityBook.tscn
res://Scenes/Armory.tscn
res://Scenes/Bestiary.tscn
res://Scenes/Feats.tscn
res://Scenes/Start_Menu.tscn
res://Scenes/UI_Inv.tscn
res://Scenes/UI_Level_Up.tscn
res://Scenes/UI_Prestige.tscn
res://Scenes/UI_Traits_Basic.tscn
res://Scenes/First_Menu.gd.remap
res://Scenes/First_Menu.gdc
res://Scenes/AbilityBook.gd.remap
res://Scenes/AbilityBook.gdc
res://Scenes/Armory.gd.remap
res://Scenes/Armory.gdc
res://Scenes/Bestiary.gd.remap
res://Scenes/Bestiary.gdc
res://Scenes/Feats.gd.remap
res://Scenes/Feats.gdc
res://Scenes/Start_Menu.gd.remap
res://Scenes/Start_Menu.gdc
res://Scenes/UI_Inv.gd.remap
res://Scenes/UI_Inv.gdc
res://Scenes/UI_Level_Up.gd.remap
res://Scenes/UI_Level_Up.gdc
res://Scenes/UI_Prestige.gd.remap
res://Scenes/UI_Prestige.gdc
res://Scenes/UI_Traits_Basic.gd.remap
res://Scenes/UI_Traits_Basic.gdc
res://translate.gd.remap
res://translate.gdc
res://Data/Table_Feats.json
res://Data/Table_InfoButtons.json
res://Data/Table_Invokes.json
res://Data/Table_Buffs.json
res://Data/Table_Classes.json
res://Data/Table_Gods.json
res://Data/Table_Races.json
res://Data/Table_Traits.json
res://Data/Table_TraitsGeneric.json
```

## GDRETools 构建耗时说明

当前脚本会把每个覆盖的 `.gd` 单独调用一次 GDRETools 编译成 Godot 3.5 bytecode。随着汉化覆盖范围扩大，脚本现在大约会启动 50 多次 GDRETools/Godot 进程，再加上两次 PCK 打包和可选列表输出，完整 `-Deploy` 在本机可能需要 2 分钟以上。

如果外层命令工具设置了 120 秒超时，可能会看到“命令超时”，但 `build/` 和游戏目录里的 PCK 已经生成并且哈希一致。这通常不是 GDRETools 失败，而是外层超时太短。

排查顺序：

1. 重新用更长超时运行完整构建。
2. 查看脚本输出中的阶段耗时，例如 `[00:01:20] Building external Chinese patch PCK...`。
3. 检查 `build\PathofAchra.loader.pck` 和 `build\poa_zh.pck` 的修改时间。
4. 核对 `build\poa_zh.pck` 与游戏目录 `poa_zh.pck` 的 SHA256 是否一致。
5. 需要确认包内容时再加 `-ListFiles`。

## 翻译流程

1. 先在 `docs/glossary.md` 记录术语。
2. 修改 `zh_patch_src/` 下的场景或脚本。
3. 如果新增覆盖脚本，把脚本名加入 `scripts/Build-Patch.ps1` 的 `$sceneScripts` 或 `$topLevelScripts`。
4. 运行 JSON 检查：

```powershell
Get-ChildItem .\zh_patch_src\Data -Filter *.json |
  ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw | ConvertFrom-Json | Out-Null }
```

5. 运行 `git diff --check`。
6. 运行 `scripts/Build-Patch.ps1 -Deploy`。
7. 进游戏检查 UI 是否显示、是否溢出、术语是否一致。

对于数据表翻译，建议先建立批量流程，不要直接大面积手改 JSON。后续可以把 `Data/Table_*.json` 中的 `name`、`description` 等字段抽取成待翻译表，再回写到外部包。

## 游戏更新后的维护流程

1. 关闭游戏。
2. 用新版原始 `PathofAchra.pck` 重新生成 `PathofAchra.pck.orig-backup`。
3. 用 GDRETools 解包新版资源到临时目录。
4. 按 `docs/patch-map.md` 的修改点地图对比同名场景、脚本和数据表。
5. 优先合并 `src/loader/global.gd`、字体资源、`zh_patch_src/translate.gd`。
6. 再合并 UI 场景、事件日志脚本和数据表文本字段。
7. 完整构建部署并检查哈希。
8. 进游戏重点检查主菜单、ESC 设置、背包、学习能力、能力书、军械库、失败/胜利总结页。

## 回滚

```powershell
Copy-Item `
  -Path (Join-Path $GameDir 'PathofAchra.pck.orig-backup') `
  -Destination (Join-Path $GameDir 'PathofAchra.pck') `
  -Force

Remove-Item `
  -Path (Join-Path $GameDir 'poa_zh.pck') `
  -Force `
  -ErrorAction SilentlyContinue
```

## 注意事项

- 不要提交 `build/`、`extracted/`、`.pck` 等生成物或解包资源。
- 游戏更新后，先用新的原版 `PathofAchra.pck` 重新生成 `PathofAchra.pck.orig-backup`，再重跑构建脚本。
- 若菜单变英文，先确认 `poa_zh.pck` 在游戏目录。
- 若菜单中文变空白，先确认主包里有 `res://Fonts/zh-CN.ttf` 和 `res://MyFont*.tres`。

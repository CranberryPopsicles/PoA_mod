# Path of Achra 中文补丁工具

这是一个面向 Godot 版 Path of Achra 的中文补丁工作区。当前方案不是完整替换原资源包，而是在主包里注入一个很小的 loader，并把汉化内容放到外部 `poa_zh.pck`。

## 当前状态

- 游戏版本基线：Path of Achra 1.4.4
- Godot 版本：3.5.x
- 字体：本地中文字体，统一命名为 `zh-CN.ttf`
- 已汉化：主菜单、角色创建界面的一部分 UI、悬停说明、基础机制说明和事迹界面
- 未汉化：种族、职业、神祇、物品、能力、状态、剧情文本

## 目录说明

```text
src/loader/          主资源包注入用 loader 源码
zh_patch_src/        汉化资源源码，包含菜单场景、脚本、字体资源引用和数据表覆盖
local_assets/        本地字体等不提交资源，已被 .gitignore 忽略
docs/glossary.md     术语表，翻译前优先维护这里
scripts/             构建脚本
build/               本地生成物，已被 .gitignore 忽略
compiled_loader/     loader 编译输出，已被 .gitignore 忽略
zh_patch_external/   外部 PCK 临时源目录，已被 .gitignore 忽略
extracted/           GDRETools 解包结果，已被 .gitignore 忽略
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

## 方案说明

`src/loader/global.gd` 会在游戏启动早期执行：

```gdscript
ProjectSettings.load_resource_pack("poa_zh.pck", true)
```

主包里同时放入 `zh-CN.ttf` 和 `MyFont*.tres`，因为 Godot 的默认 GUI 字体加载很早。如果字体只放在外部包里，菜单中文会被加载但显示为空白。

外部 `poa_zh.pck` 目前放汉化场景、脚本和少量数据表覆盖：

```text
res://Scenes/First_Menu.tscn
res://Scenes/Feats.tscn
res://Scenes/Start_Menu.tscn
res://Scenes/First_Menu.gd.remap
res://Scenes/First_Menu.gdc
res://Scenes/Feats.gd.remap
res://Scenes/Feats.gdc
res://Scenes/Start_Menu.gd.remap
res://Scenes/Start_Menu.gdc
res://Data/Table_Feats.json
res://Data/Table_InfoButtons.json
```

## 翻译流程

1. 先在 `docs/glossary.md` 记录术语。
2. 修改 `zh_patch_src/` 下的场景或脚本。
3. 运行 `scripts/Build-Patch.ps1 -Deploy`。
4. 进游戏检查 UI 是否显示、是否溢出、术语是否一致。

对于数据表翻译，建议先建立批量流程，不要直接大面积手改 JSON。后续可以把 `Data/Table_*.json` 中的 `name`、`description` 等字段抽取成待翻译表，再回写到外部包。

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

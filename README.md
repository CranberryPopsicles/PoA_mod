# Path of Achra 中文汉化（二次开发版）

基于 [wtksana/PoA_mod](https://github.com/wtksana/PoA_mod)（原汉化 mod）的二次开发，针对中文本地化的**显示与排版**做了系统性修复。内容翻译沿用原 mod，未改动。

## 与原版的差异

| 类别 | 说明 |
|---|---|
| 中文字体 | 使用 **fusion-pixel** 像素字体：12px 主文本 + 10px 按钮/小字，风格与原版像素风一致 |
| 字体度量 | 修正字体 ascent/descent，行高 18px→12px、字形行内居中，根治"文本偏下/滚动条"问题 |
| 布局修复 | 按钮文本垂直居中、罗马数字居中、文本容器自适应高度、超高滚动 |
| 长文本适配 | 军械库武器介绍、图鉴敌人信息、游戏内敌人面板：压缩留白 + 自适应高度，保证全部内容可见 |
| 行距 | line_spacing = 2（原版压缩为 0 后按反馈微调） |

## 安装（给玩家）

游戏版本需为 **1.4.4**。覆盖前请备份原文件。

1. 将 `PathofAchra.pck`（loader 主包，内含中文字体）复制到游戏目录 `Steam\steamapps\common\Path of Achra\`，覆盖原文件（原版请先备份为 `PathofAchra.pck.orig-backup`）
2. 将 `poa_zh.pck`（汉化包）复制到同一目录
3. 启动游戏

> 已装过原 mod 的用户：只需覆盖 `poa_zh.pck` 即可（loader 主包不变）。

## 从源码构建

前置：GDRE Tools v2.x（Godot 3.5 字节码导出）。

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts\Build-Patch.ps1 `
  -GameDir 'D:\Steam\steamapps\common\Path of Achra' `
  -GDRETools '<gdre_tools.exe 路径>' `
  -Deploy
```

- 构建产物输出到 `build\`（`PathofAchra.loader.pck` + `poa_zh.pck`）
- 字体源码位于 `zh_patch_src\Fonts\`（zh-CN.ttf / zh-CN-10.ttf）
- 汉化源（可编辑）：`zh_patch_src\`（Data 数据表、Scenes 场景与脚本、translate.gd）

## 目录结构

```
scripts/          # 构建部署脚本
zh_patch_src/     # 汉化源（JSON 数据表 / 场景脚本 / 字体 / 资源）
local_assets/     # 本地构建资产（字体等，不随仓库分发）
build/            # 构建产物（不入库）
```

## 致谢与许可

- 上游汉化：**wtksana/PoA_mod**（[GitHub](https://github.com/wtksana/PoA_mod)）
- 字体：**fusion-pixel** 像素字体（[GitHub](https://github.com/TakWolf/fusion-pixel-font)）
- 本仓库为个人学习交流用途的二次开发，代码与资源归属原作者所有。

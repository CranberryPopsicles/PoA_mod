param(
    [string]$GameDir = 'C:\Programs\Steam\steamapps\common\Path of Achra',
    [string]$GDRETools = 'C:\Dev\GDRE_tools\gdre_tools.exe',
    [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [switch]$Deploy
)

$ErrorActionPreference = 'Stop'

function Wait-Path {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [int]$TimeoutSeconds = 10
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ((Get-Date) -lt $deadline) {
        if (Test-Path $Path) {
            return
        }
        Start-Sleep -Milliseconds 250
    }

    throw "Timed out waiting for path: $Path"
}

$originalPck = Join-Path $GameDir 'PathofAchra.pck.orig-backup'
$gamePck = Join-Path $GameDir 'PathofAchra.pck'
$buildDir = Join-Path $ProjectRoot 'build'
$loaderBuildDir = Join-Path $ProjectRoot 'compiled_loader'
$externalSrc = Join-Path $ProjectRoot 'zh_patch_external'
$externalScenes = Join-Path $externalSrc 'Scenes'
$externalData = Join-Path $externalSrc 'Data'
$patchSrc = Join-Path $ProjectRoot 'zh_patch_src'
$patchScenes = Join-Path $patchSrc 'Scenes'
$patchData = Join-Path $patchSrc 'Data'
$loaderSrc = Join-Path $ProjectRoot 'src\loader'
$fontPath = Join-Path $ProjectRoot 'local_assets\Fonts\zh-CN.ttf'

if (-not (Test-Path $GDRETools)) {
    throw "GDRETools not found: $GDRETools"
}
if (-not (Test-Path $originalPck)) {
    throw "Original PCK backup not found: $originalPck"
}
if (-not (Test-Path $fontPath)) {
    throw "Font not found: $fontPath. Put a Chinese font there and name it zh-CN.ttf before building."
}

New-Item -ItemType Directory -Path $buildDir, $loaderBuildDir, $externalScenes -Force | Out-Null

Write-Host "Compiling loader..."
& $GDRETools --headless "--compile=$((Join-Path $loaderSrc 'global.gd'))" --bytecode='3.5.0-stable' "--output=$loaderBuildDir"
Wait-Path -Path (Join-Path $loaderBuildDir 'global.gdc')
Set-Content -Path (Join-Path $loaderBuildDir 'global.gd.remap') -Value "[remap]`n`npath=`"res://global.gdc`"" -Encoding utf8NoBOM

Write-Host "Compiling translated menu scripts..."
& $GDRETools --headless "--compile=$((Join-Path $patchScenes 'First_Menu.gd'))" --bytecode='3.5.0-stable' "--output=$patchScenes"
Wait-Path -Path (Join-Path $patchScenes 'First_Menu.gdc')
& $GDRETools --headless "--compile=$((Join-Path $patchScenes 'Start_Menu.gd'))" --bytecode='3.5.0-stable' "--output=$patchScenes"
Wait-Path -Path (Join-Path $patchScenes 'Start_Menu.gdc')
& $GDRETools --headless "--compile=$((Join-Path $patchScenes 'Feats.gd'))" --bytecode='3.5.0-stable' "--output=$patchScenes"
Wait-Path -Path (Join-Path $patchScenes 'Feats.gdc')
Set-Content -Path (Join-Path $patchScenes 'First_Menu.gd.remap') -Value "[remap]`n`npath=`"res://Scenes/First_Menu.gdc`"" -Encoding utf8NoBOM
Set-Content -Path (Join-Path $patchScenes 'Start_Menu.gd.remap') -Value "[remap]`n`npath=`"res://Scenes/Start_Menu.gdc`"" -Encoding utf8NoBOM
Set-Content -Path (Join-Path $patchScenes 'Feats.gd.remap') -Value "[remap]`n`npath=`"res://Scenes/Feats.gdc`"" -Encoding utf8NoBOM

Write-Host "Preparing external patch source..."
if (Test-Path $externalSrc) {
    Remove-Item -Path $externalSrc -Recurse -Force
}
New-Item -ItemType Directory -Path $externalScenes, $externalData -Force | Out-Null
$externalFiles = @(
    'First_Menu.tscn',
    'Feats.tscn',
    'Start_Menu.tscn',
    'First_Menu.gdc',
    'Feats.gdc',
    'Start_Menu.gdc',
    'First_Menu.gd.remap',
    'Feats.gd.remap',
    'Start_Menu.gd.remap'
)
foreach ($file in $externalFiles) {
    Copy-Item -Path (Join-Path $patchScenes $file) -Destination (Join-Path $externalScenes $file) -Force
}
if (Test-Path $patchData) {
    Get-ChildItem -Path $patchData -Filter '*.json' -File | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination (Join-Path $externalData $_.Name) -Force
    }
}

$loaderPck = Join-Path $buildDir 'PathofAchra.loader.pck'
$zhPck = Join-Path $buildDir 'poa_zh.pck'
Remove-Item -Path $loaderPck, $zhPck -Force -ErrorAction SilentlyContinue

Write-Host "Building loader PCK..."
& $GDRETools --headless "--pck-patch=$originalPck" "--output=$loaderPck" `
    --patch-file="$((Join-Path $loaderBuildDir 'global.gd.remap'))=res://global.gd.remap" `
    --patch-file="$((Join-Path $loaderBuildDir 'global.gdc'))=res://global.gdc" `
    --patch-file="$((Join-Path $patchSrc 'MyFont.tres'))=res://MyFont.tres" `
    --patch-file="$((Join-Path $patchSrc 'MyFont2.tres'))=res://MyFont2.tres" `
    --patch-file="$((Join-Path $patchSrc 'MyFont3t.tres'))=res://MyFont3t.tres" `
    --patch-file="$fontPath=res://Fonts/zh-CN.ttf"

Write-Host "Building external Chinese patch PCK..."
& $GDRETools --headless "--pck-create=$externalSrc" "--output=$zhPck" --pck-version=1 --pck-engine-version=3.5.2

Write-Host "Verifying outputs..."
Wait-Path -Path $loaderPck
Wait-Path -Path $zhPck

& $GDRETools --headless "--list-files=$zhPck"

if ($Deploy) {
    Write-Host "Deploying to game directory..."
    Copy-Item -Path $loaderPck -Destination $gamePck -Force
    Copy-Item -Path $zhPck -Destination (Join-Path $GameDir 'poa_zh.pck') -Force
}

Write-Host "Done."

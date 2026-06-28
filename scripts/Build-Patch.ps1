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

function Wait-StableFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [int]$TimeoutSeconds = 30,
        [int]$StableChecks = 3
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    $lastLength = -1
    $stableCount = 0
    while ((Get-Date) -lt $deadline) {
        if (Test-Path $Path) {
            $length = (Get-Item -LiteralPath $Path).Length
            if ($length -gt 0 -and $length -eq $lastLength) {
                $stableCount += 1
                if ($stableCount -ge $StableChecks) {
                    return
                }
            } else {
                $stableCount = 0
                $lastLength = $length
            }
        }
        Start-Sleep -Milliseconds 500
    }

    throw "Timed out waiting for stable file: $Path"
}

function Copy-Verified {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination
    )

    Copy-Item -LiteralPath $Source -Destination $Destination -Force
    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    $destinationHash = (Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash
    if ($sourceHash -ne $destinationHash) {
        throw "Copied file hash mismatch: $Destination"
    }
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
$loaderGdc = Join-Path $loaderBuildDir 'global.gdc'
Remove-Item -LiteralPath $loaderGdc -Force -ErrorAction SilentlyContinue
& $GDRETools --headless "--compile=$((Join-Path $loaderSrc 'global.gd'))" --bytecode='3.5.0-stable' "--output=$loaderBuildDir"
Wait-StableFile -Path $loaderGdc
Set-Content -Path (Join-Path $loaderBuildDir 'global.gd.remap') -Value "[remap]`n`npath=`"res://global.gdc`"" -Encoding utf8NoBOM

Write-Host "Compiling translated scripts..."
$sceneScripts = @(
    'AbilityBook.gd',
    'Armory.gd',
    'Bestiary.gd',
    'Feats.gd',
    'First_Menu.gd',
    'InfoButtons.gd',
    'Start_Menu.gd',
    'UI_Inv.gd',
    'UI_GameMenu.gd',
    'UI_Level_Up.gd',
    'UI_Prestige.gd',
    'UI_Traits_Basic.gd',
    'DeathScreen.gd',
    'ScoreScreen.gd',
    'GameBars.gd',
    'Game.gd',
    'UI_Log.gd',
    'Graveyard.gd',
    'Continent.gd',
    'UI_Popup.gd',
    'UI_Popup_Nongame.gd'
)
foreach ($script in $sceneScripts) {
    $scriptPath = Join-Path $patchScenes $script
    $compiledName = [System.IO.Path]::ChangeExtension($script, '.gdc')
    $compiledPath = Join-Path $patchScenes $compiledName
    Remove-Item -LiteralPath $compiledPath -Force -ErrorAction SilentlyContinue
    & $GDRETools --headless "--compile=$scriptPath" --bytecode='3.5.0-stable' "--output=$patchScenes"
    Wait-StableFile -Path $compiledPath
    Set-Content -Path (Join-Path $patchScenes "$script.remap") -Value "[remap]`n`npath=`"res://Scenes/$compiledName`"" -Encoding utf8NoBOM
}

$topLevelScripts = @(
    'translate.gd',
    'ToolMessageCreator.gd',
    'RouterEvents_GameTurn.gd',
    'RouterEvents_OnMove.gd',
    'ToolInvokes.gd',
    'RouterEvents_OnInvoke.gd',
    'RouterEvents_OnDeath.gd',
    'RouterEvents_OnPickup.gd',
    'RouterEvents_OnAttack.gd',
    'RouterEvents_OnDamage.gd',
    'RouterEvents_OnHit.gd',
    'RouterEvents_OnIntervention.gd',
    'RouterEvents_OnLevelUp.gd',
    'RouterEvents_OnEnterLevel.gd',
    'RouterEvents_OnLearn.gd',
    'RouterEvents_OnHeal.gd',
    'RouterEvents_OnApplyBuff.gd',
    'RouterEvents_OnRemoveBuff.gd',
    'RouterEvents_OnTeleport.gd'
)
foreach ($script in $topLevelScripts) {
    $scriptPath = Join-Path $patchSrc $script
    $compiledName = [System.IO.Path]::ChangeExtension($script, '.gdc')
    $compiledPath = Join-Path $patchSrc $compiledName
    Remove-Item -LiteralPath $compiledPath -Force -ErrorAction SilentlyContinue
    & $GDRETools --headless "--compile=$scriptPath" --bytecode='3.5.0-stable' "--output=$patchSrc"
    Wait-StableFile -Path $compiledPath
    Set-Content -Path (Join-Path $patchSrc "$script.remap") -Value "[remap]`n`npath=`"res://$compiledName`"" -Encoding utf8NoBOM
}

Write-Host "Preparing external patch source..."
if (Test-Path $externalSrc) {
    Remove-Item -Path $externalSrc -Recurse -Force
}
New-Item -ItemType Directory -Path $externalScenes, $externalData -Force | Out-Null
$externalFiles = @(
    'AbilityBook.tscn',
    'Armory.tscn',
    'Bestiary.tscn',
    'First_Menu.tscn',
    'Feats.tscn',
    'Start_Menu.tscn',
    'UI_Inv.tscn',
    'UI_GameMenu.tscn',
    'UI_Level_Up.tscn',
    'UI_Prestige.tscn',
    'UI_Traits_Basic.tscn'
)
foreach ($file in $externalFiles) {
    Copy-Item -Path (Join-Path $patchScenes $file) -Destination (Join-Path $externalScenes $file) -Force
}
foreach ($script in $sceneScripts) {
    $compiledName = [System.IO.Path]::ChangeExtension($script, '.gdc')
    Copy-Item -Path (Join-Path $patchScenes $compiledName) -Destination (Join-Path $externalScenes $compiledName) -Force
    Copy-Item -Path (Join-Path $patchScenes "$script.remap") -Destination (Join-Path $externalScenes "$script.remap") -Force
}
foreach ($script in $topLevelScripts) {
    $compiledName = [System.IO.Path]::ChangeExtension($script, '.gdc')
    Copy-Item -Path (Join-Path $patchSrc $compiledName) -Destination (Join-Path $externalSrc $compiledName) -Force
    Copy-Item -Path (Join-Path $patchSrc "$script.remap") -Destination (Join-Path $externalSrc "$script.remap") -Force
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
Wait-StableFile -Path $loaderPck
Wait-StableFile -Path $zhPck

& $GDRETools --headless "--list-files=$zhPck"

if ($Deploy) {
    Write-Host "Deploying to game directory..."
    Copy-Verified -Source $loaderPck -Destination $gamePck
    Copy-Verified -Source $zhPck -Destination (Join-Path $GameDir 'poa_zh.pck')
}

Write-Host "Done."

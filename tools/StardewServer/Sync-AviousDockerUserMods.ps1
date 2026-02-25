param(
    [string]$SourceMods,
    [string]$TargetMods
)

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $scriptDir '..\..')).Path
if (-not $TargetMods) {
    $TargetMods = Join-Path $repoRoot 'user_mods'
}
if (-not $SourceMods) {
    throw "Specify -SourceMods <path>. Example: .\tools\StardewServer\Sync-AviousDockerUserMods.ps1 -SourceMods 'D:\StardewHostInstance\Mods'"
}

if (-not (Test-Path -LiteralPath $SourceMods)) {
    throw "Source mods folder not found: $SourceMods"
}

New-Item -ItemType Directory -Force -Path $TargetMods | Out-Null

$exclude = @('ConsoleCommands', 'SaveBackup')
$items = Get-ChildItem -LiteralPath $SourceMods -Directory

foreach ($item in $items) {
    if ($exclude -contains $item.Name) {
        Write-Host "Skipping $($item.Name)"
        continue
    }

    $dest = Join-Path $TargetMods $item.Name
    if (Test-Path -LiteralPath $dest) {
        Remove-Item -LiteralPath $dest -Recurse -Force
    }

    Copy-Item -LiteralPath $item.FullName -Destination $dest -Recurse -Force
    Write-Host "Synced mod: $($item.Name)"
}

Write-Host "Done. Docker user mods folder: $TargetMods"

param(
    [string]$SourceMods = 'D:\StardewHostInstance\Mods',
    [string]$TargetMods = 'G:\My Drive\Google AI Studio\Codex\stardew-multiplayer\user_mods'
)

$ErrorActionPreference = 'Stop'

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

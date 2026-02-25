param()

$ErrorActionPreference = 'Stop'

$mods = @(
    @{ Folder='LivestockBazaar'; Repo='Mushymato/LivestockBazaar'; UniqueID='mushymato.LivestockBazaar' },
    @{ Folder='MiscMapActionsProperties'; Repo='Mushymato/MiscMapActionsProperties'; UniqueID='mushymato.MMAP' },
    @{ Folder='SecretNoteFramework'; Repo='ichortower/SecretNoteFramework'; UniqueID='ichortower.SecretNoteFramework' },
    @{ Folder='TrinketTinker'; Repo='Mushymato/TrinketTinker'; UniqueID='mushymato.TrinketTinker' }
)

$modsRoot = 'G:\My Drive\Google AI Studio\Codex\stardew-multiplayer\mods'
$tmpRoot = Join-Path $env:TEMP 'sdv-mod-updates'
New-Item -ItemType Directory -Force -Path $tmpRoot | Out-Null

function Get-NormalizedVersion([string]$value) {
    if (-not $value) { return $null }
    $v = ($value -replace '^[^0-9]*','') -replace '[^0-9\.].*$',''
    if (-not $v) { return $null }
    try { return [version]$v } catch { return $null }
}

$results = New-Object System.Collections.Generic.List[object]

foreach ($m in $mods) {
    $target = Join-Path $modsRoot $m.Folder
    $manifestPath = Join-Path $target 'manifest.json'
    if (-not (Test-Path $manifestPath)) {
        $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='missing_local'; From=''; To=''; Repo=$m.Repo })
        continue
    }

    $localManifest = Get-Content -Raw $manifestPath | ConvertFrom-Json
    $localVersionRaw = [string]$localManifest.Version

    try {
        $release = Invoke-RestMethod -Headers @{ 'User-Agent'='Codex' } -Uri ("https://api.github.com/repos/{0}/releases/latest" -f $m.Repo)
    } catch {
        $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='api_error'; From=$localVersionRaw; To=''; Repo=$m.Repo })
        continue
    }

    $latestTag = [string]$release.tag_name
    $localVer = Get-NormalizedVersion $localVersionRaw
    $latestVer = Get-NormalizedVersion $latestTag

    $needsUpdate = $false
    if ($localVer -and $latestVer) {
        $needsUpdate = ($latestVer -gt $localVer)
    } elseif ($latestTag -notmatch [regex]::Escape($localVersionRaw)) {
        $needsUpdate = $true
    }

    if (-not $needsUpdate) {
        $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='up_to_date'; From=$localVersionRaw; To=$latestTag; Repo=$m.Repo })
        continue
    }

    $asset = $release.assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
    if (-not $asset) {
        $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='no_zip_asset'; From=$localVersionRaw; To=$latestTag; Repo=$m.Repo })
        continue
    }

    $zipPath = Join-Path $tmpRoot ($m.Folder + '.zip')
    $extractPath = Join-Path $tmpRoot ($m.Folder + '_extract')
    if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }

    Invoke-WebRequest -Headers @{ 'User-Agent'='Codex' } -Uri $asset.browser_download_url -OutFile $zipPath
    Expand-Archive -LiteralPath $zipPath -DestinationPath $extractPath -Force

    $candidate = Get-ChildItem $extractPath -Recurse -Filter manifest.json | ForEach-Object {
        try {
            $mj = Get-Content -Raw $_.FullName | ConvertFrom-Json
            [pscustomobject]@{
                Dir = $_.Directory.FullName
                UniqueID = [string]$mj.UniqueID
                Version = [string]$mj.Version
            }
        } catch {}
    } | Where-Object { $_.UniqueID -eq $m.UniqueID } | Select-Object -First 1

    if (-not $candidate) {
        $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='manifest_not_found_in_zip'; From=$localVersionRaw; To=$latestTag; Repo=$m.Repo })
        continue
    }

    if (Test-Path $target) { Remove-Item $target -Recurse -Force }
    Copy-Item $candidate.Dir $target -Recurse -Force

    $results.Add([pscustomobject]@{ Mod=$m.Folder; Status='updated'; From=$localVersionRaw; To=$candidate.Version; Repo=$m.Repo })
}

$results | Format-Table -AutoSize

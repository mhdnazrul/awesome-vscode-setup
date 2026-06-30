param(
  [switch]$WhatIf
)

$RepoRoot = Resolve-Path "$PSScriptRoot/.."
$VSCodeUserDir = "$env:APPDATA\Code\User"
$BackupDir = Join-Path $RepoRoot "backups"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$DestDir = Join-Path $BackupDir $Timestamp

if (-not (Test-Path $VSCodeUserDir)) {
  Write-Error "VS Code user directory not found: $VSCodeUserDir"
  exit 1
}

Write-Host "Backing up VS Code settings from: $VSCodeUserDir"
Write-Host "Destination: $DestDir"
Write-Host ""

if (-not $WhatIf) {
  $null = New-Item -ItemType Directory -Path $DestDir -Force
}

$filesToBackup = @("settings.json", "keybindings.json", "tasks.json", "launch.json")
$backupCount = 0

foreach ($file in $filesToBackup) {
  $srcPath = Join-Path $VSCodeUserDir $file
  $destPath = Join-Path $DestDir $file

  if (Test-Path $srcPath) {
    if ($WhatIf) {
      Write-Host "  [WhatIf] Would backup: $file"
    }
    else {
      Copy-Item -Path $srcPath -Destination $destPath
      Write-Host "  Backed up: $file"
    }
    $backupCount++
  }
  else {
    Write-Host "  Skipped (not found): $file"
  }
}

if ($WhatIf) {
  Write-Host ""
  Write-Host "[WhatIf] Would export extensions list."
}
else {
  $extensions = & code --list-extensions 2>$null
  $extFile = Join-Path $DestDir "extensions.txt"
  if ($extensions) {
    $extensions | Out-File -FilePath $extFile -Encoding utf8
    Write-Host "  Exported: $($extensions.Count) extensions to extensions.txt"
  }
  else {
    Out-File -FilePath $extFile -Encoding utf8 -InputObject ""
    Write-Host "  Exported: extensions.txt (empty list)"
  }
}

Write-Host ""
Write-Host "Backup complete. $backupCount files saved to: $DestDir"

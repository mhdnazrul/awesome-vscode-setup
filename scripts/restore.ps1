param(
  [switch]$WhatIf
)

$RepoRoot = Resolve-Path "$PSScriptRoot/.."
$VSCodeUserDir = "$env:APPDATA\Code\User"

if (-not (Test-Path $VSCodeUserDir)) {
  Write-Error "VS Code user directory not found: $VSCodeUserDir"
  exit 1
}

Write-Host "Restoring VS Code settings from repo to: $VSCodeUserDir"
Write-Host ""

$filesToRestore = @(
  @{ Name = "settings.json";    Source = Join-Path $RepoRoot ".vscode" }
  @{ Name = "keybindings.json"; Source = Join-Path $RepoRoot ".vscode" }
  @{ Name = "tasks.json";       Source = Join-Path $RepoRoot ".vscode" }
  @{ Name = "launch.json";      Source = Join-Path $RepoRoot ".vscode" }
)
$restoreCount = 0

foreach ($entry in $filesToRestore) {
  $srcPath = Join-Path $entry.Source $entry.Name
  $destPath = Join-Path $VSCodeUserDir $entry.Name

  if (-not (Test-Path $srcPath)) {
    Write-Host "  Skipped (not in repo): $($entry.Name)"
    continue
  }

  if ((Test-Path $destPath) -and (-not $WhatIf)) {
    $backupPath = "$destPath.backup"
    if (-not (Test-Path $backupPath)) {
      Copy-Item -Path $destPath -Destination $backupPath
      Write-Host "  Existing $($entry.Name) backed up to: $($entry.Name).backup"
    }
  }

  if ($WhatIf) {
    Write-Host "  [WhatIf] Would copy: $($entry.Name) to VS Code user dir"
  }
  else {
    Copy-Item -Path $srcPath -Destination $destPath -Force
    Write-Host "  Restored: $($entry.Name)"
  }
  $restoreCount++
}

$extInstaller = Join-Path $PSScriptRoot "install-extensions.ps1"
if (Test-Path $extInstaller) {
  Write-Host ""
  if ($WhatIf) {
    Write-Host "[WhatIf] Would run: $extInstaller"
  }
  else {
    Write-Host "Running extension installer..."
    & $extInstaller
  }
}

Write-Host ""
Write-Host "Restore complete. $restoreCount files applied."
Write-Host "Restart VS Code or run 'Developer: Reload Window' to apply changes."

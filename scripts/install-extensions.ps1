param(
  [switch]$WhatIf
)

$RepoRoot = Resolve-Path "$PSScriptRoot/.."
$ExtensionsFile = Join-Path (Join-Path $RepoRoot ".vscode") "extensions.json"

if (-not (Test-Path $ExtensionsFile)) {
  Write-Error "Extensions file not found: $ExtensionsFile"
  exit 1
}

try {
  $Config = Get-Content $ExtensionsFile -Raw | ConvertFrom-Json
  $Extensions = $Config.recommendations
}
catch {
  Write-Error "Failed to parse extensions file: $_"
  exit 1
}

if (-not $Extensions -or $Extensions.Count -eq 0) {
  Write-Host "No extensions found in recommendations list."
  exit 0
}

$codeCmd = Get-Command "code" -ErrorAction SilentlyContinue

if (-not $codeCmd) {
  Write-Warning "'code' command not found in PATH."
  Write-Host "Install extensions manually from: $ExtensionsFile"
  exit 0
}

Write-Host "Installing $($Extensions.Count) recommended extensions..."
Write-Host ""

$successCount = 0
$failCount = 0

foreach ($ext in $Extensions) {
  if ($WhatIf) {
    Write-Host "[WhatIf] Would install: $ext"
    $successCount++
    continue
  }

  Write-Host "  -> $ext " -NoNewline

  $result = & $codeCmd --install-extension "$ext" --force 2>&1

  if ($LASTEXITCODE -eq 0) {
    Write-Host "OK" -ForegroundColor Green
    $successCount++
  }
  else {
    Write-Host "FAIL" -ForegroundColor Red
    Write-Host "    $result" -ForegroundColor DarkGray
    $failCount++
  }
}

Write-Host ""
Write-Host "Done. $successCount succeeded, $failCount failed."

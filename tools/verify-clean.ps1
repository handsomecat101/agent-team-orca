# Kiểm chứng trên BẢN SAO SẠCH của git index (chỉ những gì đã `git add`) — leader chạy trước khi commit.
# Dùng: Windows  : powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-clean.ps1
#       mac/Linux: pwsh tools/verify-clean.ps1   (PowerShell 7)
# In exit code từng bước; commit CHỈ khi mọi dòng = 0.
#
# 🔧 SỬA $Checks CHO DỰ ÁN CỦA BẠN. Mỗi mục: tên, thư mục con (tương đối gốc repo), lệnh.
#    Ví dụ dưới là dự án Tauri (React + Rust). Dùng đường dẫn đầy đủ cho công cụ không có trong PATH
#    của PowerShell con (vd cargo) — nếu không, $LASTEXITCODE cũ sẽ khiến "lỗi" thành "pass".
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)
$Checks = @(
  @{ Name = 'tsc';   Dir = '.';         Cmd = 'npx tsc --noEmit' },
  @{ Name = 'build'; Dir = '.';         Cmd = 'npx vite build' },
  @{ Name = 'test';  Dir = '.';         Cmd = 'npm test --silent' }
  # @{ Name = 'cargo'; Dir = 'src-tauri'; Cmd = 'cargo test --lib' }   # Windows: nếu PowerShell con không thấy cargo, dùng đường dẫn đầy đủ %USERPROFILE%\.cargo\bin\cargo.exe
)
$LinkNodeModules = $true   # junction node_modules thật vào bản sao (khỏi cài lại)

$ErrorActionPreference = 'Continue'
$tmp = [IO.Path]::GetTempPath()
$isWin = ($PSVersionTable.PSEdition -eq 'Desktop') -or $IsWindows
$d = Join-Path $tmp ('verify-clean-' + (Split-Path $RepoRoot -Leaf))
$nm = Join-Path $d 'node_modules'
if (Test-Path $nm) { if ($isWin) { [IO.Directory]::Delete($nm) } else { Remove-Item $nm -Force } }   # gỡ liên kết TRƯỚC, kẻo xoá node_modules thật
if (Test-Path $d) { [IO.Directory]::Delete($d, $true) }
Set-Location $RepoRoot
git checkout-index -a --prefix="$d/"
if ($LinkNodeModules -and (Test-Path (Join-Path $RepoRoot 'node_modules'))) {
  $kind = if ($isWin) { 'Junction' } else { 'SymbolicLink' }
  New-Item -ItemType $kind -Path $nm -Target (Join-Path $RepoRoot 'node_modules') | Out-Null
}
$res = [ordered]@{}
foreach ($c in $Checks) {
  Set-Location (Join-Path $d $c.Dir)
  $log = Join-Path $tmp ("verify-clean-" + $c.Name + ".log")
  $global:LASTEXITCODE = -1
  Invoke-Expression $c.Cmd *> $log
  $res[$c.Name] = $LASTEXITCODE
}
Set-Location $RepoRoot
if (Test-Path $nm) { if ($isWin) { [IO.Directory]::Delete($nm) } else { Remove-Item $nm -Force } }
[IO.Directory]::Delete($d, $true)
$res.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)   (log: $(Join-Path $tmp ("verify-clean-" + $_.Key + ".log")))" }

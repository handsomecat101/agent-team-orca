# Kiểm chứng trên BẢN SAO SẠCH của git index (chỉ những gì đã `git add`) — leader chạy trước khi commit.
# Dùng: powershell -NoProfile -ExecutionPolicy Bypass -File tools\verify-clean.ps1
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
  # @{ Name = 'cargo'; Dir = 'src-tauri'; Cmd = "& '$env:USERPROFILE\.cargo\bin\cargo.exe' test --lib" }
)
$LinkNodeModules = $true   # junction node_modules thật vào bản sao (khỏi cài lại)

$ErrorActionPreference = 'Continue'
$d = Join-Path $env:TEMP ('verify-clean-' + (Split-Path $RepoRoot -Leaf))
$nm = Join-Path $d 'node_modules'
if (Test-Path $nm) { [IO.Directory]::Delete($nm) }        # gỡ junction TRƯỚC, kẻo xoá node_modules thật
if (Test-Path $d) { [IO.Directory]::Delete($d, $true) }
Set-Location $RepoRoot
git checkout-index -a --prefix="$d/"
if ($LinkNodeModules -and (Test-Path (Join-Path $RepoRoot 'node_modules'))) {
  New-Item -ItemType Junction -Path $nm -Target (Join-Path $RepoRoot 'node_modules') | Out-Null
}
$res = [ordered]@{}
foreach ($c in $Checks) {
  Set-Location (Join-Path $d $c.Dir)
  $log = Join-Path $env:TEMP ("verify-clean-" + $c.Name + ".log")
  $global:LASTEXITCODE = -1
  Invoke-Expression $c.Cmd *> $log
  $res[$c.Name] = $LASTEXITCODE
}
Set-Location $RepoRoot
if (Test-Path $nm) { [IO.Directory]::Delete($nm) }
[IO.Directory]::Delete($d, $true)
$res.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)   (log: %TEMP%\verify-clean-$($_.Key).log)" }

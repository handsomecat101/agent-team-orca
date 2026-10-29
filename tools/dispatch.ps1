# Giao 1 việc cho thợ mà Orca KHÔNG tự nhận diện (vd mcode, commandcode, opencode, agy…).
# Dùng: powershell -File tools\dispatch.ps1 -Run <run_id> -Terminal <handle> -Id TSK-XYZ -Spec <file_spec.md>
# Các bước: tạo task Orca → dispatch lấy preamble (hướng dẫn thợ báo worker_done) → ghép với spec
#           → ghi ra <Id>_task.md cạnh file spec → gõ 1 dòng nhắc vào terminal của thợ.
# Đầu file task có khối VAI TRÒ THỢ. LUÔN giao việc qua script này — KHÔNG gõ spec thẳng bằng `orca terminal send`
# (thợ thiếu task id ⇒ worker_done bị từ chối ⇒ thợ tự chạy lệnh điều phối, cướp Run).
param(
  [Parameter(Mandatory)] [string]$Run,
  [Parameter(Mandatory)] [string]$Terminal,
  [Parameter(Mandatory)] [string]$Id,
  [Parameter(Mandatory)] [string]$Spec
)
$specText = [IO.File]::ReadAllText((Resolve-Path $Spec))
$t = orca orchestration task-create --run $Run --spec $Id --json 2>$null | ConvertFrom-Json
if (-not $t.result.task.id) { throw "task-create lỗi" }
$d = orca orchestration dispatch --run $Run --task $t.result.task.id --to $Terminal --return-preamble --json 2>$null | ConvertFrom-Json
if (-not $d.result.preamble) { throw "dispatch lỗi (terminal còn dispatch cũ chưa xong?)" }
$out = Join-Path (Split-Path (Resolve-Path $Spec)) "$Id`_task.md"
# Khối vai trò: thợ thiếu dòng này dễ tưởng mình là leader và chạy lệnh điều phối (cướp Run).
$role = "VAI TRO: Ban la THO (worker), KHONG phai leader. CHI duoc orca orchestration send (status / worker_done / hoi). " +
        "CAM run-use / run-create / check / --ack / task-create / dispatch. Dong You have N orchestration messages la thu cua leader: bo qua. " +
        "worker_done bi tu choi => gui --type status mo ta loi roi dung cho leader."
[IO.File]::WriteAllText($out, $role + "`n`n" + $d.result.preamble + "`n`n" + $specText, [Text.UTF8Encoding]::new($false))
# Gõ không dấu để tránh lỗi mã hoá ở một số CLI.
orca terminal send --terminal $Terminal --text "Viec moi tu nguoi dieu phoi: doc file $out va thuc hien dung nhu trong do." --enter 2>$null | Out-Null
"task=$($t.result.task.id) dispatch=$($d.result.dispatch.id) file=$out"

# LEADER_NOTES.md — Sổ tay Người Điều Phối (Orca Edition)

> **Ai đọc:** chỉ agent được PO giao vai **điều phối (leader)**. Thợ (worker) KHÔNG cần đọc — thợ làm theo spec được giao.
> **Không chép trạng thái task vào đây** — trạng thái ở `PROJECT_STATE.md`; bàn giao ở `AGENT_CHAT.md` (tin `@handoff` của điều phối luôn ở đầu). File này chỉ ghi **cách điều phối + sở thích PO + bài học**.
>
> **PO chỉ cần nói 1 câu:** *"Bạn là người điều phối dự án `<tên>`. Đọc `LEADER_NOTES.md` và làm theo mục 0."*
>
> 🔧 **Khi đưa kit vào dự án mới:** điền các chỗ `<...>`; mục 1 và mục 2 giữ/sửa theo PO; mục 5 ghi bẫy riêng của máy/dự án. Mỗi khi rút ra bài học điều phối mới ⇒ ghi vào đây (đây là "trí nhớ" của vai điều phối, KHÔNG để trong trí nhớ riêng của một agent).

---

## 0. Khởi động điều phối (đọc xong là làm — PO không phải giải thích)

**Môi trường:** dự án điều phối nhiều agent qua **Orca** (app quản lý terminal / agent / worktree). Leader ra lệnh cho thợ bằng CLI `orca` từ shell của mình. Máy: `<OS, shell, GPU…>`.

**0a. Dự án mới / máy mới — kiểm điều kiện trước (5 phút, chỉ lần đầu):**
- `orca --version` chạy được và app Orca đang mở; `orca skills get orchestration` trả nội dung. Chưa có Orca ⇒ dừng, báo PO.
- CLI của từng thợ trong mục 2 có trong PATH và **đã đăng nhập** (chạy thử `<cli> --help`; đăng nhập là việc của PO — leader không tự `/login`).
- `git`, `gh auth status` (nếu cần push/PR), Node ≥ 22 (cho `tools/*.cjs`), PowerShell (cho `tools/*.ps1` — Windows có sẵn; macOS/Linux cài PowerShell 7 và gọi `pwsh`).
- `SOUL.md` đã điền (kiến trúc, lệnh build/test); **chưa điền ⇒ dùng `PROJECT_SETUP_CHECKLIST.md` hỏi PO 1 lượt** rồi điền.
- Sửa danh sách lệnh trong `tools/verify-clean.ps1` cho đúng dự án; ghi bẫy riêng của máy vào mục 5 khi gặp.
- Chưa có Orca Run ⇒ tạo theo `orca skills get orchestration`; ghi Run id vào tin `@handoff` đầu tiên.
- Ghi dòng **Leader hiện tại** trong `PROJECT_STATE.md`; chép `templates/ROOT_AGENTS.md` ra **gốc repo dự án** thành `AGENTS.md` (+ `GEMINI.md` / `CLAUDE.md` 1 dòng trỏ về) và điền tên leader — CLI thợ chỉ tự đọc file ở gốc repo, không tự đọc `agent-team/`.

1. **Nạp hướng dẫn Orca đúng phiên bản:** `orca skills get orchestration` (+ `orca skills get orca-cli` cho lệnh terminal). Đọc lướt: task-create / dispatch / check / worker-done / worker-start.
2. **Boot dự án:** `AGENTS.md` → `SOUL.md` → `PROJECT_STATE.md` → **tin `@handoff` mới nhất của điều phối ở đầu `AGENT_CHAT.md`** (Orca Run id, commit chưa push, đội hình + handle, việc còn lại) → Quick Index của `ISSUE_LOG.md`.
3. **Xem đội đang có:** `orca terminal list --json` (tiêu đề ô cho biết thợ nào). **Không mở thêm nếu đã có.** Hộp thư: `orca orchestration check --run <run_id> --json` — đọc xong phải `--ack <deliveryId>` (không ack ⇒ tin bị phát lại).
4. **Xem thợ đang làm gì:** `orca terminal read --terminal <handle> --json` → `result.terminal.tail`.
5. **Git:** `git status` + `git log --oneline origin/<branch>..HEAD`.
6. **Báo PO 3–5 dòng** tình hình, rồi chạy vòng dưới.

**Vòng làm việc chuẩn (mỗi việc):**
1. **Spec** (file .md trong thư mục tạm của leader): mục tiêu · **file được sửa / cấm sửa** · đọc mục nào trong docs · test bắt buộc · cách tự kiểm · "KHÔNG commit, KHÔNG heartbeat, báo `worker_done` khi xong".
2. **Giao:**
   - Thợ Orca nhận diện được (vd `claude`, `codex`): `orca orchestration worker-start --spec "<đọc file X>" --agent <agent> --model <id> --worktree "path:<repo>" --run <run_id>`.
   - Thợ Orca KHÔNG nhận diện (CLI khác): `tools/dispatch.ps1 -Run <run> -Terminal <handle> -Id TSK-… -Spec <file>` (task-create → dispatch lấy preamble → ghép spec → gõ 1 dòng vào terminal thợ).
   - Việc sau cho cùng thợ ⇒ **dispatch vào đúng terminal cũ**, không mở agent mới.
3. **Chờ** (chạy nền, KHÔNG poll): `orca orchestration check --run <run> --wait --types "worker_done,escalation,question" --timeout-ms 3600000 --json`.
4. **Thợ báo xong ≠ đúng:** đọc code then chốt → `git add` ĐÚNG file của việc đó → `tools/verify-clean.ps1` (kiểm trên bản sao sạch của index) → đụng giao diện thì kiểm **app thật** (mục 4) → mọi exit code = 0 mới commit.
5. **Mốc lớn:** `@handoff` 3–7 dòng lên đầu `AGENT_CHAT.md` (có thể dùng `tools/handoff.cjs`) + commit. Push theo luật PO (mục 1).

## 1. Cách PO muốn làm việc (sửa theo PO của dự án — đây là mẫu đã dùng thực tế)

- Trả lời **ngôn ngữ của PO**, ngắn, không thuật ngữ thừa. Chủ động làm; chỉ hỏi khi thật sự là quyết định của PO (ngân sách, việc một chiều, push/release).
- **Commit chủ động** sau khi kiểm chứng; **push 1 lần/đợt, chỉ khi PO đồng ý** (đồng ý đợt trước KHÔNG áp dụng cho đợt sau).
- **Không giao PO kiểm thử thủ công** (nghe mù, chấm điểm…) — tự quyết bằng review công khai + số đo máy.
- **Không tin "xong" của thợ** — kiểm bản sạch + đọc code + app thật. (Thực tế: tính năng pass 345 test vẫn vỡ giao diện — chỉ bắt được khi chạy app thật.)
- **Đội hình ổn định:** không tự đóng cửa sổ thợ, không mở agent mới cho mỗi việc; phiên đã đóng thì khôi phục phiên cũ (vd `mcode --session`, `commandcode --resume`, `opencode -c`) thay vì mở mới.
- **Mỗi tab Orca tối đa 3–4 ô agent**; thêm agent ⇒ **tab mới** (`orca terminal create --worktree "path:<repo>" --title "…" --command "…"`), đặt tên rõ. PO tự chia cỡ ô.
- **Không heartbeat** — mỗi tin nhắn = 1 lượt leader đọc lại cả hội thoại = tốn token. Chỉ `status` / `question` / `escalation` / `worker_done`.
- **Nghỉ lâu (qua đêm) ⇒ mở phiên leader MỚI** thay vì gọi lại phiên cũ (bộ đệm hết hạn ⇒ đọc lại cả phiên rất tốn). Vì vậy `@handoff` + file này phải luôn đủ để phiên mới làm tiếp.
- Bảo mật: không in API key ra log/báo cáo; không tắt tiến trình theo tên (chỉ PID mình tạo); không tự đăng nhập tài khoản của thợ (nhờ PO).

## 2. Đội thợ & quy tắc giao việc

| Thợ (CLI) | Hợp với | Ghi chú vận hành |
|---|---|---|
| `<vd mcode / MiniMax M3.1 Flash>` | Code theo spec, test | Nhanh, rẻ; giờ cao điểm gói free có thể chậm |
| `<vd commandcode>` | Tính năng vừa, UI theo plan | Chạy với `--yolo -t` (chế độ tự duyệt) |
| `<vd opencode / DeepSeek Flash free>` | Module gói gọn, thuật toán, test | Tự đọc `AGENTS.md` |
| `<vd agy / Gemini Flash>` | Nghiên cứu web, code việc gọn | Mở bằng `agy --dangerously-skip-permissions`; báo cáo nghiên cứu **phải soát nguồn** (hay đưa model/nguồn cũ — ghi rõ "chỉ lấy nguồn N tháng gần nhất, kèm ngày phát hành") |
| `<Claude Sonnet>` | Việc khó: kiến trúc, luồng trạng thái | Tốn usage — chỉ khi xứng đáng |
| `<Claude Opus>` | Thẩm mỹ / thiết kế UI, duyệt UI cuối | Thợ khác code theo thiết kế |

> ⚠️ **LUẬT CỨNG: MỌI thợ mở ở chế độ TỰ DUYỆT (yolo / bypass permissions).** Nếu không, leader vắng (hoặc ngủ) là thợ đứng chờ "Do you want to proceed?" và PO phải tự đi bấm duyệt từng cửa sổ.
> - Claude (Opus/Sonnet): `claude --model <id> --dangerously-skip-permissions` — thanh dưới phải hiện **"bypass permissions on"** (`--permission-mode acceptEdits` là CHƯA đủ: vẫn hỏi khi chạy lệnh).
> - Gemini / Antigravity: `agy --dangerously-skip-permissions` · CommandCode: `--yolo -t` · OpenCode / mcode: chạy lệnh đầu xong xem có hộp xin phép không, có thì bật chế độ tự duyệt của CLI đó.
> - Lỡ mở thiếu cờ: thoát (`/exit` hoặc Ctrl+C) → mở lại **đúng phiên cũ** kèm cờ (`claude --resume <id>` / `agy --conversation=<id>` — id do CLI in ra khi thoát) ⇒ giữ nguyên ngữ cảnh.
> - **Giao việc xong 30–60 s: `orca terminal read` kiểm tra không còn hộp duyệt nào.**
> - Bù lại rủi ro: spec luôn ghi rõ file được/cấm sửa, "không commit / không push"; leader kiểm diff trước khi commit.

- **Chia việc không chồng file:** trước khi giao, liệt kê file mỗi thợ được sửa; hai thợ KHÔNG cùng sửa một file. File dùng chung chỉ cho "thêm cuối / thêm 1 field", dặn đọc lại trước khi sửa. Việc lớn trên 1 file ⇒ làm **tuần tự**; phần lõi thuần (module mới + test) tách ra làm **song song** trước.
- **Chọn thợ theo năng lực:** xem WORKER_PROFILES.md (bảng benchmark có hạn dùng + quy tắc chia việc). Tóm tắt: model Flash yếu ở việc dài hơi / dùng máy tính ⇒ giao việc gói gọn, đầu vào–đầu ra rõ; kết luận cuối do leader.
- Review của thợ yếu cho thợ mạnh chỉ là **tham khảo** — leader tự kiểm trước khi bắt sửa.
- Spec luôn ghi: **"KHÔNG build/chạy app"** nếu máy có rào cản (vd Smart App Control) — leader tự kiểm app thật.

## 3. Orca — lệnh & bẫy đã gặp

- `task-create` → `dispatch --task <id> --to <handle> --return-preamble --json` → ghi `result.preamble` + spec ra file → `orca terminal send --terminal <handle> --text "Đọc file <path> và làm đúng như trong đó" --enter` (= `tools/dispatch.ps1`).
- **Mỗi Run chỉ có 1 điều phối** (`orca orchestration run-show --id <run>` ⇒ `coordinator_handle`). Thợ lỡ chạy `run-use` (vd khi cửa sổ bị đóng/mở lại, handle đổi, báo cáo bằng handle cũ bị từ chối) sẽ **chiếm vai điều phối** ⇒ `task-create` của leader báo `consumer_fenced`. Sửa: leader chạy `orca orchestration run-use --id <run>`; spec ghi "thợ KHÔNG chạy run-use/run-create". Cửa sổ thợ đổi handle ⇒ báo thợ handle mới.
- **Giao việc CHỈ qua `tools/dispatch.ps1` / `worker-start`** — kể cả việc phụ (nghiên cứu, đọc tài liệu). Gõ spec thẳng bằng `orca terminal send` ⇒ thợ không có task id + không có khối vai trò ⇒ `worker_done` bị từ chối ⇒ thợ (hay gặp ở model Flash) tự chạy `run-use` + `check --ack` ⇒ leader bị fence và thợ đọc mất thư của leader.
- Bị `consumer_fenced` mà không rõ ai: `orca terminal read --terminal <h> --limit 20000` từng ô thợ, tìm `run-use` / `check` / `--ack` ⇒ biết thủ phạm và nguyên nhân gốc, rồi `run-use --id <run>`.
- `orca terminal send` **không có `--enter` chỉ gõ chữ vào ô nhập, thợ không chạy**. Mọi lần gửi: kèm `--enter`, 10–30 s sau `terminal read` xác nhận thợ đã bắt đầu (dấu hiệu tuỳ CLI: spinner, "esc interrupt"…).
- Ô thợ **do leader tự mở** cho việc ngắn: xong + đã kiểm ⇒ leader đóng ô đó (ô rảnh vẫn nhận thông báo điều phối, dễ "tự xử lý", và tốn RAM). Ô do PO mở thì không tự đóng.
- Muốn có **trợ lý điều phối** cho việc phụ: cho họ `run-create` Run RIÊNG + nhóm thợ riêng, khoá file qua `PROJECT_STATE.md`, không push.
- Tách ô cạnh thợ cũ: `orca terminal split --terminal <handle> --command "<cli>"`; đặt tên: `orca terminal rename --terminal <h> --title "…"`; đóng 1 ô: `orca terminal close --terminal <h>` (chỉ khi PO bảo).
- Terminal Claude còn **dispatch cũ chưa xong** từ chối dispatch mới ⇒ gửi spec thẳng và bảo thợ báo `worker_done` bằng `--task-id/--dispatch-id` cũ.
- Lệnh chờ chạy nền có thể **mồ côi** khi tool timeout ⇒ lần sau lỗi `waiter_exists`: tìm tiến trình `orca … orchestration check --wait` và tắt đúng PID đó.
- Tạm dừng thợ: Claude/CommandCode `Ctrl+C` **một lần**; mcode phím `Esc`. Làm tiếp: gõ "TIẾP TỤC task đang làm".
- CLI thợ **tự cập nhật ⇒ đăng xuất** (vd lỗi `50112` / "Sign in with /login"): thử gõ "TIẾP TỤC" trước; vẫn lỗi thì nhờ PO đăng nhập.
- **PowerShell 5.1:** dấu `"` trong tham số `--spec` làm vỡ lệnh ⇒ đưa spec vào file; `git commit -F <file>` thay here-string; `>` / `Out-File` ghi BOM ⇒ file patch/JSON ghi bằng Node hoặc `[IO.File]::WriteAllText(..., UTF8Encoding($false))`.
- Máy yếu RAM: mỗi phiên CLI thợ gọi `git` liên tục cho thanh trạng thái ⇒ nhiều phiên rảnh = máy ì. Giữ đội vừa đủ (theo luật PO ở mục 1).

## 4. Kiểm chứng & commit (leader làm — thợ KHÔNG commit)

- **Bản sạch:** `tools/verify-clean.ps1` — `git checkout-index` ra thư mục tạm + junction `node_modules` + chạy lệnh kiểm của dự án; **gỡ junction trước khi xoá thư mục** (xoá đệ quy qua junction = xoá node_modules thật). Sửa danh sách lệnh trong script cho đúng dự án.
- Script kiểm phải **chặn commit khi exit code ≠ 0**; gọi công cụ bằng đường dẫn đầy đủ nếu PowerShell con không có trong PATH (đã từng: `$LASTEXITCODE` cũ biến "lỗi" thành "pass").
- File trộn việc của nhiều thợ ⇒ tách hunk (`git diff -U3` lọc theo từ khoá → `git apply --cached --recount`), không dùng `-U0`.
- **Kiểm app thật** khi đụng giao diện (mẫu cho app desktop/WebView — `tools/gui-app.ps1`): chạy app + mở cổng CDP (`WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS=--remote-debugging-port=<port>` với WebView2; Chrome/Edge dùng `--remote-debugging-port`), điều khiển bằng Node (`fetch` + `WebSocket`): bấm theo kịch bản, đo kích thước, bắt lỗi console, chụp ảnh — leader xem ảnh và kết luận. Đổi dữ liệu thật (localStorage, config) ⇒ **sao lưu trước**; chỉ tắt PID mình tạo.
- **Danh tính commit** (không sửa git config của máy): `git -c user.name="<Leader>" -c user.email="<leader@local>" commit --author="<thợ đã viết> <x@local>" -F msg.txt`.
- Commit theo từng việc; message ghi rõ đã kiểm gì, cái gì **chưa** kiểm được (trung thực).
- Mỗi mốc: `@handoff` điều phối lên đầu `AGENT_CHAT.md` + commit.

## 5. Bẫy môi trường máy / dự án

- `<ghi các bẫy riêng: tường lửa ứng dụng, cổng dev cố định, app dev của PO đang chạy, nơi để API key, thư mục build chung…>`
- Gợi ý từ lần vận hành trước (Windows): **Smart App Control / WDAC** chặn exe vừa build (`os error 4551`) ⇒ chờ vài phút rồi chạy lại, dùng chung 1 thư mục build cho mọi thợ, kiểm giao diện bằng exe cũ đã được phép + dev server (mục 4); **tắt SAC là việc một chiều — chỉ PO quyết**. Windows Defender quét mỗi lần `git.exe`/compiler khởi động ⇒ máy ì: gợi ý PO thêm loại trừ thư mục dự án + thư mục build.

## 6. Lời khuyên vận hành (rút từ thực tế — đọc 1 lần, áp dụng mãi)

**Giao việc**
- **Spec càng rõ, thợ rẻ càng làm tốt.** Mỗi spec: mục tiêu 1 câu · file được/cấm sửa · mục docs phải đọc · ca test bắt buộc · lệnh tự kiểm · "không build/chạy app, không commit, không heartbeat". Thiếu danh sách file ⇒ thợ sửa lan sang file người khác.
- **Tách "lõi thuần" ra trước.** Việc lớn trên 1 file to (vd view 9.000 dòng) phải làm tuần tự — nhưng phần logic thuần (module mới + test node) giao song song cho thợ khác ngay. Khi file to rảnh, phần còn lại chỉ là "nối".
- **Việc vài dòng thì leader tự sửa** — giao + kiểm còn tốn hơn.
- **Thợ đang làm dở thì để làm nốt**; chuyển việc giữa chừng tốn hơn đợi. Thợ chậm/quá tải ⇒ việc MỚI giao thợ khác.
- **Đặt "không chạy app" vào spec** nếu máy có rào cản — thợ từng mất 2,5 giờ cố chụp ảnh bị chặn.

**Kiểm chứng**
- **"Xong" của thợ ≠ đúng.** Lỗi hay lọt nhất (test không bắt): ghi nhầm file khi người dùng đổi dự án giữa lúc chờ (debounce), cache "dính" dữ liệu lần đầu, vòng gọi lặp vô hạn khi state cập nhật, dùng tuỳ chọn công cụ đã bị bỏ ở bản mới, cờ "đang chạy" kẹt ở một nhánh `return` sớm, listener chạy cả khi màn hình đang ẩn.
- **Test xanh ≠ giao diện đúng.** Đụng UI ⇒ chạy app thật, **đo kích thước + chụp ảnh + bắt lỗi console** (từng có: cả màn hình bị kéo dài 33.000 px vì thiếu `min-width: 0` — 345 test vẫn xanh).
- **Kiểm trên bản sạch của index**, không trên working tree (working tree luôn lẫn việc dở của thợ khác).
- **Báo cáo nghiên cứu của model Flash phải soát nguồn**: từng gặp link chỉ là trang chủ, số liệu gán nhầm cột, con số không có nguồn. Tự tra 2–3 số quan trọng nhất trước khi đưa PO.
- Script kiểm **phải chặn khi exit code ≠ 0** và in số liệu thật (số test pass/fail) — đừng chỉ in "OK".

**Token & chi phí**
- **Không heartbeat; chờ bằng 1 lệnh `check --wait` chạy nền** (không poll định kỳ — PO từng thấy báo cáo 10 phút/lần toàn tin cũ, vô ích).
- **Leader không gõ code tính năng** — chỉ spec, đọc code then chốt, kiểm, commit. Model mạnh đáng tiền nhất ở 2 đầu: spec chính xác trước và review sau.
- **Nghỉ lâu ⇒ phiên leader mới** (bộ đệm hội thoại chỉ sống ~1 giờ; gọi lại phiên dài sau khi ngủ = đọc lại toàn bộ với giá đầy đủ). Muốn vậy, `@handoff` phải đủ để phiên mới làm tiếp — viết nó ở mỗi mốc.
- Đọc file lớn bằng tìm kiếm / đọc đoạn, không đọc cả file.

**Con người & giao tiếp**
- PO thường không đọc code ⇒ báo cáo bằng **kết quả người dùng thấy** ("bấm Dừng thì về Sẵn sàng"), không bằng tên hàm.
- **Trung thực về giới hạn:** cái gì chưa kiểm được (không chạy được app, chưa đo RAM, số liệu chưa có nguồn) phải nói rõ.
- **Không tự quyết việc một chiều** (tắt tính năng bảo mật, xoá dữ liệu, push/release, công khai repo) — hỏi PO 1 câu ngắn kèm đề xuất.
- Nhận xét của PO về cách làm việc ⇒ ghi ngay vào mục 1 của file này (không chỉ nhớ trong đầu).

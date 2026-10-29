# CHANGELOG.md - Lịch Sử Tiến Hóa Bộ Kit (Agent Collaborator Kit)

> **⚠️ HƯỚNG DẪN CHO CÁC AGENT CẬP NHẬT REPO NÀY TRONG TƯƠNG LAI (MAINTAINER RULE):**
> 1. Repo `handsomecat101/agent-team` là **Bộ Template Gốc (Upstream Framework)** dùng chung cho mọi dự án.
> 2. **TUYỆT ĐỐI KHÔNG** ghi đè dữ liệu riêng của một dự án cụ thể (như task riêng, bug riêng của app) lên nhánh `main` của repo này — hãy giữ `SOUL.md`, `PROJECT_STATE.md`, `AGENT_CHAT.md`, `ISSUE_LOG.md` ở dạng **Template chuẩn**.
> 3. Mỗi khi bạn (bất kỳ AI Agent nào ở tương lai) cải tiến quy trình hoặc nâng cấp cấu trúc của bộ Kit này, **BẮT BUỘC**:
>    - Ghi thêm một mục phiên bản mới (`v1.x.0`) vào ngay đầu phần **Lịch Sử Cập Nhật** bên dưới (Ghi rõ: *Ngày cập nhật, Tên Agent thực hiện, Vấn đề giải quyết, và Các file đã thay đổi*).
>    - Đồng bộ badge version trong `README.md`.

---

## 📅 Lịch Sử Cập Nhật (Mới nhất ở trên)

### [v1.2.4-orca] - 2026-10-29
- **Thực hiện bởi:** Claude Code (Opus 5.5), theo yêu cầu jimmyvu.
- **Vấn đề (gặp thật):** leader bị `consumer_fenced` nhiều lần trong 1 buổi. Đọc lịch sử terminal: 1 thợ model Flash tự chạy `run-use` + `check --ack` ⇒ chiếm Run và đọc mất thư của leader. Nguyên nhân gốc: (1) leader giao việc phụ bằng `orca terminal send` trần ⇒ thợ không có task id / không được dặn vai trò ⇒ `worker_done` bị từ chối ⇒ thợ tự "sửa" bằng lệnh điều phối; (2) gốc repo dự án không có file nào ghi ai là leader, CLI thợ không tự đọc `agent-team/`; (3) `terminal send` thiếu `--enter` ⇒ thợ không chạy mà leader tưởng đã giao.
- **Chi tiết:**
  1. `AGENTS.md` — thêm **mục 0 "Bạn là ai?"**: chỉ 1 leader (ghi ở `PROJECT_STATE.md`), còn lại là THỢ; thợ chỉ được `orchestration send`, cấm `run-use / run-create / check / --ack / task-create / dispatch`; bỏ qua dòng "You have N orchestration messages"; `worker_done` bị từ chối ⇒ báo `status` rồi dừng.
  2. `PROJECT_STATE.md` — thêm dòng **Leader hiện tại** trong Project Info.
  3. `templates/ROOT_AGENTS.md` (mới) — mẫu file vai trò để chép ra **gốc repo dự án** (+ `GEMINI.md` / `CLAUDE.md` trỏ về).
  4. `tools/dispatch.ps1` — tự chèn **khối VAI TRÒ THỢ** lên đầu file task; ghi chú "luôn giao qua script này".
  5. `LEADER_NOTES.md` — mục 0a: ghi leader + chép file vai trò ra gốc repo; mục 3: chỉ giao qua `dispatch.ps1` / `worker-start`, cách truy thủ phạm khi bị fence, `terminal send` phải có `--enter` + kiểm thợ đã chạy, đóng ô thợ tạm do leader mở.

### [v1.2.3-orca] - 2026-10-29
- **Thực hiện bởi:** Claude Code (Opus 5.5), theo yêu cầu jimmyvu.
- **Mục tiêu:** leader ở dự án khác có **format chuẩn** để tự giao thợ cập nhật benchmark và tự ghi đánh giá thực chiến ⇒ tự tin hơn khi chia việc.
- **Chi tiết (`WORKER_PROFILES.md`):** thêm (1) **bảng benchmark chi tiết** dạng mẫu (tiêu chí × model, cách ghi số + phiên bản + nguồn, giá, gói miễn phí) với số ví dụ; (2) **bảng "Đánh giá thực chiến"** 1 dòng/việc kèm 4 dòng ví dụ thật; (3) **spec mẫu** giao 1 thợ cập nhật benchmark (chỉ nguồn mới, link đúng trang có số, leader kiểm 2–3 số).

### [v1.2.2-orca] - 2026-10-28
- **Thực hiện bởi:** Claude Code (Opus 5.5), theo yêu cầu jimmyvu.
- **Vấn đề:** thợ mở thiếu chế độ tự duyệt ⇒ đứng chờ duyệt, PO phải tự bấm; thợ lỡ `run-use` chiếm vai điều phối.
- **Chi tiết (`LEADER_NOTES.md`):**
  1. Mục 2: **luật cứng mọi thợ mở chế độ tự duyệt** + lệnh cho Claude / agy / CommandCode / OpenCode / mcode, cách mở lại đúng phiên kèm cờ, bước kiểm 30–60 s sau giao việc.
  2. Mục 3: mỗi Run chỉ 1 điều phối, cách lấy lại vai (`run-use`), cách cho **trợ lý điều phối** dùng Run riêng.
  3. Bảng thợ: agy mở bằng `--dangerously-skip-permissions`; nghiên cứu phải ghi "chỉ lấy nguồn mới, kèm ngày phát hành".

### [v1.2.1-orca] - 2026-10-26
- **Thực hiện bởi:** Claude Code (Opus 5.5), theo yêu cầu jimmyvu.
- **Mục tiêu:** leader mới ở **bất kỳ dự án / máy nào** đọc là vào việc được, kèm kinh nghiệm đã trả giá.
- **Chi tiết:**
  1. `LEADER_NOTES.md` mục **0a** — kiểm điều kiện dự án/máy mới (Orca, CLI thợ đã đăng nhập, git/gh/Node, SOUL đã điền, sửa `verify-clean.ps1`, tạo Orca Run).
  2. `LEADER_NOTES.md` mục **6 "Lời khuyên vận hành"** — giao việc, kiểm chứng (các loại lỗi test không bắt), token & chi phí, giao tiếp với PO; mục 5 thêm gợi ý bẫy Windows (Smart App Control, Defender).
  3. Thêm **`WORKER_PROFILES.md`** — bảng benchmark model thợ (có ngày, nguồn, cảnh báo "số hãng tự công bố"), cách đọc số, quy tắc chia việc, quy trình cập nhật mỗi quý.
  4. README: cấu trúc, bảng tài liệu, badge, roadmap; bảng **Yêu cầu & nền tảng** (Windows / macOS / Linux).
  5. `tools/verify-clean.ps1` chạy được cả PowerShell 7 trên macOS/Linux (symlink thay junction, thư mục tạm theo hệ điều hành); đã thử: bước lỗi trả đúng exit code ≠ 0.
### [v1.2.0-orca] - 2026-10-26
- **Thực hiện bởi:** Claude Code (Opus 5.5) — rút ra từ 2 ngày làm điều phối Orca thực tế (cùng jimmyvu).
- **Repo:** `handsomecat101/agent-team-orca` — bản phái sinh của `handsomecat101/agent-team` (v1.1.0); repo gốc giữ nguyên.
- **Vấn đề giải quyết:** mỗi lần đổi leader điều phối, PO phải giải thích lại môi trường Orca, skill cần đọc, đội thợ, quy trình kiểm chứng; hiểu biết của leader cũ nằm trong trí nhớ riêng của agent đó và script nằm trong thư mục tạm ⇒ mất.
- **Chi tiết các thay đổi:**
  1. **Thêm `LEADER_NOTES.md`** — sổ tay vai điều phối: mục 0 khởi động (nạp skill Orca, tiếp quản đội, vòng spec → giao → chờ → kiểm chứng → commit), mục 1 cách PO muốn làm việc, mục 2 đội thợ & chia việc không chồng file, mục 3 lệnh & bẫy Orca, mục 4 kiểm chứng (bản sạch + app thật qua CDP) & danh tính commit, mục 5 bẫy máy.
  2. **Thêm `tools/`:** `dispatch.ps1` (giao việc cho thợ CLI Orca không nhận diện), `verify-clean.ps1` (kiểm trên bản sao sạch của index, danh sách lệnh sửa theo dự án), `cdp-check.cjs` (mẫu kiểm giao diện app thật qua CDP), `handoff.cjs` (chèn `@handoff`, tự đẩy tin cũ sang `ARCHIVE/`).
  3. **`AGENTS.md`:** thêm mục 4 "Nếu bạn được giao vai điều phối" → đọc `LEADER_NOTES.md` mục 0. **`README.md`:** thêm phần "Điều phối nhiều agent với Orca", cấu trúc, bảng tài liệu, roadmap, badge.
  4. **Không đổi** `SOUL.md`, `PROJECT_STATE.md`, `AGENT_CHAT.md`, `ISSUE_LOG.md`, `QUY_TRINH.md`, `GOVERNANCE.md` — lõi kit vẫn dùng chung cho mọi công cụ; phần riêng của Orca chỉ nằm ở lớp leader.

### [v1.1.0] - 2026-09-28
- **Thực hiện bởi:** Antigravity (cùng jimmyvu)
- **Mục tiêu nâng cấp:** Giải quyết tình trạng các Agent viết báo cáo lặp lại ở cả 3 file gây phình to context (tốn 10.000+ token mỗi phiên) và hỗ trợ chuyển đổi tự do giữa nhiều IDE mà không cần copy-paste prompt thủ công.
- **Chi tiết các thay đổi:**
  1. **Thêm mới `AGENTS.md` (Multi-IDE Auto-Boot):**
     - File quy tắc gốc giúp các IDE/CLI hiện đại (Antigravity, Claude Code, Cursor, Codex, OpenCode, Windsurf, Qoder...) tự động kích hoạt Bước 0 và tuân thủ luật chống trùng lặp ngay khi mở thư mục dự án.
  2. **Thiết lập Luật "Zero-Duplication" (Tiết kiệm ~80% Token):**
     - **`PROJECT_STATE.md`**: Xóa bỏ mục `Recent Activity` theo giờ (vì trùng lặp với `AGENT_CHAT.md`). Quy định mỗi task chỉ ghi **đúng 1 dòng** trong bảng.
     - **`AGENT_CHAT.md`**: Chuyển từ "nhật ký dài dòng" sang **Bảng Bàn Giao Ca Trực (Rolling Handoff Board)**. Giới hạn mỗi tin nhắn **3 – 7 dòng**, cấm copy-paste lại bài phân tích lỗi đã có trong `ISSUE_LOG.md` (chỉ dẫn chiếu mã `BUG-xxx`). Thêm cơ chế **Rolling Window**: chỉ giữ **5 – 8 tin bàn giao gần nhất**, tự động dọn tin `@done` cũ ở cuối file.
     - **`ISSUE_LOG.md`**: Bổ sung **Bảng Tra Cứu Nhanh (Quick Index)** ở ngay đầu file để ở Bước 0 các Agent đọc lướt trong 5 giây thay vì đọc toàn bộ chi tiết lỗi cũ.
  3. **Bổ sung Cơ chế Khóa Task Bước 1 (`Task Lock`) & Tag `@handoff`:**
     - Cập nhật `QUY_TRINH.md` và `GOVERNANCE.md`: Bắt buộc Agent khi nhận việc ở Bước 1 phải ghi ngay trạng thái `🟡 In Progress` vào `PROJECT_STATE.md` trước khi sửa code để chống trùng việc.
     - Thêm tag `@handoff` trong `AGENT_CHAT.md` phục vụ việc dừng phiên giữa chừng hoặc chuyển đổi từ IDE này sang IDE khác làm tiếp.
  4. **Đồng bộ hóa tài liệu:**
     - Sửa các điểm lệch giữa `README.md`, `QUY_TRINH.md` (chuẩn hóa 6 bước từ Bước 0 → Bước 5) và `GOVERNANCE.md`.

---

### [v1.0.0] - 2026-05-08
- **Thực hiện bởi:** jimmyvu & AI Team (Claude · Gemini · Codex)
- **Mục tiêu:** Phát hành phiên bản đầu tiên của **Agent Collaborator Kit** — hệ thống bộ nhớ chung bằng Markdown cho AI Teams.
- **Chi tiết các thành phần khởi tạo:**
  - `SOUL.md`: Template định nghĩa danh tính, mục tiêu và kiến trúc dự án.
  - `PROJECT_STATE.md`: Template theo dõi trạng thái dự án và danh sách task.
  - `AGENT_CHAT.md`: Kênh giao tiếp giữa các agents (`@assign`, `@help`, `@done`).
  - `ISSUE_LOG.md`: Nhật ký ghi nhận lỗi kỹ thuật để tránh lặp lại.
  - `GOVERNANCE.md`: Quy tắc phân quyền sửa file, git rules, approval levels & emergency protocol.
  - `QUY_TRINH.md`: Quy trình làm việc chuẩn theo từng phiên (Session).
  - `PROJECT_SETUP_CHECKLIST.md`: Bộ 21 câu hỏi khởi tạo dự án mới.
  - `SCREENSHOTS.md`: Quy chuẩn lưu trữ ảnh chụp màn hình bằng chứng lỗi.
  - `docs/banner.png` & `docs/workflow.png`: Minh họa trực quan hệ thống.

---

*CHANGELOG.md — Mọi Agent khi nâng cấp bộ Kit gốc này vui lòng ghi tiếp phiên bản mới lên đầu danh sách.*

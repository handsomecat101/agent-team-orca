# AGENTS.md - Quy Tắc Cộng Tác Đa Agent & Đa IDE (Auto-Boot)

> File này giúp mọi AI Agent (Antigravity, Claude Code, Cursor, Codex, OpenCode, Windsurf, Qoder...) tự động nắm bắt context dự án ngay khi mở thư mục mà không cần người dùng copy-paste câu lệnh nhắc nhở.

---

## 🚀 1. BƯỚC KHỞI ĐỘNG BẮT BUỘC (Mỗi Phiên Mới / Đổi IDE)

Trước khi thực hiện bất kỳ yêu cầu code/sửa lỗi nào, bạn **BẮT BUỘC** đọc nhanh 4 file sau theo đúng thứ tự:

1. `SOUL.md` — Hiểu kiến trúc, tech stack, domain/port và các quy tắc bất biến của dự án.
2. `PROJECT_STATE.md` — Xem tiến độ hiện tại, bản build mới nhất, task nào đang làm/đang chờ.
3. `AGENT_CHAT.md` — Đọc các tin bàn giao gần nhất để biết Agent ở phiên/IDE trước vừa sửa file nào và cần làm gì tiếp.
4. `ISSUE_LOG.md` — Đọc **Bảng Tra Cứu Nhanh (Quick Index)** ở đầu file để tránh lặp lại các lỗi cũ.

---

## 🔒 2. QUY TRÌNH TRONG VÀ SAU KHI LÀM VIỆC

1. **Nhận Task (Bước 1):** Ghi ngay task đang nhận vào mục `Task Đang Làm (🟡 In Progress)` trong `PROJECT_STATE.md` để khóa task, tránh Agent ở IDE khác làm trùng.
2. **Phân quyền:** Kiểm tra `GOVERNANCE.md` nếu dự án có giới hạn quyền sửa file giữa các Agent.
3. **Bàn giao sau khi xong (Bước 4):**
   - Cập nhật `PROJECT_STATE.md` (chuyển task sang `Task Hoàn Thành` - **1 dòng ngắn gọn**).
   - Ghi 1 tin nhắn bàn giao ngắn (`@done` hoặc `@handoff` nếu dừng giữa chừng) vào đầu `AGENT_CHAT.md`.
   - Nếu phát hiện/xử lý bug có bài học kỹ thuật mới: ghi vào `ISSUE_LOG.md` (cập nhật cả bảng Quick Index ở đầu file).

---

## ✂️ 3. QUY TẮC CHỐNG PHÌNH TO & CHỐNG TRÙNG LẶP (TIẾT KIỆM TOKEN)

Để các Agent ở mọi IDE luôn đọc context nhanh nhất và không tốn token vô ích, **TUYỆT ĐỐI TUÂN THỦ**:

- **Mỗi thông tin chỉ nằm ở ĐÚNG 1 NƠI:**
  - Chi tiết nguyên nhân & cách sửa bug **chỉ ghi ở `ISSUE_LOG.md`**.
  - Trong `AGENT_CHAT.md`, mỗi tin nhắn chỉ dài **tối đa 3 – 7 dòng** (chỉ ghi tóm tắt việc vừa làm, danh sách file đã sửa, và dẫn chiếu mã `BUG-xxx` nếu có — **CẤM copy-paste lại bài phân tích dài dòng sang `AGENT_CHAT.md`**).
  - Trong `PROJECT_STATE.md`, mỗi task hoàn thành chỉ ghi **1 dòng** (không viết nhật ký chi tiết theo giờ vào đây).
- **Tự động dọn gọn `AGENT_CHAT.md`:** Chỉ giữ lại **5 – 8 tin nhắn bàn giao gần nhất** trong `AGENT_CHAT.md`. Khi thêm tin mới mà tổng số tin vượt quá 8, hãy chủ động xóa bớt các tin `@done` cũ ở cuối file (vì lịch sử task đã nằm trong `PROJECT_STATE.md`).

---

## 🧭 4. NẾU BẠN ĐƯỢC GIAO VAI ĐIỀU PHỐI (LEADER) — Orca Edition

Dự án dùng nhiều agent do **một leader điều phối qua Orca**. Nếu PO giao bạn vai điều phối:
- Đọc **`LEADER_NOTES.md` mục 0** ngay sau 4 file boot ở trên — trong đó có: môi trường Orca và skill cần nạp, cách tiếp quản đội đang chạy, vòng giao việc → chờ → kiểm chứng → commit, cách PO muốn làm việc, công cụ trong `tools/`.
- Thợ (worker) **không** cần đọc `LEADER_NOTES.md` — thợ làm theo spec leader giao (spec có sẵn hướng dẫn báo `worker_done`).

---

## 🛠️ 5. LƯU Ý RIÊNG KHI NÂNG CẤP BỘ KIT (repo này)

Nếu bạn được giao nhiệm vụ **nâng cấp chính bộ template `agent-team` này** (chứ không phải đang làm một dự án con):
- Đọc `CHANGELOG.md` trước khi sửa để nắm lịch sử các phiên bản (`v1.0.0` → `v1.1.0`).
- Giữ `SOUL.md`, `PROJECT_STATE.md`, `AGENT_CHAT.md`, `ISSUE_LOG.md` ở trạng thái **Template sạch** (không ghi dữ liệu của dự án riêng lên repo gốc).
- Sau khi nâng cấp quy trình, **bắt buộc ghi rõ ngày, tên Agent và chi tiết thay đổi vào đầu file `CHANGELOG.md`**.


# QUY_TRINH.md - Quy Trình Làm Việc Đa Agent & Đa IDE

> **6 bước chuẩn** để hoàn thành một task — TẤT CẢ agents trên mọi IDE đều phải tuân theo.

---

## ⚠️ QUAN TRỌNG: Thế nào là 1 PHIÊN (Session)?

**1 PHIÊN = Mỗi khi bạn:**
- 🆕 Mở IDE / CLI mới (Antigravity, Claude Code, Cursor, Codex, OpenCode, Windsurf...)
- 🔀 Chuyển từ IDE này sang IDE khác trên cùng dự án
- 🔄 Refresh hoặc mở cửa sổ/tab mới
- 💻 Tắt máy tính rồi bật lại

**→ Mỗi khi bắt đầu PHIÊN MỚI → PHẢI CHẠY BƯỚC 0 (ĐỌC CONTEXT)!**
*(Nếu dự án đã có file `AGENTS.md` ở thư mục gốc, các IDE hiện đại sẽ tự động kích hoạt Bước 0).*

---

## 📋 Tổng Quan 6 Bước

```
┌─────────────────────────────────────────────────────────────────┐
│                    6 BƯỚC LÀM VIỆC CHUẨN                        │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 0: KHỞI ĐỘNG      ⏱️ 1-2 phút (MỖI PHIÊN MỚI / ĐỔI IDE) │
│  ─────────────────────────────────────────────                 │
│  □ Đọc SOUL.md (hiểu kiến trúc & quy tắc bất biến)             │
│  □ Đọc PROJECT_STATE.md (xem tiến độ & task đang mở)           │
│  □ Đọc AGENT_CHAT.md (đọc 5-8 tin bàn giao gần nhất)           │
│  □ Đọc ISSUE_LOG.md (đọc bảng Quick Index ở đầu file)          │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 1: NHẬN & KHÓA TASK ⏱️ 1 phút                            │
│  ─────────────────────────────────────────────                 │
│  □ Nhận task (Self-assign hoặc được assign)                    │
│  □ Ghi ngay vào mục "Task Đang Làm (🟡 In Progress)" trong     │
│    PROJECT_STATE.md để tránh Agent ở IDE khác làm trùng        │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 2: CHUẨN BỊ         ⏱️ 3-5 phút                          │
│  ─────────────────────────────────────────────                 │
│  □ Xác định files cần sửa & kiểm tra quyền trong GOVERNANCE.md │
│  □ Xem chi tiết lỗi liên quan trong ISSUE_LOG.md (nếu có)      │
│  □ Backup nếu can thiệp production                             │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 3: THỰC HIỆN        ⏱️ Tùy thuộc task                    │
│  ─────────────────────────────────────────────                 │
│  □ Code → Test locally → Deploy (nếu cần)                      │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 4: CẬP NHẬT GỌN     ⏱️ 2 phút (KHÔNG GHI TRÙNG LẶP!)     │
│  ─────────────────────────────────────────────                 │
│  □ PROJECT_STATE.md: Chuyển task sang Hoàn Thành (1 dòng)      │
│  □ AGENT_CHAT.md: Ghi bàn giao @done hoặc @handoff (3-7 dòng), │
│    xóa bớt tin cũ nếu vượt quá 8 tin nhắn                      │
│  □ ISSUE_LOG.md: Ghi lỗi kỹ thuật mới + cập nhật Quick Index   │
│  □ Git commit                                                  │
├─────────────────────────────────────────────────────────────────┤
│  BƯỚC 5: REVIEW (Nếu cần) ⏱️ 5 phút                            │
│  ─────────────────────────────────────────────                 │
│  □ Gửi cho Agent khác hoặc Human review → Fix feedback → DONE  │
└─────────────────────────────────────────────────────────────────┘
```

---

## ✂️ QUY TẮC VÀNG: CHỐNG TRÙNG LẶP & TIẾT KIỆM TOKEN

Khi nhiều Agent làm việc qua nhiều phiên, **tuyệt đối không chép cùng một nội dung vào cả 3 file**. Mỗi thông tin chỉ được phép nằm ở **ĐÚNG 1 NƠI**:

| Thông tin | Nơi ghi DUY NHẤT | Quy tắc độ dài |
|-----------|------------------|----------------|
| Kiến trúc, Tech Stack, Quy tắc cứng | `SOUL.md` | Cố định (~1.5 KB) |
| Tiến độ tổng quan & Danh sách Task | `PROJECT_STATE.md` | **1 dòng / task** (Không ghi nhật ký theo giờ vào đây) |
| Nguyên nhân gốc (Root Cause) & Cách fix bug | `ISSUE_LOG.md` | **5 – 8 dòng / bug** + 1 dòng ở bảng Quick Index đầu file |
| Tin nhắn bàn giao ca trực giữa các IDE | `AGENT_CHAT.md` | **3 – 7 dòng / tin**, chỉ giữ **5 – 8 tin gần nhất** |

> 🚫 **CẤM:** Đã ghi phân tích bug dài 20 dòng trong `ISSUE_LOG.md` rồi lại copy-paste y nguyên 20 dòng đó sang `AGENT_CHAT.md` và `PROJECT_STATE.md`! Trong `AGENT_CHAT.md` chỉ cần ghi: *"Đã fix `BUG-005` (chi tiết xem `ISSUE_LOG.md`), đã sửa file X, Y."*

---

## 🔍 Chi Tiết Từng Bước

### BƯỚC 0: KHỞI ĐỘNG (Mỗi Phiên Mới / Đổi IDE)

**Mục đích:** Nắm bắt 100% context dự án chỉ trong vài giây với lượng token tối thiểu.

```
1. Đọc SOUL.md          → Nắm kiến trúc, tech stack, domain/port cố định
2. Đọc PROJECT_STATE.md → Xem bản build hiện tại, ai đang làm task gì
3. Đọc AGENT_CHAT.md    → Xem Agent ở IDE trước vừa bàn giao gì
4. Đọc ISSUE_LOG.md     → Đọc bảng Quick Index ở đầu file để tránh bẫy cũ
```

**Checklist:**
- [ ] Đã đọc đủ 4 file cốt lõi (`SOUL`, `PROJECT_STATE`, `AGENT_CHAT`, `ISSUE_LOG`)
- [ ] Nắm rõ trạng thái hiện tại trước khi bắt tay vào việc

---

### BƯỚC 1: NHẬN & KHÓA TASK (Task Lock)

**Mục đích:** Tránh 2 Agent ở 2 IDE khác nhau vô tình làm trùng cùng một việc.

```
1. Xác định task cần làm từ User, AGENT_CHAT.md hoặc PROJECT_STATE.md
2. KHÓA TASK NGAY:
   → Mở PROJECT_STATE.md
   → Đưa task vào bảng "🟡 Task Đang Làm (In Progress)" kèm tên Agent
```

**Checklist:**
- [ ] Đã xác định rõ task và files liên quan
- [ ] Đã ghi `🟡 In Progress` vào `PROJECT_STATE.md` trước khi sửa code

---

### BƯỚC 2: CHUẨN BỊ

**Mục đích:** Kiểm tra quyền hạn và bài học từ lỗi cũ trước khi sửa code.

```
1. Xác định danh sách files sẽ sửa
2. Kiểm tra GOVERNANCE.md (nếu dự án chia quyền sửa file theo Role)
3. Nếu task liên quan đến lỗi từng gặp ở bảng Quick Index của ISSUE_LOG.md:
   → Đọc kỹ mục chi tiết của lỗi đó bên dưới để không làm tái phát lỗi
4. Backup hoặc tạo branch nếu can thiệp vào dữ liệu/hệ thống Production
```

---

### BƯỚC 3: THỰC HIỆN

```
1. Đọc code liên quan & thực hiện thay đổi
2. Chạy kiểm tra tĩnh (lint/analyze) và test locally
3. Build / Deploy (nếu được yêu cầu) và verify kết quả thực tế
```

---

### BƯỚC 4: CẬP NHẬT GỌN (Bàn Giao Ca Trực)

**Mục đích:** Để bất kỳ Agent nào ở IDE khác mở dự án lên sau đó đều hiểu ngay bạn vừa làm gì mà không tốn nhiều token đọc.

```
1. Cập nhật PROJECT_STATE.md:
   → Nếu xong: Chuyển task từ "Đang Làm" xuống "Task Hoàn Thành" (chỉ ghi 1 dòng)
   → Nếu dừng giữa chừng: Giữ ở "Đang Làm" và ghi chú tiến độ (ví dụ: 60%)

2. Ghi vào đầu AGENT_CHAT.md (Tối đa 3 - 7 dòng):
   → Dùng @done (nếu đã xong) hoặc @handoff (nếu bàn giao làm tiếp trên IDE khác)
   → Liệt kê: Tóm tắt 1 câu + Files đã sửa + Trạng thái test/deploy + Việc tiếp theo
   → DỌN GỌN: Nếu AGENT_CHAT.md có quá 8 tin nhắn, xóa bớt các tin @done cũ ở cuối file

3. Cập nhật ISSUE_LOG.md (CHỈ KHI CÓ BUG KỸ THUẬT MỚI):
   → Thêm 1 dòng vào "Bảng Tra Cứu Nhanh (Quick Index)" ở đầu file
   → Ghi ngắn gọn Nguyên nhân gốc & Cách fix ở phần chi tiết (5-8 dòng)

4. Git commit (nếu được yêu cầu)
```

---

### BƯỚC 5: REVIEW (Nếu Cần)

```
1. Gửi yêu cầu review qua AGENT_CHAT.md (@assign → Reviewer) hoặc báo Human
2. Xử lý feedback (nếu có) → Hoàn tất ✅ DONE
```

---

## 💡 Ví Dụ Bàn Giao Chuẩn (Ngắn Gọn & Đủ Ý)

Khi sửa xong lỗi `BUG-005`, thay vì viết bài báo cáo 40 dòng vào cả 3 file, hãy ghi chuẩn như sau:

**1. Trong `PROJECT_STATE.md` (Bảng Task Hoàn Thành — đúng 1 dòng):**
```markdown
| 008 | Fix lỗi OTA Installer & UI Overflow (`BUG-005`) | Antigravity | 2026-09-15 | Release Android v2.5.2 (Build 36) lên R2 |
```

**2. Trong `AGENT_CHAT.md` (Tin bàn giao ở đầu file — đúng 5 dòng):**
```markdown
### 2026-09-15 14:20 - Antigravity
- **Loại:** `@done`
- **Tóm tắt:** Đã fix dứt điểm lỗi bấm Cập nhật ngay bị tự đóng dialog (`BUG-005` — chi tiết xem `ISSUE_LOG.md`).
- **Files đã sửa:** `MainActivity.kt`, `update_service.dart`, `update_dialog.dart`, `worker/index.js`
- **Verify/Deploy:** Pass `dart analyze`, đã build & đẩy APK `v2.5.2+36` lên R2 + Worker live.
- **Việc tiếp theo:** Sẵn sàng nhận task mới hoặc kiểm tra thêm thanh cuộn Timeline.
```

**3. Trong `ISSUE_LOG.md` (Lưu bài học kỹ thuật lâu dài):**
- Thêm 1 dòng vào bảng **Quick Index** ở đầu file.
- Ghi nguyên nhân gốc + cách fix ngắn gọn ở phần chi tiết bên dưới.

---

*QUY_TRINH.md — Phiên bản v1.1: Tối ưu Đa IDE, Khóa Task Bước 1 & Chống Trùng Lặp Token.*

# GOVERNANCE.md - Luật & Quy Tắc Phối Hợp

> Quy tắc chung mà TẤT CẢ agents trên mọi IDE phải tuân theo.

---

## 1. Quy Tắc Chung

### 1.1 Trước Khi Bắt Đầu (Bước 0 - Mỗi Phiên Mới / Đổi IDE)

| Thứ tự | Action | Lưu ý tiết kiệm Token |
|--------|--------|-----------------------|
| 1 | Đọc `SOUL.md` | Hiểu kiến trúc, tech stack và quy tắc bất biến của dự án |
| 2 | Đọc `PROJECT_STATE.md` | Xem bảng trạng thái task hiện tại |
| 3 | Đọc `AGENT_CHAT.md` | Đọc 5–8 tin bàn giao gần nhất từ phiên/IDE trước |
| 4 | Đọc `ISSUE_LOG.md` | Đọc **Bảng Tra Cứu Nhanh (Quick Index)** ở đầu file để tránh lặp lại lỗi cũ |

### 1.2 Trong Khi Làm Việc

- ✅ **Khóa task ngay khi nhận (Bước 1):** Ghi `🟡 In Progress` vào `PROJECT_STATE.md` trước khi sửa code.
- ✅ **Chỉ sửa file trong phạm vi nhiệm vụ** (hoặc theo bảng Agent Roles bên dưới).
- ✅ **Test trước khi deploy / bàn giao.**
- ✅ **Backup trước khi can thiệp production.**

- ❌ **Không sửa đè file Agent khác đang khóa (`🟡 In Progress`).**
- ❌ **Không deploy code chưa test.**
- ❌ **Không xóa dữ liệu production khi chưa backup & xin phép.**

### 1.3 Sau Khi Xong (Quy Tắc Bàn Giao Chống Trùng Lặp)

- ✅ **Cập nhật `PROJECT_STATE.md`:** Chuyển task sang `Task Hoàn Thành` (**chỉ ghi 1 dòng ngắn gọn**, không viết nhật ký chi tiết theo giờ vào đây).
- ✅ **Ghi bàn giao vào `AGENT_CHAT.md`:** Viết **tối đa 3 – 7 dòng** (`@done` hoặc `@handoff` nếu dừng giữa chừng để đổi IDE). Tự động xóa bớt tin `@done` cũ ở cuối file nếu tổng số tin vượt quá 8.
- ✅ **Ghi `ISSUE_LOG.md` (nếu có bug kỹ thuật mới):** Cập nhật bảng Quick Index ở đầu file và ghi nguyên nhân gốc + cách fix ngắn gọn (5–8 dòng). **Tuyệt đối không copy-paste lại đoạn phân tích lỗi này sang `AGENT_CHAT.md`.**
- ✅ **Git commit** với message rõ ràng (khi được yêu cầu).

---

## 2. Agent Roles & Constraints (Tùy chọn theo Dự án)

> Nếu bạn làm việc theo kiểu **tuần tự từng IDE** (lúc mở Claude Code, lúc mở Antigravity/Cursor/Codex), Agent đang trực ca được quyền sửa các file thuộc task được giao. Nếu chia nhiều Agent chuyên biệt chạy song song, hãy phân ranh giới tại bảng dưới:

| Agent | Vai trò | Được phép sửa | KHÔNG được sửa |
|-------|---------|---------------|-----------------|
| **Claude** | Bug fixes, Logic, Backend | `*.js`, `*.ts`, `*.py`, `*.dart`, `*.md` | File của Agent khác đang lock |
| **Gemini / Antigravity** | Full-stack, UI/UX, Architecture | Theo task được giao | File của Agent khác đang lock |
| **Codex / Cursor** | Review, Optimization, Feature | Theo task được giao | File của Agent khác đang lock |
| **Human** | Product Owner, Review, Approve | **Tất cả** | - |

### Khi Cần Sửa File Ngoài Phạm Vi
1. **Báo trước** trong `AGENT_CHAT.md` hoặc hỏi trực tiếp Human.
2. **Chờ đồng ý** rồi mới thực hiện.

---

## 3. Git Rules

### 3.1 Khi Nào Commit
| Action | Khi nào commit |
|--------|----------------|
| Fix bug / Feature | Sau khi test / analyze pass 0 lỗi |
| Deploy code | Ngay sau khi deploy và verify thành công |

### 3.2 Commit Message Format
```
[PREFIX]: [Mô tả ngắn gọn]

Ví dụ:
- Fix: login redirect after authentication
- Feat: add multi-device sync selector
- UI: update timeline scrubber pill
- Docs: update PROJECT_STATE and AGENT_CHAT
```

---

## 4. Communication Rules (Giao Tiếp Giữa Các IDE)

### 4.1 Phân Vai Rõ Ràng Giữa Các File (Zero-Duplication)

| File | Mục đích DUY NHẤT | Giới hạn độ dài |
|------|-------------------|-----------------|
| **`SOUL.md`** | Kiến trúc, Tech Stack, Ràng buộc cố định | ~50–80 dòng |
| **`PROJECT_STATE.md`** | Bảng Dashboard trạng thái các Task | 1 dòng / task |
| **`AGENT_CHAT.md`** | Bảng tin bàn giao ca trực (giữ 5–8 tin mới nhất) | 3–7 dòng / tin |
| **`ISSUE_LOG.md`** | Bảng Quick Index + Nguyên nhân gốc & cách fix lỗi | 5–8 dòng / lỗi |
| **`SCREENSHOTS/`** | Lưu ảnh chụp màn hình bằng chứng lỗi (nếu có) | Theo ngày |

### 4.2 Các Tag Giao Tiếp Trong `AGENT_CHAT.md`

- **`@done`**: Báo hoàn thành task trong ca trực (ghi tóm tắt + files đã sửa).
- **`@handoff`**: Đang làm dở cần dừng phiên hoặc chuyển sang IDE khác làm tiếp (ghi rõ đã làm đến đâu, file nào cần sửa tiếp).
- **`@assign → [Agent]`**: Giao việc cụ thể cho Agent tiếp theo.
- **`@help`**: Gặp vướng mắc cần Agent khác hoặc Human hỗ trợ.
- **`@approve`**: Xin phê duyệt thay đổi quan trọng trên Production.

---

## 5. Approval Levels & Production Safety

| Level | Khi nào | Action |
|-------|---------|--------|
| **INFO** | Thay đổi nhỏ, sửa bug thông thường | Tự thực hiện & ghi bàn giao |
| **CONFIRM** | Thay đổi cấu trúc lớn hoặc ảnh hưởng diện rộng | Hỏi xác nhận trước khi làm |
| **APPROVE** | Xóa dữ liệu hoặc thay đổi nhạy cảm trên Production | **BẮT BUỘC** chờ Human duyệt |
| **ESCALATE** | Phát hiện nguy cơ mất dữ liệu hoặc lỗi nghiêm trọng | Dừng ngay lập tức, báo Human |

---

*GOVERNANCE.md — Giữ kỷ luật chung để mọi Agent từ mọi IDE phối hợp mượt mà, không trùng lặp.*

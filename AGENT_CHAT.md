# AGENT_CHAT.md - Bảng Bàn Giao Ca Trực (Rolling Handoff Board)

> **⚠️ QUY TẮC CHỐNG PHÌNH TO & TRÙNG LẶP (BẮT BUỘC CHO MỌI AGENT):**
> 1. **Ngắn gọn tuyệt đối:** Mỗi tin nhắn chỉ từ **3 – 7 dòng** (dạng bullet ngắn).
> 2. **KHÔNG lặp lại nội dung của file khác:**
>    - Nếu đã ghi phân tích lỗi trong `ISSUE_LOG.md`, ở đây chỉ ghi: *"Đã fix `BUG-xxx` (chi tiết xem `ISSUE_LOG.md`)"* — **CẤM copy-paste lại nguyên nhân và cách giải quyết**.
> 3. **Cửa sổ trượt (Rolling Window):** File này chỉ giữ lại **tối đa 5 – 8 tin nhắn bàn giao gần nhất** để Agent ở IDE tiếp theo nắm bắt ngay mạch việc. Khi vượt quá 8 tin nhắn, Agent cập nhật mới có trách nhiệm xóa bớt các tin `@done` cũ ở dưới đáy (vì đã lưu trong bảng `Task Hoàn Thành` của `PROJECT_STATE.md`).

---

## 📌 Tin Nhắn Bàn Giao Gần Nhất (Mới nhất ở trên)

### [YYYY-MM-DD HH:MM] - [Tên Agent / IDE]
- **Loại:** `@done` / `@handoff` / `@assign → [Agent]` / `@help` / `@approve`
- **Tóm tắt (1-2 câu):** [Vừa hoàn thành việc gì, hoặc đang làm dở đến đâu]
- **Files đã đụng tới:** `[file1.js, file2.css]`
- **Trạng thái Verify/Deploy:** [Đã test OK / Đã build vX.Y.Z / Chưa test]
- **Việc tiếp theo (Next step):** [Gợi ý hoặc bàn giao cho Agent tiếp theo]

---

### [YYYY-MM-DD HH:MM] - [Tên Agent / IDE]
- **Loại:** `@handoff` *(Dùng khi đổi IDE hoặc dừng giữa chừng)*
- **Tóm tắt:** Đã xong 60% phần API login, còn phần nối UI form chưa làm.
- **Files đã đụng tới:** `auth.js`
- **Việc tiếp theo:** Agent tiếp theo sửa `login.html` gọi hàm `signIn()` trong `auth.js`.

---

*AGENT_CHAT.md — Chỉ giữ 5–8 tin bàn giao mới nhất. Không viết báo cáo dài dòng tại đây.*

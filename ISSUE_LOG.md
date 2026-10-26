# ISSUE_LOG.md - Sổ Tay Miễn Dịch Lỗi Kỹ Thuật

> **QUY TẮC GHI LỖI TIẾT KIỆM TOKEN (BẮT BUỘC):**
> 1. **Khi khởi động (Bước 0):** Agent chỉ cần đọc **Bảng Tra Cứu Nhanh (Quick Index)** ở ngay đầu file để nắm toàn bộ các "bẫy" của dự án trong 5 giây. Chỉ đọc xuống phần chi tiết khi làm việc đụng tới file hoặc lỗi liên quan.
> 2. **Chỉ ghi lỗi có bài học kỹ thuật:** Ghi ngắn gọn **5 – 8 dòng/lỗi** (Triệu chứng → Nguyên nhân gốc → Cách fix & Quy tắc tránh lặp lại).
> 3. **Không chép lặp sang `AGENT_CHAT.md`:** Chi tiết kỹ thuật của lỗi chỉ nằm duy nhất tại file này.

---

## ⚡ Bảng Tra Cứu Nhanh (Quick Index)

| ID | Lỗi / Triệu chứng ngắn | File liên quan | Quy tắc tránh lặp lại (1 câu) | Status |
|----|------------------------|----------------|-------------------------------|--------|
| `BUG-001` | [Ví dụ: Lỗi redirect sau login] | `auth.js` | Luôn chờ token lưu xong mới gọi `location.href` | ✅ Fixed |

---

## 🔍 Chi Tiết Các Lỗi (Mới nhất ở trên)

### [BUG-001] [Tên lỗi ngắn gọn]
- **Ngày:** [YYYY-MM-DD] | **Fix bởi:** [Agent] | **Status:** 🔴 Open / 🟡 Fixing / ✅ Fixed
- **File:** `[Tên file]` | **Screenshot (nếu có):** `SCREENSHOTS/...`
- **Nguyên nhân gốc (Root Cause):** [1-2 câu ngắn gọn chỉ thẳng nguyên nhân]
- **Cách fix & Bài học:** [1-3 gạch đầu dòng ngắn gọn cách đã xử lý và điều cấm làm để không tái phát]

---

*ISSUE_LOG.md — Luôn cập nhật Bảng Tra Cứu Nhanh ở đầu file mỗi khi thêm lỗi mới.*

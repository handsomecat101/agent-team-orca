# PROJECT_STATE.md - Bảng Trạng Thái Dự Án (Dashboard)

> **QUY TẮC TIẾT KIỆM TOKEN (BẮT BUỘC):**
> 1. File này **CHỈ chứa bảng trạng thái tổng quan** (mỗi task 1 dòng ngắn gọn).
> 2. **TUYỆT ĐỐI KHÔNG** viết nhật ký chi tiết theo giờ (`Recent Activity`) hay phân tích lỗi dài dòng vào đây (tránh trùng lặp với `AGENT_CHAT.md` và `ISSUE_LOG.md`).
> 3. **Khóa Task ngay ở Bước 1:** Khi bắt đầu làm task nào, phải chuyển ngay task đó sang mục `Task Đang Làm` (`🟡 In Progress`) trước khi sửa code.

---

## Project Info

| Field | Value |
|-------|-------|
| **Project Name** | [Tên project] |
| **Ngày bắt đầu** | [YYYY-MM-DD] |
| **Cập nhật gần nhất** | [YYYY-MM-DD] |
| **Trạng thái** | 🟡 Active / 🔴 Blocked / ✅ Completed |

## URLs & Endpoints (nếu có)

| Service | URL / Path |
|---------|------------|
| **Production** | [URL] |
| **Staging / Local** | [URL] |
| **Backend / Storage** | [URL / Bucket] |

---

## Thành Viên (Multi-IDE Agents)

| Agent / IDE | Vai trò chính | Status | Ghi chú |
|-------------|---------------|--------|---------|
| **[Agent 1]** | Backend, Logic, Bug fixes | 🟡 Active | |
| **[Agent 2]** | UI/UX, Frontend | ⚪ Available | |
| **[Agent 3]** | Review, Testing, Optimization | ⚪ Available | |
| **Human** | Product Owner, Approve, Review | 👤 Available | |

---

## 🟡 Task Đang Làm (In Progress - Lock)

| ID | Task | Agent | Priority | Status | Files đang sửa |
|----|------|-------|----------|--------|----------------|
| 001 | [Tên task ngắn gọn] | [Agent] | 🔴 HIGH | 🟡 In Progress | `file1.js` |

---

## ⏳ Task Chờ (Backlog / TODO)

| ID | Task | Agent dự kiến | Priority | Ghi chú ngắn |
|----|------|---------------|----------|--------------|
| 002 | [Tên task] | [Agent] | 🟡 MEDIUM | |
| 003 | [Tên task] | - | ⚪ LOW | Chưa assign |

---

## ✅ Task Hoàn Thành (1 dòng / task)

| ID | Task | Agent | Ngày xong | Kết quả / Version (1 câu ngắn) |
|----|------|-------|-----------|--------------------------------|
| 000 | Khởi tạo dự án | Human | [YYYY-MM-DD] | Setup cấu trúc cơ bản |

---

## 🔴 Blockers (Nếu có)

| Vấn đề đang chặn | Agent | Cần ai hỗ trợ | Tham chiếu |
|------------------|-------|---------------|------------|
| - | - | - | - |

---

*PROJECT_STATE.md — Luôn giữ ngắn gọn dưới 100 dòng để tối ưu context cho mọi IDE.*

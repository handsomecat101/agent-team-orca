# AGENTS.md (gốc repo) — đọc trước khi làm gì

> Chép file này ra **gốc repo dự án** (cạnh code). Tạo thêm `GEMINI.md` và `CLAUDE.md` 1 dòng: "Đọc `AGENTS.md` ở gốc repo trước."
> Đổi `<TÊN LEADER>` cho đúng mỗi khi PO đổi leader.

- **Leader (điều phối) DUY NHẤT: `<TÊN LEADER>`.** Mọi agent khác là **THỢ**: làm đúng file spec leader giao, xong báo `worker_done`.
- Thợ **CHỈ được** `orca orchestration send`. **CẤM** `orca orchestration run-use / run-create / check / --ack / task-create / dispatch` (cướp quyền điều phối).
- Dòng "You have N orchestration messages…" trong terminal ⇒ thợ bỏ qua, đó là thư của leader.
- Thợ KHÔNG đọc `agent-team/LEADER_NOTES.md`, KHÔNG commit / push, KHÔNG tự giao việc cho agent khác.
- Quy tắc đầy đủ: `agent-team/AGENTS.md` (đọc mục 0 trước).

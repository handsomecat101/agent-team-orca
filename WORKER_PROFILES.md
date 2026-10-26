# WORKER_PROFILES.md — Hồ sơ năng lực thợ (model) để leader chia việc

> **Ai đọc:** leader, khi chọn thợ cho một việc. **Có hạn dùng** — model ra bản mới vài tháng một lần.
> **Cập nhật:** mỗi quý hoặc khi đội có model mới ⇒ giao 1 thợ nghiên cứu (vd Gemini) tra lại bảng dưới **kèm link trang có số**, leader **tự kiểm 2–3 số quan trọng** trước khi ghi đè. Ghi ngày cập nhật ở dòng dưới.
>
> **Lần cập nhật gần nhất:** 2026-10-26 — Claude Code (Opus 5.5), đối chiếu qua tra web.

## Cách đọc số đúng

- Hầu hết là **số hãng tự công bố**, rất ít khi có bên thứ ba chạy lại ⇒ xem như **xu hướng**, không phải chân lý.
- Cùng tên benchmark nhưng **khác phiên bản / cách chấm** (vd OSWorld 2.0 vs 2.1, "partial" vs "strict"; Terminal-Bench 2.1 vs 4.0) ⇒ **không so chéo giữa các cột khác phiên bản**.
- Benchmark hữu ích nhất cho việc chia thợ:
  - **Việc dài hơi, nhiều bước, tự xoay xở** → Terminal-Bench (bản mới, khó), SWE-bench Pro / DeepSWE.
  - **Dùng máy tính / giao diện** → OSWorld.
  - **Thuật toán ngắn** → LiveCodeBench.

## Bảng tham khảo (2026-10)

| Model | Việc dài hơi / tự xoay xở | Dùng máy tính (OSWorld) | Ghi chú dùng thực tế |
|---|---|---|---|
| Claude Opus 5.5 | SWE-bench Pro 89,9 · Terminal-Bench 4.0 66,4% | 81,8% (partial) / 48,7% (strict) | Leader / thẩm mỹ UI. Đắt nhất |
| Claude Sonnet 5.5 | Terminal-Bench 4.0 70,6% | ~80% (partial) | Việc khó: kiến trúc, luồng trạng thái, hàng đợi. Rẻ hơn Opus |
| Gemini 3.8 Flash | Terminal-Bench 4.0 **19,1%** (2.1: ~90%) | 59,0% (2.0) | Rất nhanh, quota nhiều; nghiên cứu web, code việc **gọn**. Báo cáo phải soát nguồn |
| MiniMax M3.1 Flash | Terminal-Bench 4.0 38,1% | 61,7% (V2, hãng công bố) | Code theo spec, test; gói free có lúc chậm giờ cao điểm |
| DeepSeek V4.1 Flash | mạnh thuật toán ngắn | không công bố | Module gói gọn, test, thuật toán (OpenCode free) |

Nguồn đối chiếu (bên thứ hai, tổng hợp số hãng công bố): llm-stats.com · metricnexus.ai · benchlm.ai · apidog.com · datacamp.com · computingforgeeks.com · datalearner.com · aimlapi.com.

## Quy tắc chia việc rút ra

1. **Model Flash: việc gói gọn, đầu vào–đầu ra rõ** (1–2 file mới + test). Điểm việc dài hơi thấp ⇒ đừng giao "tự tìm hiểu cả hệ thống rồi sửa".
2. **Việc khó / quan trọng / nhiều trạng thái** ⇒ Claude Sonnet (hoặc model có Terminal-Bench bản mới cao).
3. **Kiểm thử giao diện:** thợ nào cũng chạy được **script CDP có sẵn**; phần **nhìn ảnh + đo đạc để kết luận** giữ ở leader (model mạnh).
4. **Nghiên cứu:** giao model tra web nhanh, nhưng leader soát nguồn.
5. Benchmark chỉ là điểm xuất phát — **ghi lại trải nghiệm thật** vào cột "Ghi chú dùng thực tế" (thợ nào hay lỗi gì, nhanh/chậm khi nào). Trải nghiệm thật đáng tin hơn bảng điểm.

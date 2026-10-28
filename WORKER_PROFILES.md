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

## Bảng benchmark chi tiết (MẪU — số dưới đây là VÍ DỤ đội Sublix 2026-10, thay bằng đội của bạn)

> Mỗi ô ghi **số + tên/phiên bản benchmark + nguồn** (vd "66,4% (Terminal-Bench 4.0)"). Không tìm thấy ⇒ ghi "(không tìm thấy)", **không đoán**. Hàng "Vai trò trong đội" và "Gói miễn phí" giúp leader chia việc theo **chi phí**, không chỉ theo điểm.

| Tiêu chí / Benchmark | <Model leader> | <Model thợ mạnh> | <Model thợ nhanh> | <Model thợ rẻ/free> |
|---|---|---|---|---|
| Hãng & ngày ra mắt | vd Anthropic (09/2026) | … | … | … |
| Vai trò trong đội | Điều phối / soát / thiết kế | Việc khó, kiến trúc | Nghiên cứu web, UI theo thiết kế | Module gói gọn, test |
| SWE-bench Pro / DeepSWE | vd 89,9% (SWE-bench Pro) | … | … | … |
| Terminal-Bench (ghi bản) | vd 66,4% (TB 4.0) | … | vd 90,8% (TB 2.1) / 19,1% (TB 4.0) | … |
| LiveCodeBench | … | … | … | … |
| OSWorld (ghi bản + partial/strict) | vd 81,8% partial / 48,7% strict | … | … | … |
| Web / Browser agent | … | … | … | … |
| Tốc độ (tok/s, **ghi rõ "ước tính"** nếu không có nguồn) | … | … | … | … |
| Giá API (input / output / 1M token) | … | … | … | … |
| Gói miễn phí / quota | ❌ / ⚠️ / ✅ + ghi chú | … | … | … |

## Đánh giá thực chiến (leader ghi sau MỖI việc — đáng tin hơn bảng điểm)

> 1 dòng / việc, ngắn. Sau vài đợt, đếm theo cột "Thợ" ⇒ biết thợ nào hợp loại việc nào. **Ghi cả lỗi bị bắt ở bước soát** (ai bắt: leader / designer duyệt / test) — đó là thước đo thật của chất lượng.

| Ngày | Việc (loại) | Thợ | Kết quả | Lỗi bị bắt khi soát (ai bắt) | Bài học chia việc |
|---|---|---|---|---|---|
| 2026-10-28 | Lõi thuần Rust + test (module mới) | OpenCode / DeepSeek Flash | ✅ 37 test, dữ liệu mẫu thật, tự phát hiện API bị chặn | để quên 1 file tạm ở gốc repo (leader) | Hợp module gói gọn có test |
| 2026-10-28 | UI theo mockup (tab mới, 25 file) | Gemini Flash | ✅ khớp thiết kế, nhanh | — | Hợp code UI khi đã có thiết kế + spec rõ |
| 2026-10-28 | UI theo mockup (tab con) | mcode / MiniMax Flash | ✅ chạy được, chậm (~20 phút) | 4 lỗi P1 (designer duyệt app thật) | Luôn cho designer duyệt ảnh app thật |
| 2026-10-28 | Nghiên cứu model mới nhất | Gemini Flash | ⚠️ 2 lần đưa model cũ dù đã dặn | ngày cập nhật không căn cứ (leader) | Spec nghiên cứu: bắt ghi ngày phát hành + link trang có số; leader kiểm 2–3 mục |

## Giao 1 thợ cập nhật benchmark (spec mẫu — leader chép, sửa tên model)

```
Việc: cập nhật bảng "Bảng benchmark chi tiết" trong WORKER_PROFILES.md cho các model: <danh sách model đội đang dùng + model mới định thêm>.
- CHỈ lấy nguồn MỚI NHẤT (≤ 6 tháng); mỗi số kèm: tên + PHIÊN BẢN benchmark, harness/chế độ (partial/strict, max mode…), ngày công bố, LINK TỚI ĐÚNG TRANG CÓ SỐ (không phải trang chủ).
- Phân biệt số hãng tự công bố vs bên thứ ba chạy lại. Không tìm thấy ⇒ "(không tìm thấy)".
- Không so chéo cột khác phiên bản benchmark. Giá + gói miễn phí lấy từ trang giá chính thức, ghi ngày xem.
- Chỉ sửa WORKER_PROFILES.md (2 mục: bảng chi tiết + dòng "Lần cập nhật gần nhất"). Không xoá mục "Đánh giá thực chiến".
```
Leader **tự kiểm 2–3 số quan trọng** (mở đúng link) trước khi commit — thợ nghiên cứu từng bịa link / nhầm cột.

## Quy tắc chia việc rút ra

1. **Model Flash: việc gói gọn, đầu vào–đầu ra rõ** (1–2 file mới + test). Điểm việc dài hơi thấp ⇒ đừng giao "tự tìm hiểu cả hệ thống rồi sửa".
2. **Việc khó / quan trọng / nhiều trạng thái** ⇒ Claude Sonnet (hoặc model có Terminal-Bench bản mới cao).
3. **Kiểm thử giao diện:** thợ nào cũng chạy được **script CDP có sẵn**; phần **nhìn ảnh + đo đạc để kết luận** giữ ở leader (model mạnh).
4. **Nghiên cứu:** giao model tra web nhanh, nhưng leader soát nguồn.
5. Benchmark chỉ là điểm xuất phát — **ghi trải nghiệm thật vào bảng "Đánh giá thực chiến"** sau mỗi việc, rồi tóm vào cột "Ghi chú dùng thực tế" của bảng tham khảo. Trải nghiệm thật đáng tin hơn bảng điểm.

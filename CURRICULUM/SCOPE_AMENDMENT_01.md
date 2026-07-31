# SCOPE AMENDMENT 01 — Thêm nhánh GMO/NGT
**Ngày ban hành / Issue date:** 2026-07-31
**Sửa đổi cho / Amends:** `02_SCOPE_LOCKED.md` (chốt 2026-07-27) và `03_FINAL_ROADMAP.md`
**Người phê duyệt / Approved by:** Học viên (chủ dự án)
**Trạng thái:** ĐÃ DUYỆT / APPROVED

---

## 1. Lý do sửa đổi / Reason for change

Học viên có **9 năm kinh nghiệm phòng thí nghiệm vi sinh và GMO**. Thông tin này
không có ở vòng chốt phạm vi 2026-07-27. Mảng GMO là lợi thế cạnh tranh mạnh hơn
mảng vi sinh đơn thuần, vì:

1. **Động lực quy định có ngày tháng cụ thể.** Regulation (EU) 2026/1388 về thực vật
   tạo bằng New Genomic Techniques (NGT) có hiệu lực 16/07/2026, **áp dụng từ
   17/07/2028**. Hai nhóm: Category 1 (tương đương lai tạo thông thường) và
   Category 2 (vẫn theo khung GMO).
2. **qPCR đụng trần kỹ thuật** ở bốn bài toán mà long-read giải được:
   unauthorised/unknown GMO, insertion site + flanking region, vector backbone
   carryover, phân biệt stack thật với hỗn hợp giống.
3. **Thị trường ngách gần như trống ở Việt Nam**, phù hợp cả ba mục tiêu nghề
   nghiệp của học viên: đưa NGS vào lab hiện tại, chuyển việc, nhận project freelance.

## 2. Nội dung sửa đổi / Change content

### 2.1. Module mới

| Mã | Tên | Giờ | Vị trí chèn |
|---|---|---|---|
| **M25A** | GMO detection landscape — vì sao qPCR đụng trần | 8 | GĐ VI, sau M18 |
| **M25B** | Đặc tả insert bằng ONT — adaptive sampling, mapping, SV calling | 20 | GĐ VI, sau M25A |
| **M25C** | NGT/gene-edited: giới hạn phân tích + hệ quả ISO 17025 | 12 | GĐ VIII, **sau M23** |
| | **Tổng thêm** | **40** | |

**Căn cứ vị trí:** M25B bắt buộc phụ thuộc **M13** (Clair3/Sniffles2, GĐ V) và
**M17D** (adaptive sampling, GĐ VI). M25C bắt buộc phụ thuộc **M22 + M23**
(quality management và ISO 17025, GĐ VIII).

### 2.2. Tác động lên tổng thể

| Chỉ tiêu | Trước | Sau |
|---|---|---|
| Applied (M0–M25) | 595 h | 635 h |
| Theory (T1–T8) | 122 h | 122 h |
| Theory hiện đại (T+1–T+6) | 70 h | 70 h |
| **TỔNG** | **787 h ≈ 20 tháng** | **827 h ≈ 21 tháng** |

### 2.3. Cột mốc mới

| Mốc | Khi nào | Tiêu chí |
|---|---|---|
| **D** | cuối GĐ VIII (~tháng 20) | Thiết kế được adaptive sampling panel cho một construct GMO và giải thích được **giới hạn phát hiện NGT Category 1** trước một khách hàng |

## 3. KHÔNG thay đổi / Unchanged

- Thứ tự toàn bộ module hiện có — **giữ nguyên tuyệt đối**
- Loại mẫu: thực phẩm, môi trường/nước, dược/mỹ phẩm/công nghiệp — **không lâm sàng**
- Workflow ưu tiên: isolate WGS; metagenomics vẫn ở cuối
- Tầng lý thuyết: Tầng 2 "Vững"
- Quy ước song ngữ, công nghệ nền 2026 (R10.4.1 / Kit 14 / Dorado / POD5)

## 4. Cảnh báo trung thực / Honest caveats — phải nhắc lại trong M25C

1. **Phát hiện NGT Category 1 về nguyên tắc là bài toán không giải được bằng phân
   tích.** Nếu một đột biến điểm do chỉnh sửa gen không phân biệt được với đột biến
   tự nhiên, **không phương pháp nào**, kể cả sequencing, xác định được nguồn gốc.
   Sequencing chỉ chuyển bài toán thành "cần biết trước trình tự + cần genome tham
   chiếu của giống gốc". Không được bán ảo tưởng cho khách hàng.
2. **Chưa có tiêu chuẩn ISO nào cho NGS trong GMO testing.** Bộ hiện hành vẫn là
   qPCR: ISO 24276, ISO 21569, ISO 21570, ISO 21571. Đi trước tiêu chuẩn là cơ hội
   **và** là rủi ro khi mở rộng phạm vi công nhận.
3. **Bộ gen thực vật lớn gấp 200–500 lần vi khuẩn** (ngô ~2,3 Gb, đậu tương ~1,1 Gb).
   Chiến lược đổi hẳn: **map-to-reference + SV calling**, KHÔNG phải de novo assembly
   như M11. Đây là kiến thức mới, không phải kiến thức cũ áp dụng sang.

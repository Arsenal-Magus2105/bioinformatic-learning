# Phạm vi giáo trình đã chốt / Curriculum Scope — LOCKED
Ngày chốt: 2026-07-27

## Quyết định của học viên / Learner decisions

| Câu hỏi | Trả lời | Hệ quả lên giáo trình |
|---|---|---|
| Loại mẫu | **Thực phẩm + Môi trường/nước + Dược phẩm/mỹ phẩm/công nghiệp** (KHÔNG lâm sàng) | Bỏ ISO 15189, bỏ clinical mNGS. **Thêm mảng GMP/pharma hoàn toàn mới** |
| Workflow ưu tiên | **WGS chủng phân lập (isolate WGS)** | M11→M12→M16→M14 là trục chính. M15 metagenomics lùi về sau |
| Thời gian có máy | **Chưa có, chưa rõ** | Học tuần tự 15 tháng, thực hành 100% trên **public ONT data** |
| Ngôn ngữ | **Song ngữ Việt–Anh** | Diễn giải tiếng Việt; thuật ngữ/lệnh/tên phần mềm/tiêu chuẩn giữ nguyên tiếng Anh |

## Quy ước song ngữ / Bilingual convention
- Văn xuôi, giải thích, lý luận → **tiếng Việt**
- Thuật ngữ kỹ thuật, tên tool, lệnh shell, định dạng file, tên tiêu chuẩn → **giữ nguyên tiếng Anh, không dịch**
- Khái niệm cốt lõi lần đầu xuất hiện → ghi cả hai: *độ bao phủ (coverage/depth)*
- Bảng, sơ đồ, checklist → tiêu đề song ngữ

---

## Nội dung MỚI thêm vào: mảng Dược phẩm / Mỹ phẩm / Công nghiệp

Đây là phần chưa có trong bản kế hoạch gốc. Nó có giá trị thương mại cao nhất
vì typing chủng để truy vết nguồn nhiễm là dịch vụ hiếm ở Việt Nam.

### Bối cảnh quy định / Regulatory context
| Tiêu chuẩn | Nội dung liên quan |
|---|---|
| **EU GMP Annex 1 (2022)** | Contamination Control Strategy (CCS) — yêu cầu hiểu **nguồn gốc** nhiễm, không chỉ đếm khuẩn lạc |
| **USP <1113>** | Microbial Characterization, Identification, and **Strain Typing** — nêu đích danh WGS |
| **USP <60>** | *Burkholderia cepacia* complex (BCC) — định danh đến loài trong complex, phenotype thường sai |
| **USP <61> / <62> / <71>** | Đếm vi sinh, vi sinh vật chỉ định (objectionable), thử vô khuẩn |
| **Ph. Eur. 5.1.6** | Phương pháp thay thế trong vi sinh dược phẩm |
| **21 CFR Part 11 + ALCOA+** | Toàn vẹn dữ liệu — ánh xạ 1:1 sang ISO 17025 §7.11 và pipeline validation |

### ALCOA+ ↔ Bioinformatics (dùng làm sợi chỉ xuyên suốt)
| ALCOA+ | Trong tin sinh học nghĩa là gì |
|---|---|
| **A**ttributable | Ai chạy lệnh nào, khi nào → logbook + git commit + user |
| **L**egible | Lệnh và tham số đọc được, không phải click chuột → script, không phải GUI |
| **C**ontemporaneous | Log ghi lúc chạy, không viết lại sau → stdout/stderr được lưu |
| **O**riginal | POD5/FASTQ gốc bất biến → `chmod -w`, checksum |
| **A**ccurate | Có control, có benchmark, có giới hạn phát hiện |
| **+ C**omplete | Không giấu lần chạy thất bại |
| **+ C**onsistent | Cùng input → cùng output → container + version pinning |
| **+ E**nduring | Lưu trữ dài hạn, đọc được sau 5 năm |
| **+ A**vailable | Truy xuất được khi thanh tra hỏi |

### Ứng dụng thực tế thêm vào các module
| Ứng dụng | Module | Vì sao ONT thắng phương pháp hiện tại |
|---|---|---|
| Định danh **BCC** đến loài | M12, M14 | Phenotype (Vitek/MALDI-TOF) không phân biệt được 20+ loài trong complex |
| Truy vết nguồn nhiễm **cleanroom** (EM isolates ↔ product isolate) | M14 | cgMLST/SNP cho biết *cùng chủng hay không*, PFGE không đủ phân giải |
| Điều tra **sterility test failure** | M11, M14 | Phân biệt nhiễm thật vs nhiễm từ thao tác |
| Hệ thống **nước tinh khiết / WFI** | M14, M15 | *Ralstonia pickettii*, *Burkholderia*, *Pseudomonas* — theo dõi biofilm theo thời gian |
| Kháng chất bảo quản / biocide (**qac** genes) | M16 | Gen `qacA/B`, `smr` nằm trên plasmid — chỉ long-read định vị được |
| Thẩm định chủng giống (**strain banking**) | M12, M22 | Xác nhận chủng chuẩn không trôi dạt qua các đời cấy chuyển |

---

## Bốn đồ án tốt nghiệp (đã sửa theo phạm vi mới) / Capstones

1. **Thực phẩm** — *Listeria monocytogenes* từ nhà máy RTE: closed genome → serogroup → cgMLST →
   AMR → liên kết ổ dịch. Chuẩn áp dụng: **ISO 23418:2022**.
2. **Môi trường / nước** — *Pseudomonas aeruginosa* hoặc *Ralstonia* trong hệ thống nước tinh khiết:
   truy vết nguồn qua nhiều điểm lấy mẫu và nhiều thời điểm.
3. **Dược / mỹ phẩm** — chủng **BCC** phân lập từ sản phẩm không vô khuẩn: định danh đến loài,
   so sánh với isolate từ environmental monitoring, quy kết nguồn nhiễm.
   Chuẩn áp dụng: **USP <60>, <1113>, EU GMP Annex 1 CCS**.
4. **Xuyên suốt** — AMR + plasmid: định vị gen kháng (carbapenemase hoặc **qac**) nằm trên
   plasmid hay chromosome. Đây là năng lực **chỉ long-read làm được**.

---

## Dữ liệu công khai để thực hành (vì chưa có máy) / Public ONT datasets

| Nguồn | Dùng cho module | Ghi chú |
|---|---|---|
| **EPI2ME Labs data index** (labs.epi2me.io/dataindex) | M7, M11, M17 | Dữ liệu ONT chính chủ, có cả POD5 |
| **ZymoBIOMICS mock community** D6300 / D6331 | M15, M22 | Có thành phần đã biết → dùng làm **reference material để thẩm định** |
| **Ryan Wick bacterial assembly benchmarks** (Zenodo/GitHub) | M11 | Bộ dữ liệu chuẩn cho Flye/Trycycler/Autocycler |
| **NCTC 3000 project** (Sanger) | M11, M12 | Chủng chuẩn NCTC có cả ONT + Illumina |
| **ENA / SRA** lọc `platform=OXFORD_NANOPORE` | mọi module | Tìm theo loài: Listeria, Salmonella, Pseudomonas, Burkholderia |
| **NCBI Pathogen Detection** | M14, M16 | Cây phát sinh loài + AMR có sẵn để đối chiếu kết quả của bạn |
| **ATCC / NCTC** chủng chuẩn | M22, M23 | Dùng khi có máy: vật liệu chuẩn để thẩm định phương pháp |

**Nguyên tắc:** mọi bài tập sẽ dùng dữ liệu tải được miễn phí. Khi có máy, bạn chạy lại
đúng các pipeline đó trên dữ liệu của mình — không phải học lại.

---

## Trình tự dạy đã chốt / Locked teaching order

| Giai đoạn | Tháng | Module | Cột mốc |
|---|---|---|---|
| I Nền tảng | 1–2 | **M2 Linux** → M1 → M3 | Máy Linux chạy được, wrangling text |
| II Dữ liệu | 3–4 | M5 → M6 → M7 → **M17A/B** → M4 | QC được một run ONT thật |
| III Lõi genomics | 5–8 | M10 → M8 → **M11** → M12 | **Đóng được 1 genome vi khuẩn từ ONT** ← mốc quan trọng nhất |
| IV Diễn giải | 8–11 | **M16** → M14 → M9 → M13 | Báo cáo AMR + cây truy vết nguồn nhiễm |
| V Nanopore | 11–12 | M17C–F → M18 | Hiểu và xử lý sự cố toàn bộ quy trình |
| VI Kỹ thuật | 12–13 | M19 → M20 → M21 | Pipeline có version, container, tự động |
| VII Chất lượng | 13–15 | M22 → **M23** | Hồ sơ thẩm định + ALCOA+ |
| VIII Metagenomics | 15–16 | **M15** | Lùi về cuối vì ưu tiên isolate WGS |
| IX Đồ án | 16+ | M24 | 4 đồ án ở trên |

Tổng ≈ **600 giờ ≈ 15–16 tháng** ở 9 giờ/tuần.

**Bước tiếp theo: Module 2 — Linux.**

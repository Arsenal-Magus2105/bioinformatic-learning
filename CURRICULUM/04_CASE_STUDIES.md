# 5 Case study Oxford Nanopore — số liệu và cách dùng trong giáo trình

**Lưu ý truy cập:** 3/5 trang là landing page, dữ liệu thật nằm trong PDF sau form tải.
Phần đánh dấu **[ONT]** lấy từ nội dung trang truy cập được.
Phần **[LIT]** lấy từ tài liệu bình duyệt để lấp chỗ trống — **hãy tải PDF gốc để có bản trích dẫn được.**

---

## CS1 · Virus — HBV và Astrovirus ✅ [ONT, đủ chi tiết]

**Link:** nanoporetech.com/…/combating-viral-contamination-and-disease-outbreaks-at-source-…

### HBV
- **148 mẫu** lâm sàng HBV dương tính; bộ gen ~**3,2 kb** vòng, 4 gen
- Thư viện: **multiplexed tiled PCR** toàn bộ bộ gen
- Thiết bị: **GridION**
- **96 mẫu có dữ liệu trong 14 giờ**
- **123/148** mẫu đạt **≥80%** độ phủ đồng đều ở **>2.300×**
- Kết quả: genotype A–J (HBV-A phổ biến nhất), phát hiện **tái tổ hợp A/D**,
  lập hồ sơ đột biến kháng thuốc và kháng vaccine

### Astrovirus trong nhuyễn thể
- **134 mẫu** nhuyễn thể vùng ven biển
- Làm giàu bằng **nested RT-PCR**
- **37 contig** AstV; phát hiện AstV chim (chủ yếu), dơi, bò sát; **không có AstV người**
- Diễn giải: tín hiệu **nhiễm phân / môi trường**

**Luận điểm:** long read phủ trọn amplicon RT-PCR → phân giải được **quần thể virus hỗn hợp**
mà Sanger không làm được.

### Dùng trong giáo trình
| Module | Vai trò |
|---|---|
| **M13** Variant calling | ★ case chủ đạo — gọi biến thể ở độ sâu rất cao |
| **M14** Phylogenetics | ★ genotyping, phát hiện tái tổ hợp |
| M5, M17C, M21 | database genotype, barcoding 96-plex, báo cáo |

**Giá trị riêng:** ca nhuyễn thể là **kiểm nghiệm thực phẩm và môi trường** — gần công việc
hiện tại của học viên nhất. 96 mẫu/14 giờ là mốc so sánh với PCR đang dùng.

---

## CS2 · MAG recovery từ microbiome phức tạp 🔒 [gated]

**Link:** …/oxford-nanopore-sequencing-provides-superior-metagenome-assembled-genome-recovery-…

Trang chỉ nêu: microbiome ruột người, so sánh ONT với nền tảng khác, dữ liệu benchmark trong PDF.

### [LIT] thay thế
- **PromethION**: 1 Tbp long-read + 0,9 Tbp short-read, 23 nhà máy xử lý nước thải →
  **1.083 MAG chất lượng cao, trong đó 57 bộ gen vòng khép kín**
  (Singleton et al., *Nat Commun* 2021 — nature.com/articles/s41467-021-22203-2)
- **Long-read-only**: **275 MAG**, trong đó **94 MAG chất lượng cao có operon rRNA đầy đủ** (~34%)
  (*Microbiome* 2022 — link.springer.com/article/10.1186/s40168-022-01415-8)
- **Hybrid** (long+short) thu **~2×** số MAG trung bình–cao so với Illumina-only
- **⚠ Bằng chứng ngược:** một nghiên cứu chuỗi thời gian: Illumina **57 MAG HQ** vs ONT **14**
  — nguyên nhân là **thiếu độ sâu** (pmc.ncbi.nlm.nih.gov/articles/PMC10182627)
- Đối chiếu: một nghiên cứu PacBio HiFi cho 31 MAG HQ, 10 vòng khép kín

### Dùng trong giáo trình
| Module | Vai trò |
|---|---|
| **M15** Metagenomics | ★ case chủ đạo |
| M11, M12 | metaFlye, annotation MAG |

**Giá trị dạy học đắt nhất:** đây là case duy nhất trong 5 bài mà **ONT có thể thua**.
Dùng để dạy tư duy phản biện và để viết phần "giới hạn phương pháp" trong hồ sơ thẩm định.
**Độ sâu là biến quyết định** — và đó cũng chính là lập luận cho thiết bị thông lượng cao.

---

## CS3 · WGS mầm bệnh thực phẩm 🔒 [gated]

**Link:** …/nanopore-whole-genome-sequencing-of-foodborne-pathogens

Trang chỉ xác nhận: **MinION/GridION**, MinION Flow Cell, nền tảng **EPI2ME**,
"closed microbial genome assemblies chỉ bằng nanopore read" nhờ cải tiến thuật toán
machine learning trong basecalling. Mọi số liệu nằm trong PDF.

### Dùng trong giáo trình
| Module | Vai trò |
|---|---|
| **M11** Assembly, **M16** AMR | ★ case chủ đạo |
| M12, M14, M19, M23 | annotation, typing, pipeline, ISO 23418:2022 |

**Xử lý:** khi ra bài tập, thay bằng dữ liệu công khai tương đương
(NCBI Pathogen Detection + ENA lọc `platform=OXFORD_NANOPORE`).

---

## CS4 · Genome vi khuẩn chất lượng cao, chi phí thấp, chỉ dùng nanopore ✅ [ONT + LIT mạnh]

**Link:** …/high-quality-low-cost-nanopore-only-bacterial-genome-sequences

### [ONT]
- **Kit 14 + R10.4.1**
- **40× coverage → genome gần hoàn thiện, KHÔNG cần polishing**
- Short-read polishing **không cải thiện đáng kể** chất lượng assembly
- *M. tuberculosis*: **>99,99% concordance** với Illumina cho SNV và indel, **151 cặp chủng**

### [ONT — benchmarking blog]
- **14 loài** Gram dương và Gram âm, R10.4.1 trên MinION/GridION
- Model: fast / hac / sup; simplex dùng cả ba, duplex dùng sup + hac
- **SUP + duplex → độ chính xác read trung vị 99,93% (Q32)**
- **7 variant caller** được đánh giá → **Clair3 và DeepVariant** cho F1 cao nhất
  (cả SNP lẫn indel, cả SUP lẫn HAC)
- Nanopore **vượt short-read Snippy**, đặc biệt ở **vùng lặp và vùng nhiều biến thể**
- Tỉ lệ indel giả của SUP + Clair3 **ngang mức của phương pháp short-read**

### [LIT] Hall et al., *Microbial Genomics* 2024 — pmc.ncbi.nlm.nih.gov/articles/PMC11170131
Nghiên cứu định giá quan trọng nhất cho hồ sơ đầu tư.
- Chủng: *E. coli* CFT073, *K. pneumoniae* MGH78578, *P. aeruginosa* PAO1,
  *S. aureus* MRSA252 + 9 chủng *E. coli* lâm sàng
- R10.4.1/Kit 14 ở **5 kHz**; Dorado v0.4.0 vs **v0.5.3** (methylation-aware); nền so sánh R9.4.1
- **Độ chính xác read: R10.4.1 trung vị 98,8%** (IQR 98,1–99,2) vs **R9.4.1 96,8%**, P<0,001
- **Flye** v2.9 (`--nano-hq`) + **Medaka v1.6.0 đúng 1 vòng** —
  *"further polishing cycles did not improve error rates"*
- **≥40× → assembly ngang hoặc TỐT HƠN hybrid Unicycler** (lỗi thấp hơn ở 3/4 loài)
- **CDS recovery >99% ở ≥30×**
- **BSA**: độ tương đồng read với tham chiếu **98,76% → 99,32%**, P<0,001;
  giảm indel ở **7/9** bộ gen
- **Chi phí: ~£1.200/flow cell cho ~5,9–6,4 Gb (rapid kit) → £40–45 mỗi chủng ở 40×**
- Kết luận của tác giả: *"reference quality genome assembly without the need for
  short-read sequencing."*

### Dùng trong giáo trình
| Module | Vai trò |
|---|---|
| **M11** Assembly | ★ **xương sống của module** |
| **M22** Quality management | ★ đây chính là dữ liệu thẩm định |
| M10, M13, M23 | alignment, variant calling, hồ sơ ISO |

**Giá trị riêng:** đây là case **duy nhất** cung cấp con số để **viết hồ sơ thẩm định
phương pháp** và **hồ sơ đầu tư**.

---

## CS5 · Đặc trưng hoá chủng mầm bệnh thực phẩm không cần nuôi cấy ✅ [ONT, đủ chi tiết]

**Link:** …/culture-free-strain-level-characterisation-of-foodborne-pathogens-using-targeted-nanopore-metagenomics

- Mầm bệnh: ***Staphylococcus aureus*** (chủng liên quan ổ dịch)
- Nền mẫu: **khoai tây nghiền** cấy S. aureus sống; hỗn hợp DNA khoai tây
- Thiết bị: **GridION**
- Phương pháp: **adaptive sampling**, ba chiến lược, so với shotgun không đích:
  1. **Loại (deplete) DNA khoai tây**
  2. **Làm giàu (enrich) DNA S. aureus**
  3. Làm giàu theo **CSDL mầm bệnh thực phẩm**

### Kết quả — thu hồi 13 gen enterotoxin
| Chiến lược | Gen thu được |
|---|---|
| Adaptive sampling — loại nền mẫu khoai tây | **13/13** |
| Adaptive sampling — làm giàu *S. aureus* | **13/13** |
| Adaptive sampling — theo CSDL mầm bệnh | 11/13 (85%) |
| **Shotgun không đích** | **8/13 (62%)** và 11/13 (85%) ở lần lặp khác |

- Đặt đúng chủng vào **cụm phát sinh loài của ổ dịch**
- **Không có bước nuôi cấy tăng sinh nào**
- Kết luận: *"adaptive sampling outperformed the shotgun sequencing"* cho điều tra ổ dịch

### Dùng trong giáo trình
| Module | Vai trò |
|---|---|
| **M17D** Adaptive sampling | ★ case chủ đạo |
| **M15** Metagenomics | ★ targeted metagenomics |
| M16, M18 | gen độc lực; bỏ bước tăng sinh khỏi quy trình |

**Giá trị riêng — case quan trọng nhất về mặt chiến lược:**
adaptive sampling **xoá bỏ bước nuôi cấy tăng sinh**, tức khâu chậm nhất trong mọi phương pháp
ISO thực phẩm hiện hành. Đây là thay đổi tính bằng **ngày**, không phải bằng phần trăm.

---

## BẢNG TRA NGƯỢC — module nào dùng case nào

| Module | CS1 | CS2 | CS3 | CS4 | CS5 |
|---|:---:|:---:|:---:|:---:|:---:|
| M11 Assembly | | ● | ● | **★** | |
| M13 Variant calling | **★** | | | ● | |
| M14 Phylogenetics | **★** | | ● | | ● |
| M15 Metagenomics | | **★** | | | **★** |
| M16 AMR | | | **★** | | ● |
| M17 Nanopore | ● | | ● | ● | **★** |
| M18 Laboratory workflow | | | ● | ● | **★** |
| M22 Quality management | | ● | | **★** | |
| M23 ISO 17025 | | | ● | **★** | ● |

★ case chủ đạo · ● tham chiếu phụ

**Phủ tốt:** M11, M15, M16, M17, M22.
**Không phủ:** M2–M10 (Linux, CLI, Python, định dạng file) và M19–M21 (pipeline, automation,
reporting) → dựa vào Buffalo + nội dung tự soạn.

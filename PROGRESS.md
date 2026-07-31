# PROGRESS.md — Nguồn sự thật duy nhất / Single source of truth

> **Claude Code:** đọc file này ĐẦU mỗi session, cập nhật CUỐI mỗi session, rồi `git push`.
> **Claude Chat (mentor):** đọc file này qua raw URL trước khi trả lời câu hỏi về tiến độ.
> **Không có nguồn tiến độ nào khác.** Nếu file này và trí nhớ mâu thuẫn → file này đúng.

---

## TRẠNG THÁI HIỆN TẠI / Current state

| Trường | Giá trị |
|---|---|
| Cập nhật lần cuối | **2026-07-31** |
| Phiên bản lộ trình | **v2** (827 h ≈ 21 tháng — đã thêm nhánh M25 GMO) |
| Giai đoạn | **GĐ I — Nền tảng** |
| Module đang học | **M2 — Linux** (25 h) |
| Vị trí trong module | BT1 ✅ PASS · đang tới BT2 |
| Giờ tích luỹ | ~6 / 827 h |
| Tuần thứ | 1 |
| Mốc gần nhất | **Mốc A** — cuối GĐ III (~tháng 8,5) |

**Việc kế tiếp / Next action:** BT2 của M2.

---

## BẢNG TIẾN ĐỘ / Progress table

**Ký hiệu:** ✅ xong · 🟡 đang làm · ⬜ chưa · 🔒 khoá (chưa đủ tiền đề)
**M** = Applied · **T** = Theory từ sách · **T+** = Theory hiện đại

### GĐ I — Nền tảng (tháng 1–2) · 73 h
| # | Module | h | TT | Ghi chú |
|---|---|---|---|---|
| 1 | M0 Learning roadmap | 4 | ✅ | |
| 2 | **M2 Linux** | 25 | 🟡 | BT1 ✅ · BT2–BT8 ⬜ · MP1 ⬜ · MP2 ⬜ |
| 3 | T1 Sinh học phân tử & tiến hoá | 6 | ⬜ | Ohlebusch ch.1 + Selzer ch.2 |
| 4 | M1 Modern molecular biology for NGS | 10 | ⬜ | |
| 5 | M3 Command line & data wrangling | 28 | ⬜ | |

### GĐ II — Dữ liệu & định dạng (tháng 3–5) · 110 h
| # | Module | h | TT |
|---|---|---|---|
| 6 | M5 Sequence databases | 10 | ⬜ |
| 7 | M6 FASTA | 6 | ⬜ |
| 8 | M7 FASTQ | 14 | ⬜ |
| 9 | M17A Nanopore physics & chemistry | 10 | ⬜ |
| 10 | T+2 Basecalling: signal → base | 12 | ⬜ |
| 11 | M17B Platforms & flow cells | 10 | ⬜ |
| 12 | M4 Python for bioinformatics | 30 | ⬜ |
| 13 | M8 SAM/BAM/CRAM | 18 | ⬜ |

### GĐ III — Chuỗi & alignment (tháng 6–8,5) · 112 h
| # | Module | h | TT | Thuật toán nộp |
|---|---|---|---|---|
| 14 | T2 Exact string matching | 12 | ⬜ | #1 KMP + Aho-Corasick |
| 15 | T3 Suffix array, LCP, suffix tree | 18 | ⬜ | #2 SA + LCP Kasai |
| 16 | T5 BWT & FM-index | 18 | ⬜ | #3 BWT + backward search |
| 17 | M9 VCF | 10 | ⬜ | |
| 18 | T6 Alignment theory + PAM/BLOSUM/E-value | 22 | ⬜ | #4 NW+SW affine → CIGAR |
| 19 | T+1 Minimizer & sketching | 10 | ⬜ | #5 minimizer + MinHash |
| 20 | M10 minimap2 thực hành | 22 | ⬜ | |

> **🏁 MỐC A** — tự viết được NW/SW ra CIGAR, giải thích được mọi tham số `minimap2`.

### GĐ IV — Assembly (tháng 9–11) · 96 h
| # | Module | h | TT | Thuật toán nộp |
|---|---|---|---|---|
| 21 | T4 Ứng dụng suffix array: repeat, MUM | 16 | ⬜ | |
| 22 | T+3 De Bruijn graph, repeat graph, OLC | 14 | ⬜ | #6 de Bruijn graph |
| 23 | **M11 Genome assembly** | 38 | ⬜ | ★ đóng 1 genome vi khuẩn |
| 24 | T+4 POA & consensus | 10 | ⬜ | |
| 25 | M12 Genome annotation (Bakta) | 18 | ⬜ | |

> **🏁 MỐC B** — đóng được genome vi khuẩn từ ONT read, không cần trợ giúp → **đã có nghề**.

### GĐ V — Diễn giải (tháng 12–14) · 99 h
| # | Module | h | TT | Thuật toán nộp |
|---|---|---|---|---|
| 26 | M16 Antimicrobial resistance (+ `qac`) | 20 | ⬜ | |
| 27 | T8 Phylogenetics theory | 20 | ⬜ | #7 UPGMA + NJ |
| 28 | T+6 Maximum likelihood & recombination | 14 | ⬜ | |
| 29 | M14 cgMLST, SNP, IQ-TREE2, Gubbins | 25 | ⬜ | |
| 30 | M13 Variant calling: Clair3, Sniffles2 | 20 | ⬜ | |

### GĐ VI — Nanopore đầy đủ + lab (tháng 15–16) · 85 h
| # | Module | h | TT |
|---|---|---|---|
| 31 | M17C Library prep & barcoding (BSA) | 12 | ⬜ |
| 32 | M17D MinKNOW, Dorado, POD5, **adaptive sampling** | 18 | ⬜ |
| 33 | M17E Read QC & data management | 10 | ⬜ |
| 34 | M17F Vận hành thiết bị & IQ/OQ/PQ | 15 | ⬜ |
| 35 | M18 Laboratory workflow (HMW extraction →) | 30 | ⬜ |

### 🆕 GĐ VI-B — GMO & NGT (tháng 17) · 40 h — *thêm ngày 2026-07-31*
| # | Module | h | TT | Ghi chú |
|---|---|---|---|---|
| 36 | **M25A** GMO detection landscape & giới hạn của qPCR | 8 | 🔒 | ISO 24276/21569/21570/21571, EURL-GMFF |
| 37 | **M25B** Đặc tả insert bằng ONT + adaptive sampling panel | 20 | 🔒 | cần M13 + M17D |
| 38 | **M25C** NGT / gene-edited: Reg. (EU) 2026/1388 | 12 | 🔒 | áp dụng từ 17/07/2028 |

### GĐ VII — Kỹ thuật (tháng 18–19) · 70 h
| # | Module | h | TT |
|---|---|---|---|
| 39 | M19 Pipeline design | 25 | ⬜ |
| 40 | M20 Automation: Nextflow, Snakemake, Git, container | 30 | ⬜ |
| 41 | M21 Reporting | 15 | ⬜ |

### GĐ VIII — Chất lượng (tháng 19–20) · 52 h
| # | Module | h | TT |
|---|---|---|---|
| 42 | M22 Quality management for NGS | 22 | ⬜ |
| 43 | M23 ISO 17025 + ISO 23418 + ALCOA+ | 30 | ⬜ |

> **🏁 MỐC C** — viết được hồ sơ thẩm định pipeline chịu được đánh giá ISO 17025.

### GĐ IX — Metagenomics (tháng 20–21) · 50 h
| # | Module | h | TT | Thuật toán nộp |
|---|---|---|---|---|
| 44 | T+5 k-mer LCA & EM abundance | 10 | ⬜ | #8 LCA + EM |
| 45 | M15 Metagenomics | 40 | ⬜ | |

### GĐ X — Đồ án (tháng 21+) · 40 h
| # | Module | h | TT |
|---|---|---|---|
| 46 | M24 Capstones ×4 | 40 | ⬜ |
| — | *(tuỳ chọn)* T7 Sorting by reversals | 10 | ⬜ |

---

## TỔNG / Totals

| Track | Giờ |
|---|---|
| Applied (M0–M24) | 595 |
| **GMO (M25A–C)** — *mới* | **40** |
| Theory từ sách (T1–T8) | 122 |
| Theory hiện đại (T+1–T+6) | 70 |
| **TỔNG** | **827 h ≈ 92 tuần ≈ 21 tháng** |

---

## PORTFOLIO — theo dõi riêng

| # | Artifact | Trạng thái | Module |
|---|---|---|---|
| P1 | GitHub repo công khai, có lịch sử commit liên tục | 🟡 đang tạo | — |
| P2 | Thư viện 8 thuật toán tự viết | ⬜ 0/8 | T2–T+5 |
| P3 | Pipeline Nextflow FASTQ → closed genome → Bakta → AMR | ⬜ | M20 |
| P4 | **Hồ sơ validation ISO 17025 cho một phương pháp WGS** | ⬜ | M22–M23 |
| P5 | Business case mua thiết bị (3 trang) | ⬜ | ~tháng 6–8 |
| P6 | Một PR được merge (nf-core / EPI2ME / Bakta) | ⬜ | sau M20 |
| P7 | Poster / abstract hội nghị | ⬜ | sau Capstone 1 |
| P8 | **3 tình huống GMO mà qPCR không trả lời được** (từ 9 năm kinh nghiệm) | ⬜ | ngay tuần này |

## CHỨNG CHỈ — mốc dự kiến
| Chứng chỉ | Mốc | Trạng thái |
|---|---|---|
| LFCS (Linux Foundation) | ~tháng 7 | ⬜ |
| Nextflow Training Week (Seqera, miễn phí) | ~tháng 13 | ⬜ |
| ISO/IEC 17025 Internal Auditor | ~tháng 19 | ⬜ |
| Wellcome Connecting Science (nộp đơn) | sau tháng 21 | ⬜ |

---

## CÂU HỎI ĐANG CHỜ MENTOR / Open questions for mentor
*(Claude Code ghi vào đây, người học hỏi trên điện thoại, mentor trả lời rồi xoá)*

- *(trống)*

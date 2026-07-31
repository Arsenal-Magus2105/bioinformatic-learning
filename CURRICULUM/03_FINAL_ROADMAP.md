# LỘ TRÌNH CUỐI CÙNG / Final Roadmap — LOCKED
Chốt ngày 2026-07-27 · 787 giờ ≈ 20 tháng ở 9 giờ/tuần

## Cấu hình đã chốt
- Phạm vi mẫu: **Thực phẩm + Môi trường/nước + Dược/mỹ phẩm** (không lâm sàng)
- Workflow ưu tiên: **Isolate WGS**
- Chưa có máy → thực hành trên **public ONT data**
- Ngôn ngữ: **song ngữ Việt–Anh**
- Lý thuyết: **Tầng 2 "Vững"**, **xen kẽ just-in-time**

## Tầng 2 nghĩa là gì — cụ thể
**CÓ:** hiểu thuật toán, chạy tay ví dụ nhỏ, **tự cài đặt bằng Python**, đọc được paper,
chọn tool có căn cứ, bảo vệ phương pháp trước đánh giá viên.
**KHÔNG:** chứng minh độ phức tạp, linear-time SA construction (DC3/SA-IS, induced sorting),
RMQ O(1) proofs, wavelet tree, compressed index (Ohlebusch ch.6), Lempel-Ziv,
string kernel, bộ máy chứng minh Hannenhalli–Pevzner (ch.9).

### Thư viện thuật toán cá nhân / Personal algorithm library
Một git repo, 8 thuật toán bạn tự viết. Đây là **portfolio** chứng minh năng lực:

| # | Thuật toán | Module | Nộp ở |
|---|---|---|---|
| 1 | KMP + **Aho-Corasick** automaton | T2 | GĐ III |
| 2 | Suffix array naive + **LCP bằng Kasai** | T3 | GĐ III |
| 3 | **BWT** xuôi/ngược + backward search đếm occurrence | T5 | GĐ III |
| 4 | **Needleman–Wunsch + Smith–Waterman** affine gap, traceback → CIGAR | T6 | GĐ III |
| 5 | Trích **minimizer** + ước lượng Jaccard bằng **MinHash** | T+1 | GĐ III |
| 6 | Dựng **de Bruijn graph** nhỏ | T+3 | GĐ IV |
| 7 | **UPGMA + Neighbor-Joining** từ ma trận khoảng cách | T8 | GĐ V |
| 8 | **LCA** trên cây phân loại + **EM** ước lượng abundance | T+5 | GĐ IX |

---

## LỊCH TRÌNH XEN KẼ / Interleaved schedule

**Ký hiệu:** M = Applied · T = Theory (từ sách) · T+ = Theory hiện đại (tôi soạn)

### GĐ I — Nền tảng (tháng 1–2) · 73 h
| Thứ tự | Module | h |
|---|---|---|
| 1 | M0 Learning roadmap | 4 |
| 2 | **M2 Linux** | 25 |
| 3 | T1 Sinh học phân tử & tiến hóa *(Ohlebusch ch.1 + Selzer ch.2)* | 6 |
| 4 | M1 Modern molecular biology for NGS | 10 |
| 5 | M3 Command line & data wrangling | 28 |

### GĐ II — Dữ liệu & định dạng (tháng 3–5) · 110 h
| | Module | h | Ghi chú |
|---|---|---|---|
| 6 | M5 Sequence databases | 10 | + GTDB, PubMLST, NCBI Pathogen Detection |
| 7 | M6 FASTA | 6 | |
| 8 | M7 FASTQ | 14 | ONT quality model, uBAM, MM/ML tags |
| 9 | **M17A** Nanopore physics & chemistry | 10 | R10.4.1, dual reader head, 5 kHz |
| 10 | **T+2** Basecalling: signal → base | 12 | HMM → RNN/CTC → transformer; duplex |
| 11 | **M17B** Platforms & flow cells | 10 | Flongle/MinION/GridION/PromethION |
| 12 | M4 Python for bioinformatics | 30 | |
| 13 | M8 SAM/BAM/CRAM | 18 | học trên BAM tải sẵn |

### GĐ III — Chuỗi & alignment (tháng 6–8,5) · 112 h
| | Module | h | Trả về ứng dụng |
|---|---|---|---|
| 14 | **T2** Exact string matching *(Ohlebusch ch.2)* | 12 | Aho-Corasick → quét gen AMR |
| 15 | **T3** Suffix array, LCP, suffix tree *(ch.3–4)* | 18 | bản chất "index genome" |
| 16 | **T5** BWT & FM-index, backward search *(ch.6–7)* | 18 | nền bwa/bowtie2/pangenome |
| 17 | M9 VCF | 10 | *nghỉ giữa hiệp — applied* |
| 18 | **T6** Alignment theory + PAM/BLOSUM/E-value *(ch.8 + Selzer ch.4)* | 22 | đọc hiểu CIGAR |
| 19 | **T+1** Minimizer & sketching | 10 | **minimap2 dùng cái này, không dùng FM-index** |
| 20 | M10 Sequence alignment — minimap2 thực hành | 22 | |

### GĐ IV — Assembly (tháng 9–11) · 96 h
| | Module | h | Trả về ứng dụng |
|---|---|---|---|
| 21 | **T4** Ứng dụng suffix array: repeat, MUM, all-pairs suffix-prefix *(ch.5)* | 16 | **maximal repeat = lý do contig bị đứt**; suffix-prefix = overlap OLC |
| 22 | **T+3** De Bruijn graph, repeat graph, OLC | 14 | Flye, miniasm, Autocycler |
| 23 | **M11 Genome assembly** | 38 | ★ **CỘT MỐC: đóng 1 genome vi khuẩn** |
| 24 | **T+4** POA & consensus | 10 | racon, Medaka |
| 25 | M12 Genome annotation | 18 | Bakta |

### GĐ V — Diễn giải (tháng 12–14) · 99 h
| | Module | h |
|---|---|---|
| 26 | M16 Antimicrobial resistance *(+ `qac` biocide resistance cho mỹ phẩm)* | 20 |
| 27 | **T8** Phylogenetics theory: ultrametric, additive, UPGMA, NJ *(ch.10)* | 20 |
| 28 | **T+6** Maximum likelihood & recombination | 14 |
| 29 | M14 Phylogenetics thực hành: cgMLST, SNP, IQ-TREE2, Gubbins | 25 |
| 30 | M13 Variant calling: Clair3, Sniffles2 | 20 |

### GĐ VI — Nanopore đầy đủ + lab (tháng 15–16) · 85 h
| | Module | h |
|---|---|---|
| 31 | M17C Library prep & barcoding (LSK114/RBK114/NBD114, BSA) | 12 |
| 32 | M17D MinKNOW, Dorado, POD5, **adaptive sampling** | 18 |
| 33 | M17E Read QC & data management | 10 |
| 34 | M17F Vận hành thiết bị & IQ/OQ/PQ | 15 |
| 35 | M18 Laboratory workflow (HMW extraction → sequencing) | 30 |

### GĐ VII — Kỹ thuật (tháng 17–18) · 70 h
| 36 | M19 Pipeline design | 25 |
| 37 | M20 Automation: Nextflow, Snakemake, Git, container | 30 |
| 38 | M21 Reporting | 15 |

### GĐ VIII — Chất lượng (tháng 18–19) · 52 h
| 39 | M22 Quality management for NGS | 22 |
| 40 | M23 ISO 17025 + ISO 23418 + ALCOA+ | 30 |

### GĐ IX — Metagenomics (tháng 19–20) · 50 h
| 41 | **T+5** k-mer LCA classification & EM abundance | 10 |
| 42 | M15 Metagenomics | 40 |

### GĐ X — Đồ án (tháng 20+) · 40 h
| 43 | M24 Capstones ×4 | 40 |
| — | *(tùy chọn)* T7 Sorting by reversals *(ch.9)* | 10 |

---

## TỔNG KẾT
| Track | Giờ |
|---|---|
| Applied (M0–M24) | 595 |
| Theory từ sách (T1–T8) | 122 |
| Theory hiện đại (T+1–T+6) | 70 |
| **TỔNG** | **787 h ≈ 87 tuần ≈ 20 tháng** |

## Ba cột mốc kiểm tra
| Mốc | Khi nào | Tiêu chí |
|---|---|---|
| **A** | cuối GĐ III (~tháng 8,5) | Tự viết được NW/SW ra CIGAR, và giải thích được mọi tham số minimap2 |
| **B** | cuối GĐ IV (~tháng 11) | **Đóng được genome vi khuẩn từ ONT read, không cần trợ giúp** → đã có nghề |
| **C** | cuối GĐ VIII (~tháng 19) | Viết được hồ sơ thẩm định pipeline chịu được đánh giá ISO 17025 |

**Tiếp theo: Module 2 — Linux.**

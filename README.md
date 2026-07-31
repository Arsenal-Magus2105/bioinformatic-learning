# Chương trình Tin sinh học Oxford Nanopore cho phòng thí nghiệm ISO 17025

**787 giờ · ~20 tháng · 9 giờ/tuần · song ngữ Việt–Anh**

---

## Bắt đầu từ đâu

| Bạn muốn | Mở file |
|---|---|
| **Xem lịch trình học** | [`CURRICULUM/03_FINAL_ROADMAP.md`](CURRICULUM/03_FINAL_ROADMAP.md) ★ |
| Hiểu kiến trúc toàn chương trình, bản đồ 25 module, đánh giá 3 cuốn sách | [`CURRICULUM/00_MASTER_CURRICULUM.md`](CURRICULUM/00_MASTER_CURRICULUM.md) |
| Xem lại phạm vi đã chốt và mảng dược phẩm/mỹ phẩm | [`CURRICULUM/02_SCOPE_LOCKED.md`](CURRICULUM/02_SCOPE_LOCKED.md) |
| Tra số liệu từ 5 case study ONT | [`CURRICULUM/04_CASE_STUDIES.md`](CURRICULUM/04_CASE_STUDIES.md) |
| Cân nhắc mua PromethION | [`CURRICULUM/01_PROMETHION_DECISION_BRIEF.md`](CURRICULUM/01_PROMETHION_DECISION_BRIEF.md) |
| **Học lý thuyết trên điện thoại** | [`apps/ont-study.html`](apps/ont-study.html) — hoặc mở link Artifact |
| Bài giảng từng module | `CURRICULUM/modules/` |

---

## Cách hỏi đáp với mentor

Mở terminal **tại thư mục này**:

```bash
cd /d/book/bioinformatic && claude
```

File `CLAUDE.md` sẽ tự nạp, nên mentor luôn biết: bạn là ai, phạm vi đã chốt, quy ước song ngữ,
lộ trình, và những phán quyết về công nghệ lỗi thời. Bạn **không cần nhắc lại bối cảnh**.

Ví dụ câu hỏi hỏi được ngay:
- `"Module 2"` → nhận bài giảng Linux đầy đủ
- `"minimap2 -x map-ont và lr:hq khác nhau chỗ nào?"`
- `"Tôi có 25× coverage, có đóng được genome không?"`
- `"Viết cho tôi phần thẩm định pipeline assembly cho hồ sơ ISO 17025"`

Mỗi câu trả lời đều kèm: **thuộc module nào · phụ thuộc kiến thức nào · học gì tiếp theo**.

---

## Cấu trúc thư mục

```
D:\book\bioinformatic\
├── CLAUDE.md                     ← bối cảnh tự nạp cho mentor
├── README.md                     ← file này
├── *.pdf                         ← 3 cuốn sách nguồn
├── CURRICULUM\
│   ├── 00_MASTER_CURRICULUM.md   kiến trúc + bản đồ 25 module + audit sách
│   ├── 01_PROMETHION_DECISION_BRIEF.md
│   ├── 02_SCOPE_LOCKED.md        phạm vi + mảng dược phẩm + dữ liệu công khai
│   ├── 03_FINAL_ROADMAP.md   ★   lịch trình chính thức, 10 giai đoạn
│   ├── 04_CASE_STUDIES.md        5 case study ONT + toàn bộ số liệu
│   └── modules\                  bài giảng từng module (giao dần)
├── apps\ont-study.html           app thẻ ghi nhớ + trắc nghiệm (81 thẻ, 41 câu)
├── notes\                        logbook và bài làm của bạn
└── data\                         dữ liệu thực hành
```

---

## Lộ trình rút gọn

| GĐ | Tháng | Nội dung | Giờ |
|---|---|---|---|
| I | 1–2 | M0 → **M2 Linux** → T1 → M1 → M3 | 73 |
| II | 3–5 | M5 → M6 → M7 → M17A → T+2 → M17B → M4 → M8 | 110 |
| III | 6–8,5 | T2 → T3 → T5 → M9 → T6 → T+1 → M10 | 112 |
| IV | 9–11 | T4 → T+3 → **★ M11 Assembly** → T+4 → M12 | 96 |
| V | 12–14 | M16 → T8 → T+6 → M14 → M13 | 99 |
| VI | 15–16 | M17C–F → M18 | 85 |
| VII | 17–18 | M19 → M20 → M21 | 70 |
| VIII | 18–19 | M22 → M23 | 52 |
| IX | 19–20 | T+5 → M15 | 50 |
| X | 20+ | M24 Đồ án ×4 | 40 |

**M** = ứng dụng · **T** = lý thuyết từ sách · **T+** = lý thuyết hiện đại

### Ba cột mốc
- **A** (~tháng 8,5) — tự viết được Needleman-Wunsch/Smith-Waterman ra CIGAR, giải thích được mọi tham số minimap2
- **B** (~tháng 11) — **đóng được bộ gen vi khuẩn từ ONT read, không cần trợ giúp** → đã có nghề
- **C** (~tháng 19) — viết được hồ sơ thẩm định pipeline chịu được đánh giá ISO 17025

---

## Bốn đồ án tốt nghiệp

1. **Thực phẩm** — *Listeria monocytogenes* nhà máy RTE: closed genome → serogroup → cgMLST → AMR → liên kết ổ dịch (**ISO 23418:2022**)
2. **Môi trường/nước** — *Pseudomonas* / *Ralstonia* trong hệ nước tinh khiết: truy vết nguồn qua nhiều điểm và nhiều thời điểm
3. **Dược/mỹ phẩm** — chủng **BCC** từ sản phẩm không vô khuẩn: định danh đến loài, đối chiếu isolate environmental monitoring, quy kết nguồn nhiễm (**USP <60>, <1113>, EU GMP Annex 1**)
4. **Xuyên suốt** — định vị gen kháng (carbapenemase hoặc **`qac`**) trên plasmid hay chromosome — năng lực **chỉ long-read làm được**

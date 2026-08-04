# Sổ tay học tập / Learning logbook

Ghi mỗi buổi học. Đây vừa là nhật ký học, vừa là bản nháp của **electronic lab notebook**
sau này — thoả "Attributable" và "Contemporaneous" của ALCOA+.

Mẫu mỗi mục:

```
## YYYY-MM-DD · Module · thời lượng
**Đã làm:**
**Lệnh đã chạy:**
**Kết quả / quan sát:**
**Vướng mắc:**
**Quyết định:**
```

---

## 2026-07-27 · M0 · lập kế hoạch
**Đã làm:** Chốt phạm vi chương trình cùng mentor — mẫu thực phẩm/môi trường/dược phẩm,
ưu tiên isolate WGS, lý thuyết Tầng 2 xen kẽ just-in-time, song ngữ.
**Quyết định:** Tổng 787 giờ, 20 tháng. Bắt đầu bằng M2 Linux.
**Việc tiếp theo:** cài WSL2 Ubuntu 24.04 + micromamba, dựng cây thư mục `~/bioinfo`,
viết "Environment Verification Record" (mini project của M0).

---

## 2026-08-01 · M2 · 1 h
**Đã làm:** BT2 — cây thư mục `~/bioinfo` bằng một lệnh `mkdir -p` với nested brace
expansion, khoá `data/raw` chỉ đọc bằng `chmod -w`.
**Lệnh đã chạy:**
```bash
mkdir -p ~/bioinfo/{data/{raw,processed},refs,scripts,projects,envs,notes}
chmod -w ~/bioinfo/data/raw
ls -ld ~/bioinfo/data/raw
tree -L 2 ~/bioinfo
```
**Kết quả / quan sát:** `data/raw` chuyển từ `drwxr-xr-x` (755) sang `dr-xr-xr-x` (555) —
mất `w` cả 3 nhóm, còn nguyên `x` nên vẫn `cd`/đọc được. `tree -L 2` khớp đúng cấu trúc
yêu cầu. Phát hiện phụ: `~/bioinfo` đã tồn tại từ Jul 29 (lúc làm BT1) — `mkdir -p` chạy
lại không đổi gì, xác nhận qua link count (`8` = `2` + 6 thư mục con).
**Vướng mắc:** ban đầu nhầm dấu `,` trong `{}` là cú pháp của `mkdir` (thật ra là brace
expansion của bash); gõ `~bioinfo` thiếu `/` khiến bash hiểu nhầm là tên user; đọc sai
nhóm quyền `other` trong `ls -ld` (bỏ sót ký tự `r`).
**Quyết định:** dùng `chmod -w` (symbolic, tương đối) thay vì `chmod 444` cho thư mục —
giữ được `x` để còn traverse/đọc file bên trong ở BT3–BT4.
**Câu hỏi cho mentor:** *(trống)*

---

## 2026-08-03 · M2 · ~1,5 h
**Đã làm:** BT3 — tải genome *E. coli* K-12 MG1655 từ NCBI, tính `sha256sum`, khoá file
`444`, khoá lại thư mục `data/raw` bằng `-w`/`+x` (555), chứng minh chặn ghi đè trên
chính file dữ liệu thô.
**Lệnh đã chạy:**
```bash
chmod +w ~/bioinfo/data/raw
cd ~/bioinfo/data/raw
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
sha256sum GCF_000005845.2_ASM584v2_genomic.fna.gz > e.coli_checksum.sha256
chmod 444 GCF_000005845.2_ASM584v2_genomic.fna.gz
chmod +x ~/bioinfo/data/raw          # phục hồi sau khi lỡ chmod 444 cả thư mục
echo test > GCF_000005845.2_ASM584v2_genomic.fna.gz   # phép thử ghi đè
```
**Kết quả / quan sát:**
- Checksum: `a96d3cfa58c88d477013c768f90a11d2386d42a70d566abfb6d9013dcbd24255  GCF_000005845.2_ASM584v2_genomic.fna.gz`
- Ghi đè bị chặn: `-bash: GCF_000005845.2_ASM584v2_genomic.fna.gz: Permission denied`
- Trạng thái cuối: file `-r--r--r--` (444), thư mục `dr-xr-xr-x` (555), file checksum
  vẫn `rw-r--r--` (644 — hợp lý vì không phải dữ liệu thô gốc).
**Vướng mắc:**
- Lúc đầu áp `chmod 444` (dạng số) trực tiếp lên **thư mục** `data/raw` thay vì lên file
  — mất luôn bit `x`, sẽ chặn cả việc đọc file cho BT4 sau này. Sửa bằng `chmod +x`
  (tương đương `-w` từ 755) để về lại 555.
- Nhầm lẫn `rm -f` là mặc định cần thiết — thực ra `-f` không cần cho file không bị khoá,
  và là thói quen rủi ro (im lặng bỏ qua lỗi) nên tránh dùng tuỳ tiện.
- Hiểu nhầm `ls` có thể liệt kê nội dung thư mục **trên server NCBI** — thực ra `ls` chỉ
  đọc local filesystem; muốn xem thư mục remote phải request qua HTTP (`wget` vào URL thư
  mục, không phải tên file).
- Claude Code tự ý mở nhánh phụ (đối chiếu checksum với `md5checksums.txt` của NCBI) ngoài
  phạm vi BT3, kéo theo `grep` chưa được dạy đúng lúc trong module — đã dừng nhánh này,
  không tính vào BT3.
**Quyết định:** `444` áp dụng cho **file** dữ liệu thô; thư mục chứa nó giữ `555`
(`r-xr-xr-x`) để vẫn truy cập được nội dung nhưng không tạo/xoá/đổi tên file bên trong.
Đối chiếu checksum với nguồn NCBI (`md5checksums.txt`) hoãn lại cho MP2.
**Câu hỏi cho mentor:** *(trống)*

---

## 2026-08-04 · M2 · ~45 phút
**Đã làm:** BT4 — khảo sát file genome nén mà không giải nén ra đĩa, dùng pipe nối
`zcat` với `head`/`wc -l`/`grep -c`.
**Lệnh đã chạy:**
```bash
ls -lh GCF_000005845.2_ASM584v2_genomic.fna.gz
zcat GCF_000005845.2_ASM584v2_genomic.fna.gz | head -n 1
zcat GCF_000005845.2_ASM584v2_genomic.fna.gz | wc -l
zcat GCF_000005845.2_ASM584v2_genomic.fna.gz | grep -c "^>"
```
**Kết quả / quan sát:**
- Dung lượng nén: `1.4M`
- Dòng đầu tiên: `>NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genome`
- Tổng số dòng: `58022` — đối chiếu bằng tính tay (4.641.652 bp / 80 ký tự mỗi dòng ≈
  58.021 dòng chuỗi + 1 dòng header) khớp gần đúng, xác nhận không có gì bất thường.
- Số dòng bắt đầu bằng `>`: `1`
**Diễn giải:** ban đầu kết luận "1 sequence = genome hoàn thiện, nhiều sequence = chưa
assemble" — bị sửa vì sai: số dòng `>` chỉ phản ánh **số replicon**, không tự động phản
ánh mức hoàn chỉnh (một genome đóng hoàn chỉnh vẫn có thể có nhiều dòng `>` nếu mang
plasmid). Kết luận đúng phải dựa vào **nội dung header** — ở đây ghi rõ "complete genome"
→ xác nhận *E. coli* K-12 MG1655 có bộ gen đóng hoàn chỉnh, không mang plasmid, không có
contig rời.
**Vướng mắc:** chưa từng dùng pipe (`|`) trước đây; chưa phân biệt được `^>` (đầu dòng)
với `>` (bất kỳ đâu trong dòng) trong regex của `grep`.
**Quyết định:** dùng tab completion cho tên file dài thay vì copy-paste từ `ls`, tránh lỗi
ký tự ẩn.
**Câu hỏi cho mentor:** *(trống)*

---

## Bảng trạng thái module

| Module | Bắt đầu | Hoàn thành | Tự chấm /25 | Ghi chú |
|---|---|---|---|---|
| M0 Learning roadmap | 2026-07-27 | | | |
| M2 Linux | | | | |
| T1 Sinh học phân tử & tiến hoá | | | | |
| M1 Molecular biology for NGS | | | | |
| M3 Command line | | | | |

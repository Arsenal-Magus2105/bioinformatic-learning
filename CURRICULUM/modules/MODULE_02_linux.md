# MODULE 2 — LINUX
**Giai đoạn I · 25 giờ · Độ khó ★★ Trung bình · Nguồn: Buffalo ch.3, ch.4, một phần ch.7**

---

## VỊ TRÍ TRONG CHƯƠNG TRÌNH

```
M0 Roadmap ──> [M2 LINUX] ──> T1 Sinh học phân tử ──> M1 MolBio cho NGS ──> M3 Command line
                   ▲
                   └── bạn đang ở đây. Đây là Tầng 1 (Compute) của năm tầng.
```

Không có module này thì **mọi module sau đều không chạy được**. Linux không phải một chủ đề
trong tin sinh học — nó là *mặt bàn thí nghiệm*. Bạn không học "về" mặt bàn; bạn học cách
làm việc trên đó mà không đổ mẫu.

---

## 1. MỤC TIÊU HỌC TẬP / Learning objectives

Kết thúc module, bạn có thể:

1. Cài và cấu hình **WSL2 + Ubuntu 24.04** trên Windows 11, hiểu rõ ranh giới giữa hai hệ thống file.
2. Điều hướng hệ thống file bằng đường dẫn tuyệt đối và tương đối, không cần giao diện đồ hoạ.
3. Giải thích **kernel / shell / userland** và nói được mỗi lệnh bạn gõ đi qua đâu.
4. Đặt và đọc **quyền file** (`rwx`, dạng số), và **khoá dữ liệu thô ở chế độ chỉ đọc**.
5. Dùng thành thạo **stdin / stdout / stderr**, redirect (`>`, `>>`, `2>`) và **pipe** (`|`).
6. Chạy, theo dõi, tạm dừng và **giết tiến trình**; chạy job dài nhiều giờ mà không sợ mất kết nối.
7. Cài phần mềm bằng **micromamba** vào môi trường riêng cho từng dự án, và **xuất ra file tái lập được**.
8. Đọc thông báo lỗi Linux và tự chẩn đoán trước khi hỏi.
9. Ánh xạ mọi thao tác trên sang **điều khoản ISO 17025** tương ứng.

---

## 2. KIẾN THỨC CẦN CÓ TRƯỚC / Prerequisites

- **M0** — chuỗi hiện vật, năm tầng, nguyên tắc dữ liệu thô bất biến.
- Máy Windows 11, quyền quản trị, **≥16 GB RAM**, **≥100 GB** ổ trống.
- Không cần biết lập trình. Không cần biết gì về Linux.

---

## 3. KHÁI NIỆM CỐT LÕI / Core concepts

### 3.1 Kernel, shell, userland

```
   Bạn gõ:  seqkit stats reads.fastq
                    │
                    ▼
   ┌─────────────────────────────────┐
   │ SHELL (bash)                    │  đọc dòng lệnh, tách từ, tìm chương trình
   │  - phân tích cú pháp            │  trong PATH, thiết lập luồng vào/ra
   │  - mở rộng ký tự đại diện *     │
   └──────────────┬──────────────────┘
                  ▼
   ┌─────────────────────────────────┐
   │ USERLAND — chương trình seqkit  │  chạy như một tiến trình riêng
   └──────────────┬──────────────────┘
                  ▼  lời gọi hệ thống (system call): open, read, write
   ┌─────────────────────────────────┐
   │ KERNEL                          │  quản lý CPU, RAM, ổ đĩa, mạng
   └──────────────┬──────────────────┘
                  ▼
              Phần cứng
```

**Điểm cần hiểu:** shell **không phải** là Linux. Shell chỉ là một chương trình phiên dịch.
Đó là lý do bạn đổi được shell (bash → zsh) mà hệ điều hành không đổi.

### 3.2 "Mọi thứ đều là file"

Ổ đĩa, tiến trình, kết nối mạng, thậm chí bộ sinh số ngẫu nhiên — đều xuất hiện dưới dạng file.
Hệ quả **rất thực dụng**: cùng một bộ công cụ (`cat`, `grep`, redirect, pipe) làm việc được với
mọi thứ. Bạn học một lần, dùng ở mọi nơi.

### 3.3 Cây hệ thống file

```
/                    gốc — chỉ có MỘT gốc, không có ổ C: ổ D:
├── home/
│   └── duy/         ← thư mục của bạn, viết tắt ~
│       └── bioinfo/ ← nơi mọi việc diễn ra
├── etc/             cấu hình toàn hệ thống
├── usr/             chương trình và thư viện
├── var/             dữ liệu thay đổi: log, cache
├── tmp/             tạm, bị xoá khi khởi động lại
└── mnt/
    └── c/           ← ổ C: của Windows. CHẬM. Đừng để dữ liệu làm việc ở đây.
```

Windows có nhiều gốc (`C:\`, `D:\`). Linux chỉ có **một gốc `/`**; mọi ổ đĩa khác được *gắn*
(mount) vào một thư mục bên trong nó.

### 3.4 Đường dẫn tuyệt đối và tương đối

| | Ví dụ | Đặc điểm |
|---|---|---|
| **Tuyệt đối** | `/home/duy/bioinfo/data/raw/run01.fastq` | Bắt đầu bằng `/`. **Luôn đúng**, bất kể bạn đang đứng đâu |
| **Tương đối** | `data/raw/run01.fastq` | Phụ thuộc thư mục hiện hành (`pwd`) |

Ký hiệu: `.` thư mục hiện tại · `..` thư mục cha · `~` thư mục nhà của bạn.

> **Quy tắc nghề nghiệp:** trong script chính thức, dùng **đường dẫn tuyệt đối** hoặc khai báo
> một biến gốc rõ ràng. Đường dẫn tương đối trong pipeline đã thẩm định là một lỗi tái lập
> đang chờ xảy ra.

### 3.5 Quyền và sở hữu

```
-rw-r--r--  1 duy duy  1.4G Jul 29 09:12 run01.fastq
│└┬┘└┬┘└┬┘    └┬┘ └┬┘
│ │  │  │      │   └── nhóm sở hữu
│ │  │  │      └────── người sở hữu
│ │  │  └───────────── other  : r-- = chỉ đọc
│ │  └──────────────── group  : r-- = chỉ đọc
│ └─────────────────── user   : rw- = đọc + ghi
└───────────────────── loại   : - file thường, d thư mục, l symlink
```

Dạng số: **r=4, w=2, x=1**, cộng lại theo từng nhóm.

| Số | Nghĩa | Dùng cho |
|---|---|---|
| `644` | chủ đọc/ghi, còn lại chỉ đọc | file dữ liệu thông thường |
| `755` | chủ toàn quyền, còn lại đọc + chạy | script, thư mục |
| `444` | **ai cũng chỉ đọc, kể cả chủ** | **dữ liệu thô đã khoá** |

### 3.6 Ba luồng chuẩn — khái niệm quan trọng nhất module này

```
                    ┌──────────────┐
   stdin (0) ──────>│              │──────> stdout (1)   DỮ LIỆU
   bàn phím / file  │  chương trình│        màn hình / file / pipe
                    │              │──────> stderr (2)   THÔNG BÁO & LỖI
                    └──────────────┘        màn hình / file log
```

**Vì sao tách stdout khỏi stderr?** Để **dữ liệu chảy qua pipe** trong khi **lỗi vẫn hiện ra
màn hình**. Nếu trộn chung, thông báo lỗi sẽ lọt thẳng vào file FASTQ của bạn — và bạn sẽ không
biết cho tới khi assembly thất bại ba ngày sau.

| Cú pháp | Ý nghĩa |
|---|---|
| `cmd > file` | ghi stdout vào file, **đè** nội dung cũ |
| `cmd >> file` | ghi stdout, **nối thêm** vào cuối |
| `cmd 2> log` | ghi stderr vào file log |
| `cmd > out 2> err` | tách hẳn hai luồng — **cách làm chuẩn cho pipeline** |
| `cmd &> all` | gộp cả hai vào một file |
| `cmd1 \| cmd2` | stdout của cmd1 thành stdin của cmd2 |
| `cmd < file` | lấy file làm stdin |

### 3.7 Tiến trình, job, exit code

- Mỗi chương trình đang chạy là một **tiến trình**, có số hiệu **PID**.
- `&` đưa job xuống nền · `Ctrl+Z` tạm dừng · `bg`/`fg` chuyển nền/tiền cảnh · `jobs` liệt kê.
- **Exit code: `0` = thành công**, khác 0 = lỗi. Ngược trực giác true/false.
- `cmd1 && cmd2` — chạy cmd2 **chỉ khi** cmd1 thành công. Đây là nền của mọi pipeline an toàn.

### 3.8 Môi trường và PATH

`PATH` là danh sách thư mục shell tìm chương trình, **theo thứ tự**. Cùng một lệnh có thể gọi
**hai phiên bản khác nhau** tuỳ PATH — và nó xảy ra **im lặng**.

```bash
which minimap2        # chương trình nào thực sự được gọi?
echo $PATH            # tìm ở đâu, theo thứ tự nào?
```

Đây chính là lý do ALCOA+ "Consistent" đòi hỏi container và version pinning.

---

## 4. KHÁI NIỆM NÂNG CAO / Advanced concepts

### 4.1 Kiến trúc WSL2 — và cái bẫy `/mnt/c`

```
┌─────────────────────── Windows 11 ───────────────────────┐
│                                                          │
│   Ổ C:  ────────────────┐                                │
│                         │  cầu nối 9P — CHẬM 5–20 lần    │
│   ┌── WSL2 (máy ảo nhẹ, kernel Linux thật) ──────────┐   │
│   │                     ▼                            │   │
│   │   /mnt/c   ←── ánh xạ sang ổ C: Windows          │   │
│   │                                                  │   │
│   │   /home/duy  ←── ext4 GỐC, TOÀN TỐC ĐỘ  ✅      │   │
│   └──────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────┘
```

**Quy tắc:** dữ liệu làm việc **luôn** nằm trong `~/`. `/mnt/c` chỉ dùng để chuyển file vào/ra.
Sai điều này có thể biến một assembly 1 giờ thành cả ngày.

### 4.2 Kết thúc dòng CRLF — cái bẫy riêng của người dùng Windows

Windows kết thúc dòng bằng `\r\n` (CRLF), Linux bằng `\n` (LF). File tạo trên Notepad chạy trong
Linux sẽ lỗi kiểu `bad interpreter: /bin/bash^M`. Đây là lỗi **số 1** của người mới chuyển sang WSL.

```bash
file script.sh                    # "with CRLF line terminators" = có vấn đề
dos2unix script.sh                # sửa
```
**Phòng ngừa:** soạn file bằng trình soạn thảo *bên trong* Linux (`nano`, `vim`) hoặc VS Code có
cài extension WSL và đặt line ending = LF.

### 4.3 Locale và thứ tự sắp xếp — cái bẫy riêng của tin sinh học

`sort` cho kết quả **khác nhau** tuỳ locale. Khi hai file được sắp xếp bằng hai locale khác nhau
rồi đem `join`, kết quả sẽ **sai một cách im lặng**.

```bash
export LC_ALL=C      # ép sắp xếp theo byte, ổn định, có thể tái lập
```
Buffalo nhấn mạnh điểm này. Đưa dòng trên vào đầu **mọi** script xử lý dữ liệu.

### 4.4 Symlink và hard link

| | Bản chất | Xoá đích thì sao |
|---|---|---|
| **Symlink** `ln -s` | con trỏ tới **đường dẫn** | link hỏng |
| **Hard link** `ln` | tên thứ hai của **cùng dữ liệu** | dữ liệu vẫn còn |

**Ứng dụng nghề nghiệp:** giữ dữ liệu thô ở một kho duy nhất, khoá `444`, rồi **symlink** vào từng
dự án. Dữ liệu không bị nhân bản, không bị sửa, mà mỗi dự án vẫn có đường dẫn riêng.

### 4.5 Tín hiệu và job dài

| Tín hiệu | Phím | Ý nghĩa |
|---|---|---|
| `SIGINT` (2) | `Ctrl+C` | xin dừng lịch sự |
| `SIGTSTP` (20) | `Ctrl+Z` | tạm dừng |
| `SIGTERM` (15) | `kill PID` | yêu cầu kết thúc, cho phép dọn dẹp |
| `SIGKILL` (9) | `kill -9 PID` | **giết ngay**, không dọn dẹp — biện pháp cuối cùng |

Đóng terminal → job con bị giết. Với job assembly 20 giờ, dùng **tmux**.

### 4.6 Ba tầng cài phần mềm

```
Tầng 3  CONTAINER (Docker/Apptainer)  ← chuẩn vàng, học ở M20
        toàn bộ hệ điều hành đóng gói, bất biến, có sha256

Tầng 2  MÔI TRƯỜNG CONDA              ← học ở module này
        cách ly theo dự án, xuất được environment.yml

Tầng 1  GÓI HỆ THỐNG (apt)            ← chỉ cho công cụ nền
        dùng chung toàn máy, khó tái lập
```

**Quy tắc:** `apt` cho công cụ nền (`git`, `curl`, `tmux`). **micromamba** cho mọi phần mềm tin
sinh học. **Không bao giờ** `sudo pip install`.

---

## 5. KỸ NĂNG THIẾT YẾU / Essential skills

1. Điều hướng và khảo sát hệ thống file mà không dùng chuột
2. Sao chép, di chuyển, đổi tên **an toàn** (biết khi nào lệnh sẽ đè file)
3. Khoá và bảo vệ dữ liệu thô
4. Ghép công cụ bằng pipe; tách log lỗi ra file riêng
5. Chạy và giám sát job dài; hồi phục sau mất kết nối
6. Cài phần mềm vào môi trường riêng và **xuất ra file tái lập được**
7. Kiểm tra tài nguyên: đĩa còn bao nhiêu, RAM còn bao nhiêu
8. **Đọc thông báo lỗi** và tự chẩn đoán

---

## 6. PHẦN MỀM / Software

### 6.1 WSL2 + Ubuntu 24.04 LTS

| | |
|---|---|
| **Mục đích** | Chạy kernel Linux thật trên Windows 11 — nền tảng cho toàn bộ chương trình |
| **Input** | — |
| **Output** | — |
| **Cơ chế** | Máy ảo siêu nhẹ dùng Hyper-V, kernel Linux thật, khởi động ~1 giây |
| **Ưu điểm** | Tương thích syscall đầy đủ; **truyền GPU cho Dorado**; không cần dual-boot; dùng chung file với Windows |
| **Hạn chế** | I/O qua `/mnt/c` chậm; cần cấu hình giới hạn RAM; GPU passthrough cần driver đúng |
| **Thay thế** | Dual-boot Ubuntu (nhanh nhất, phiền nhất) · VM cloud (tốn tiền, cần khi chạy PromethION) |
| **Cài đặt** | `wsl --install -d Ubuntu-24.04` trong PowerShell quyền admin |
| **Hiệu năng** | Trong `~/`: gần bằng Linux gốc. Trong `/mnt/c`: chậm 5–20× |

### 6.2 micromamba

| | |
|---|---|
| **Mục đích** | Cài phần mềm tin sinh học vào môi trường cách ly, không cần quyền root |
| **Input** | Tên gói, hoặc `environment.yml` |
| **Output** | Môi trường có thể kích hoạt; file `environment.yml` xuất ra |
| **Cơ chế** | Bộ giải phụ thuộc SAT viết bằng C++ (libsolv) — nhanh hơn conda nhiều lần |
| **Ưu điểm** | Nhanh; một file nhị phân duy nhất, không cần cài Python trước; **môi trường theo dự án = tái lập được** |
| **Hạn chế** | Môi trường vẫn có thể trôi dạt theo thời gian; **chưa đủ cho hồ sơ công nhận** — cần container (M20) |
| **Thay thế** | conda/mamba (chậm hơn) · Pixi (mới) · Docker/Apptainer (M20) |
| **Cài đặt** | Xem mục 7.6 |
| **Lệnh điển hình** | `micromamba create -n bioinfo -c conda-forge -c bioconda seqkit` |
| **Hiệu năng** | Giải phụ thuộc vài giây; tải gói phụ thuộc mạng |

> **Thứ tự channel bắt buộc: `-c conda-forge -c bioconda`.** Đảo ngược thứ tự là nguyên nhân
> phổ biến nhất của lỗi "package not found" và xung đột phiên bản.

### 6.3 tmux

| | |
|---|---|
| **Mục đích** | Giữ phiên làm việc sống độc lập với kết nối terminal |
| **Cơ chế** | Tiến trình server giữ các phiên; client gắn/tháo tuỳ ý |
| **Ưu điểm** | Job 20 giờ sống sót qua mất mạng, đóng laptop, khởi động lại terminal; chia nhiều cửa sổ |
| **Hạn chế** | Phím tắt lạ lúc đầu; không sống qua khởi động lại máy |
| **Thay thế** | `screen` (cũ hơn) · `nohup cmd &` (chạy nền nhưng không xem lại được) |
| **Lệnh điển hình** | `tmux new -s asm` → làm việc → `Ctrl+B` rồi `D` để tháo → `tmux attach -t asm` |

### 6.4 Công cụ phụ trợ

| Công cụ | Mục đích | Cài |
|---|---|---|
| `htop` | Xem CPU/RAM theo thời gian thực, giết tiến trình | `apt` |
| `tree` | Xem cây thư mục | `apt` |
| `dos2unix` | Sửa lỗi CRLF | `apt` |
| `pv` | Xem tiến độ khi truyền dữ liệu lớn qua pipe | `apt` |
| `seqkit` | Bộ dao đa năng cho FASTA/FASTQ — dùng để kiểm tra môi trường | `micromamba` |

---

## 7. LỆNH / Commands

### 7.1 Điều hướng
```bash
pwd                          # tôi đang ở đâu
ls -lh                       # liệt kê, kích thước dễ đọc
ls -lha                      # kèm file ẩn
cd ~/bioinfo/data            # chuyển thư mục
cd -                         # quay lại thư mục trước
tree -L 2 ~/bioinfo          # xem cây, sâu 2 tầng
```

### 7.2 Khảo sát file — làm trước khi mở
```bash
file run01.fastq             # đây là loại file gì thật sự?
ls -lh run01.fastq           # bao nhiêu byte
wc -l run01.fastq            # bao nhiêu dòng
head -n 8 run01.fastq        # 8 dòng đầu = 2 read FASTQ
tail -n 4 run01.fastq        # 4 dòng cuối
zcat run01.fastq.gz | head -n 8   # xem file nén mà KHÔNG giải nén
less run01.fastq             # cuộn xem; q để thoát
```
> **Không bao giờ `cat` một file FASTQ 1,4 GB.** Terminal sẽ treo. Dùng `head` hoặc `less`.

### 7.3 File và thư mục
```bash
mkdir -p ~/bioinfo/{data/{raw,processed},refs,scripts,projects,envs,notes}
cp a.fastq b.fastq           # sao chép
cp -i a.fastq b.fastq        # -i = hỏi trước khi đè  ← nên dùng
mv old.txt new.txt           # đổi tên / di chuyển
rm file.txt                  # xoá — KHÔNG có thùng rác
rm -rf thu_muc/              # xoá đệ quy — NGUY HIỂM, kiểm tra pwd trước
ln -s /data/raw/run01.pod5 ~/bioinfo/projects/p1/run01.pod5   # symlink
```

### 7.4 Quyền — và khoá dữ liệu thô
```bash
chmod 644 data.txt           # chủ đọc/ghi, còn lại đọc
chmod 755 script.sh          # chạy được
chmod +x script.sh           # thêm quyền chạy
chmod -R 444 ~/bioinfo/data/raw/     # ★ khoá toàn bộ dữ liệu thô, chỉ đọc
chmod -w ~/bioinfo/data/raw/         # ★ chính bạn cũng không ghi vào được
```

### 7.5 Luồng, redirect, pipe
```bash
seqkit stats reads.fastq > stats.txt 2> stats.err   # tách hẳn hai luồng ★
seqkit stats reads.fastq >> stats.txt               # nối thêm
zcat reads.fastq.gz | head -n 400 > sample.fastq    # pipe rồi ghi
cmd1 && cmd2                 # chạy cmd2 chỉ khi cmd1 thành công
echo $?                      # exit code của lệnh vừa chạy: 0 = OK
```

### 7.6 Cài đặt và môi trường
```bash
# công cụ nền
sudo apt update && sudo apt install -y build-essential git curl wget tree htop unzip dos2unix tmux pv

# micromamba
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba shell init -s bash -p ~/micromamba
source ~/.bashrc

# môi trường cho module này
micromamba create -y -n bioinfo -c conda-forge -c bioconda seqkit nanoplot minimap2 samtools chopper
micromamba activate bioinfo

# ★ xuất ra file tái lập được
micromamba env export -n bioinfo > ~/bioinfo/envs/bioinfo.yml

# tạo lại trên máy khác
micromamba create -n bioinfo -f bioinfo.yml
```

### 7.7 Tiến trình và job dài
```bash
htop                         # bảng điều khiển; F9 giết, q thoát
ps aux | grep flye           # tìm tiến trình theo tên
kill 12345                   # yêu cầu dừng (SIGTERM)
kill -9 12345                # giết ngay — chỉ khi bất đắc dĩ
nproc                        # số lõi CPU khả dụng
free -h                      # RAM còn bao nhiêu

tmux new -s asm              # tạo phiên tên "asm"
#   ... chạy job dài ...
#   Ctrl+B rồi D             ← tháo ra, job vẫn chạy
tmux ls                      # liệt kê phiên
tmux attach -t asm           # gắn lại
```

### 7.8 Đĩa và tải dữ liệu
```bash
df -h                        # dung lượng còn trống toàn hệ thống
du -sh ~/bioinfo/*           # thư mục nào đang chiếm bao nhiêu
du -sh . | sort -h           # sắp xếp theo kích thước

wget -c URL                  # tải, -c = tiếp tục nếu đứt
curl -L -O URL               # tải, -L = theo redirect
md5sum file.gz > file.gz.md5 # tạo checksum ★
md5sum -c file.gz.md5        # kiểm tra tính toàn vẹn ★
sha256sum file.gz            # mạnh hơn, dùng cho hồ sơ chính thức
```

### 7.9 Nén và giải nén
```bash
gzip -d file.gz              # giải nén
gunzip -k file.gz            # -k = giữ lại file nén
zcat file.gz | head          # xem mà không giải nén ★
tar -xzf archive.tar.gz      # giải nén tar.gz
tar -czf out.tar.gz thu_muc/ # nén thư mục
```

---

## 8. FILE ĐẦU VÀO / Input files

| File | Nguồn | Vai trò trong module |
|---|---|---|
| `GCF_000005845.2_ASM584v2_genomic.fna.gz` | NCBI FTP | Bộ gen *E. coli* K-12 MG1655, ~1,4 MB — vật liệu luyện tập |
| `*.md5` | tự tạo | File checksum |
| `bioinfo.yml` | tự xuất | Bản mô tả môi trường |

---

## 9. FILE ĐẦU RA / Output files

| File | Nội dung |
|---|---|
| `~/bioinfo/envs/bioinfo.yml` | Môi trường tái lập được |
| `~/bioinfo/notes/EVR_2026-07-29.md` | Environment Verification Record |
| `~/bioinfo/data/raw/*.md5` | Checksum dữ liệu thô |
| `~/bioinfo/notes/LOGBOOK.md` | Sổ tay học tập |
| `*.err` | Log stderr của mỗi lần chạy — **đây là hồ sơ kỹ thuật** |

---

## 10. VÍ DỤ PHÒNG THÍ NGHIỆM THỰC TẾ / Real laboratory examples

**Tình huống:** một run MinION 12 mẫu trả về 42 GB POD5 và 8 GB FASTQ.

| Việc cần làm | Lệnh Linux | Điều khoản ISO 17025 |
|---|---|---|
| Xác nhận file chuyển từ máy sang server không hỏng | `md5sum -c run01.md5` | §7.11.3 toàn vẹn dữ liệu |
| Khoá dữ liệu thô ngay khi nhận | `chmod -R 444 data/raw/run01/` | §7.5 hồ sơ kỹ thuật |
| Kiểm tra còn đủ chỗ trước khi chạy assembly | `df -h` | §6.4 thiết bị đủ năng lực |
| Chạy job 14 giờ qua đêm | `tmux new -s asm` | §7.2 thực hiện phương pháp |
| Lưu log của mỗi bước | `cmd > out.txt 2> run.err` | §7.11 kiểm soát dữ liệu |
| Ghi lại phiên bản phần mềm đã dùng | `micromamba env export` | §7.2.1.5 xác nhận phương pháp |

---

## 11. VÍ DỤ VI SINH / Microbiology examples

- **Thư viện chủng chuẩn:** thư mục `refs/` chứa bộ gen tham chiếu ATCC/NCTC, mỗi file kèm
  `.md5` và một `SOURCE.txt` ghi ngày tải, URL, số hiệu accession. Khoá `444`. Đây là
  "vật liệu chuẩn" phiên bản số của bạn.
- **Đặt tên nhất quán:** `2026-07-29_LM-042_R10.4.1_LSK114_barcode03.fastq.gz` —
  ngày · mã mẫu · hoá chất · kit · barcode. **Không dấu cách, không dấu tiếng Việt.**
  Dấu cách trong tên file sẽ phá vỡ mọi script bạn viết trong 20 tháng tới.

---

## 12. VÍ DỤ KIỂM NGHIỆM THỰC PHẨM / Food testing examples

Một lô 24 chủng *Listeria* từ nhà máy RTE, chạy trên hai flow cell:

```
data/raw/2026-07-29_RTE-plant-A/
├── flowcell_01/  barcode01..12/   ← chmod 444, đã checksum
├── flowcell_02/  barcode13..24/
├── MANIFEST.tsv                   ← barcode ↔ mã mẫu ↔ điểm lấy mẫu
└── CHECKSUMS.md5
```

`MANIFEST.tsv` là **mắt xích truy xuất nguồn gốc**. Không có nó, một cây cgMLST đẹp đến mấy
cũng vô giá trị vì bạn không chứng minh được lá cây nào ứng với mẫu nào. Đánh giá viên sẽ
hỏi đúng file này.

---

## 13. VÍ DỤ KIỂM NGHIỆM MÔI TRƯỜNG / Environmental testing examples

Giám sát nước thải theo tháng, 24 tháng → dữ liệu tích tụ rất nhanh.

```bash
du -sh data/raw/*/ | sort -h        # tháng nào chiếm nhiều nhất
df -h                                # còn bao nhiêu chỗ
find data/raw -name "*.pod5" -mtime +365   # POD5 cũ hơn 1 năm
```
**Quyết định phải ra trước khi bắt đầu, không phải sau:** giữ POD5 (basecall lại được bằng model
tương lai) hay chỉ giữ FASTQ (rẻ hơn nhiều)? Đây là chính sách lưu trữ theo ISO 17025 §7.5,
và là quyết định ngân sách.

---

## 14. VÍ DỤ DƯỢC PHẨM / MỸ PHẨM / Pharma & cosmetics examples

Điều tra nguồn nhiễm phòng sạch: 60 isolate environmental monitoring + 3 isolate từ sản phẩm.

**Yêu cầu 21 CFR Part 11 / ALCOA+ ánh xạ trực tiếp sang Linux:**

| ALCOA+ | Thực hiện bằng |
|---|---|
| **A**ttributable | mỗi lần chạy ghi `whoami`, `date`, `hostname` vào log |
| **L**egible | dùng **script**, không dùng GUI click chuột |
| **C**ontemporaneous | `cmd 2> run_$(date +%F_%H%M).err` — log sinh ra lúc chạy |
| **O**riginal | `chmod 444` + `sha256sum` trên dữ liệu thô |
| **A**ccurate | có control âm/dương trong mỗi lô |
| **+C**omplete | **lưu cả lần chạy thất bại**, không xoá |
| **+C**onsistent | `micromamba env export`, tiến tới container ở M20 |
| **+E**nduring | chính sách lưu trữ + checksum định kỳ |
| **+A**vailable | cấu trúc thư mục có quy tắc, tìm được trong 5 phút khi thanh tra hỏi |

---

## 15. LIÊN QUAN OXFORD NANOPORE / Oxford Nanopore relevance

| Vấn đề ONT | Vì sao cần Linux |
|---|---|
| Dorado chỉ chạy tốt trên **Linux + GPU** | WSL2 hỗ trợ GPU passthrough; đây là lý do bạn cài nó |
| POD5 nặng **1,5–3 TB / flow cell PromethION** | `df`, `du`, chính sách lưu trữ không phải tuỳ chọn |
| Basecalling `sup` chạy **nhiều giờ** | `tmux` là bắt buộc, không phải tiện ích |
| MinKNOW xuất **hàng nghìn file nhỏ** | Thao tác hàng loạt bằng shell, không thể click tay |
| Model Dorado có **phiên bản** | `micromamba` + ghi phiên bản = tái lập được |
| Nhiều barcode mỗi run | Đặt tên có quy tắc + `MANIFEST.tsv` |

**Kết luận:** không có module nào trong 24 module còn lại chạy được nếu thiếu module này.

---

## 16. LỖI THƯỜNG GẶP / Common mistakes

1. **Để dữ liệu ở `/mnt/c`** → chậm 5–20 lần. Lỗi phổ biến nhất của người mới dùng WSL2.
2. **`sudo pip install` hoặc `sudo apt install` cho công cụ tin sinh** → phá cách ly, mất truy vết phiên bản.
3. **Dấu cách hoặc dấu tiếng Việt trong tên file** → phá vỡ mọi script. Chỉ dùng `a-z 0-9 . _ -`.
4. **`cat` một file FASTQ nhiều GB** → treo terminal. Dùng `head`/`less`.
5. **Không khoá `data/raw`** → sớm muộn cũng ghi đè lên dữ liệu không thể lấy lại.
6. **Dùng `>` khi định dùng `>>`** → đè mất file kết quả tích luỹ.
7. **Bỏ qua stderr** → không có log thì không có hồ sơ, và không chẩn đoán được lỗi.
8. **Không đặt `LC_ALL=C`** → sắp xếp không ổn định, `join` sai một cách im lặng.
9. **Soạn script bằng Notepad** → lỗi CRLF `bad interpreter: ^M`.
10. **Chạy job dài không có tmux** → mất kết nối là mất 14 giờ tính toán.
11. **Đặt tất cả phần mềm vào một môi trường khổng lồ** → xung đột phụ thuộc, không tái lập.
12. **`rm -rf` mà không kiểm tra `pwd`** → Linux không có thùng rác.

---

## 17. XỬ LÝ SỰ CỐ / Troubleshooting

| Triệu chứng | Nguyên nhân | Cách sửa |
|---|---|---|
| `wsl --install` thất bại | Chưa bật ảo hoá | Bật VT-x/AMD-V trong BIOS; bật "Virtual Machine Platform" trong Windows Features |
| `micromamba: command not found` | Shell chưa nạp lại | `source ~/.bashrc` hoặc mở terminal mới |
| Gói bioconda "not found" | Sai thứ tự channel | Luôn `-c conda-forge -c bioconda`, đúng thứ tự đó |
| WSL ăn hết RAM | Chưa giới hạn | Tạo `C:\Users\<bạn>\.wslconfig` với `[wsl2]` và `memory=16GB`, rồi `wsl --shutdown` |
| `bad interpreter: /bin/bash^M` | CRLF | `dos2unix script.sh` |
| `Permission denied` khi chạy script | Thiếu quyền x | `chmod +x script.sh` |
| `No space left on device` | Hết đĩa | `df -h` rồi `du -sh */ \| sort -h` để tìm thủ phạm |
| Lệnh chạy nhưng phiên bản sai | PATH trỏ nhầm | `which <lệnh>`; kích hoạt đúng môi trường |
| Job chết khi đóng terminal | Không có tmux | `tmux new -s ten` trước khi chạy |
| Kết quả khác nhau trên hai máy | Môi trường khác | So `micromamba env export` hai bên |
| Terminal treo sau khi `cat` file lớn | Đang đổ GB ra màn hình | `Ctrl+C`; lần sau dùng `head` |

**Quy trình chẩn đoán 4 bước — làm theo thứ tự trước khi hỏi ai:**
1. **Đọc dòng cuối cùng** của thông báo lỗi. Nó thường nói đúng vấn đề.
2. `pwd` và `ls -lh` — tôi có đang đứng đúng chỗ, file có tồn tại không?
3. `which <lệnh>` và `echo $?` — đúng chương trình chưa, exit code là gì?
4. `df -h` và `free -h` — có phải hết đĩa hoặc hết RAM không?

---

## 18. THỰC HÀNH TỐT / Best practices

1. **Dữ liệu thô là bất biến.** `chmod 444` + checksum, ngay khi nhận.
2. **Một môi trường cho một dự án.** Xuất `environment.yml` vào repo của dự án.
3. **Việc gì làm quá hai lần thì viết thành script.**
4. **Luôn tách stderr ra file log.** `cmd > out 2> run_$(date +%F).err`
5. **Đặt tên file có quy tắc:** `ngày_mã-mẫu_hoá-chất_kit_barcode.đuôi`. Không dấu cách.
6. **`LC_ALL=C`** ở đầu mọi script xử lý dữ liệu.
7. **Kiểm tra `df -h` trước mọi job lớn.**
8. **tmux cho mọi việc chạy quá 10 phút.**
9. **Ghi logbook mỗi buổi** — ngày, lệnh, kết quả, quyết định.
10. **`cp -i` và `mv -i`** để tránh đè file ngoài ý muốn.
11. **Soạn file trong Linux**, không dùng Notepad.
12. **Không bao giờ xoá lần chạy thất bại** — ALCOA+ "Complete".

---

## 19. BÀI TẬP / Exercises

**BT1 — Dựng môi trường (2 giờ)**
Cài WSL2 + Ubuntu 24.04, công cụ nền, micromamba, môi trường `bioinfo`.
Nộp: kết quả `seqkit version`, `minimap2 --version`, `samtools --version | head -1`.

**BT2 — Cây thư mục bằng một lệnh (30 phút)**
Tạo toàn bộ cây `~/bioinfo` chỉ bằng **một** lệnh `mkdir -p`. Khoá `data/raw` chỉ đọc.
Chứng minh bằng `tree -L 2` và `ls -ld data/raw`.

**BT3 — Tải và bảo vệ dữ liệu thô (1 giờ)**
```bash
cd ~/bioinfo/data/raw
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
```
Tạo `sha256sum`, lưu ra file, khoá `444`, rồi **thử ghi đè** để chứng minh nó đã được bảo vệ.
Nộp: chuỗi checksum và thông báo lỗi khi cố ghi.

**BT4 — Khảo sát file mà không giải nén (45 phút)**
Không giải nén file trên, hãy trả lời: dung lượng nén? Dòng đầu tiên là gì? Có bao nhiêu dòng?
Bao nhiêu dòng bắt đầu bằng `>`? (Gợi ý: `zcat`, `head`, `wc -l`, `grep -c`.)
Con số cuối cùng đó nói lên điều gì về bộ gen này?

**BT5 — Ba luồng (1 giờ)**
Chạy một lệnh **thành công** và một lệnh **thất bại**, mỗi lần tách stdout và stderr vào hai file
riêng. Kiểm tra `echo $?` sau mỗi lần. Giải thích tại sao file stdout của lệnh thất bại lại rỗng.

**BT6 — Quyền (45 phút)**
Tạo ba file với quyền `644`, `755`, `444`. Với mỗi file, thử đọc, ghi, chạy. Ghi lại cái nào
được, cái nào không, và **vì sao**. Dùng số nào cho dữ liệu thô của một run ONT?

**BT7 — Job dài và tmux (1 giờ)**
Trong tmux, chạy `for i in $(seq 1 600); do echo "$i $(date)"; sleep 1; done > tick.log`.
Tháo phiên, đóng hẳn terminal, mở lại, gắn vào phiên cũ. Chứng minh job vẫn chạy.

**BT8 — Tái lập môi trường (1 giờ)**
Xuất `bioinfo.yml`. Tạo môi trường thứ hai tên `bioinfo_test` từ chính file đó. Chứng minh hai
môi trường có cùng phiên bản `seqkit`. Giải thích vì sao điều này liên quan tới ISO 17025 §7.11.

---

## 20. DỰ ÁN NHỎ / Mini projects

### MP1 — Environment Verification Record (3 giờ)

Soạn một tài liệu một trang theo **đúng phong cách hồ sơ đưa thiết bị vào sử dụng** của ISO 17025:

```
HỒ SƠ XÁC NHẬN MÔI TRƯỜNG TÍNH TOÁN
Mã hồ sơ:  EVR-001            Ngày: 2026-07-29
Người thực hiện: [tên]        Chữ ký: ______

1. PHẦN CỨNG      CPU / RAM / ổ đĩa trống / GPU (nếu có)
2. HỆ ĐIỀU HÀNH   Windows build · phiên bản WSL · Ubuntu · kernel
3. TRÌNH QUẢN LÝ GÓI   phiên bản micromamba
4. PHẦN MỀM ĐÃ CÀI     bảng: tên · phiên bản · channel · ngày cài
5. KIỂM TRA XÁC NHẬN   lệnh đã chạy và kết quả nhận được
6. KẾT LUẬN            môi trường phù hợp mục đích sử dụng: CÓ / KHÔNG
```
Lấy số liệu bằng: `nproc`, `free -h`, `df -h`, `uname -a`, `lsb_release -a`, `wsl --version`,
`micromamba --version`, và `micromamba list -n bioinfo`.

**Ghi lại mỗi lần môi trường thay đổi.** Đây là trang đầu tiên trong hồ sơ công nhận tương lai
của bạn — và cũng là bằng chứng đầu tiên bạn tạo ra trong nghề mới.

### MP2 — Kho dữ liệu thô (2 giờ)

Xây `~/bioinfo/data/raw/` thành một kho đúng chuẩn:
- Tải 3 bộ gen tham chiếu khác nhau từ NCBI (*E. coli*, *Listeria monocytogenes*, *Pseudomonas aeruginosa*)
- Mỗi file kèm `SOURCE.txt`: URL, accession, ngày tải, người tải
- Một `CHECKSUMS.sha256` chung cho cả thư mục
- Khoá toàn bộ `444`
- Viết `verify.sh` kiểm tra lại toàn bộ checksum và **thoát với mã 0 nếu đạt, 1 nếu sai**

Script `verify.sh` này bạn sẽ còn dùng suốt 20 tháng.

---

## 21. TỰ ĐÁNH GIÁ / Self assessment

Chấm mỗi câu 0–5. **Dưới 40/50 thì học lại** trước khi sang T1.

1. Tôi giải thích được kernel / shell / userland và đường đi của một lệnh.
2. Tôi điều hướng hệ thống file hoàn toàn bằng dòng lệnh, không cần chuột.
3. Tôi đọc được `-rw-r--r--` và chuyển qua lại với dạng số.
4. Tôi giải thích được vì sao stderr tách khỏi stdout, và tách được chúng khi chạy lệnh.
5. Tôi biết vì sao không để dữ liệu ở `/mnt/c`.
6. Tôi chạy được job dài trong tmux và gắn lại sau khi mất kết nối.
7. Tôi tạo, kích hoạt, xuất và tái tạo được môi trường micromamba.
8. Tôi khoá được dữ liệu thô và xác minh tính toàn vẹn bằng checksum.
9. Tôi tự chẩn đoán được lỗi theo quy trình 4 bước trước khi hỏi ai.
10. Tôi ánh xạ được ít nhất 5 thao tác Linux sang điều khoản ISO 17025.

---

## 22. GHI NHỚ NHANH / Revision notes

- **Kernel** phần cứng · **shell** phiên dịch · **userland** chương trình
- **Một gốc `/`**, không có ổ C: ổ D:
- **`~/` nhanh · `/mnt/c` chậm 5–20×**
- **r=4 w=2 x=1** · `644` dữ liệu · `755` script · **`444` dữ liệu thô**
- **0 stdin · 1 stdout · 2 stderr** · `> ` đè · `>>` nối · `2>` lỗi · `|` nối ống
- **Exit code 0 = thành công**
- **`LC_ALL=C`** đầu mọi script
- **tmux** cho mọi việc quá 10 phút
- **`-c conda-forge -c bioconda`** — đúng thứ tự này
- **Không bao giờ** `sudo pip install`
- **Không dấu cách** trong tên file

---

## 23. TÓM TẮT 20/80 / 20-80 summary

**20% mang lại 80% giá trị của module này:**

> Biết cài phần mềm vào một **môi trường có tên**, **xuất nó ra một file**, và **không bao giờ
> chạm vào dữ liệu thô**.

Ba việc đó là toàn bộ khác biệt giữa một người chạy được lệnh và một người có kết quả **bảo vệ
được trước đánh giá viên**. Mọi thứ còn lại trong module — pipe, quyền, tmux, tín hiệu — là
kỹ năng bổ trợ bạn sẽ tự thạo qua sử dụng.

Nếu chỉ nhớ được ba dòng lệnh, hãy nhớ ba dòng này:

```bash
micromamba create -n <dự_án> -c conda-forge -c bioconda <phần_mềm>
micromamba env export -n <dự_án> > envs/<dự_án>.yml
chmod -R 444 data/raw/
```

---

## 24. THỜI LƯỢNG & ĐỘ KHÓ

**25 giờ**, chia 5 buổi:

| Buổi | Nội dung | Giờ |
|---|---|---|
| 1 | Cài WSL2, cây hệ thống file, điều hướng, khảo sát file · BT1, BT2 | 5 |
| 2 | File, thư mục, quyền, bảo vệ dữ liệu thô, checksum · BT3, BT4, BT6 | 5 |
| 3 | Ba luồng, redirect, pipe, exit code, `LC_ALL=C` · BT5 | 5 |
| 4 | Tiến trình, tín hiệu, tmux, giám sát tài nguyên · BT7 | 5 |
| 5 | micromamba, môi trường, tái lập · BT8, MP1, MP2 | 5 |

**Độ khó ★★ Trung bình.** Không khó về trí tuệ, nhưng **dày về thao tác cơ bắp**. Phải gõ,
không đọc. Đọc xong module này mà không gõ thì coi như chưa học.

---

## 25. ĐÁNH GIÁ VIÊN ISO 17025 SẼ HỎI GÌ Ở ĐÂY?

| Câu hỏi thật của đánh giá viên | Bằng chứng bạn đưa ra |
|---|---|
| *"Anh chứng minh dữ liệu thô không bị sửa bằng cách nào?"* | `chmod 444` + `sha256sum` + `verify.sh` |
| *"Phiên bản phần mềm nào đã dùng cho kết quả này?"* | `environment.yml` gắn với dự án + logbook |
| *"Nếu máy tính hỏng, anh dựng lại môi trường thế nào?"* | `micromamba create -f bioinfo.yml` |
| *"Ai chạy phân tích này, vào lúc nào?"* | log stderr có `whoami`, `date`, `hostname` |
| *"Anh có lưu lần chạy thất bại không?"* | Có — ALCOA+ "Complete" |
| *"Máy tính có được coi là thiết bị không?"* | **Có, §6.4** — nên phải có hồ sơ đưa vào sử dụng = **MP1** |
| *"Dữ liệu thô lưu bao lâu?"* | Chính sách lưu trữ POD5/FASTQ đã viết thành văn bản |

> **Điểm mấu chốt:** trong ISO 17025, **máy tính là thiết bị**. Nó cần hồ sơ đưa vào sử dụng,
> hồ sơ thay đổi, và bằng chứng phù hợp mục đích — hệt như một tủ ấm hay một máy real-time PCR.
> Đó là lý do MP1 không phải bài tập cho vui.

---

## TIẾP THEO

**T1 — Sinh học phân tử & tiến hoá** (6 giờ, ★ Dễ, Ohlebusch ch.1 + Selzer ch.2).
Nhẹ hơn nhiều, và bạn đã biết phần lớn nội dung — mục tiêu là gắn kiến thức sinh học sẵn có
của bạn vào từ vựng mà thuật toán sử dụng. Trong lúc học M2, hãy mở **app thẻ học** bộ **T1**
và **M2** những lúc rảnh.

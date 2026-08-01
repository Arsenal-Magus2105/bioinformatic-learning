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

## Bảng trạng thái module

| Module | Bắt đầu | Hoàn thành | Tự chấm /25 | Ghi chú |
|---|---|---|---|---|
| M0 Learning roadmap | 2026-07-27 | | | |
| M2 Linux | | | | |
| T1 Sinh học phân tử & tiến hoá | | | | |
| M1 Molecular biology for NGS | | | | |
| M3 Command line | | | | |

# ⚡ Quick Start Guide

Hướng dẫn nhanh để chạy dự án trong 5 phút.

## 📋 Yêu Cầu

- Docker Desktop đã được cài đặt và đang chạy
- Git (hoặc đã có source code)

## 🚀 3 Bước Đơn Giản

### Bước 1: Clone/Download Project

```bash
git clone <repository-url>
cd GroupProject
```

### Bước 2: Cấu hình Firebase

Tạo file `.env` trong thư mục gốc:

```bash
# Windows
copy .env.example .env

# Mac/Linux
cp .env.example .env
```

Mở file `.env` và điền thông tin Firebase:
- Vào [Firebase Console](https://console.firebase.google.com/)
- Project Settings > Service Accounts > Generate New Private Key
- Copy thông tin vào file `.env`

### Bước 3: Chạy Project

```bash
docker-compose up -d --build
```

Đợi vài phút để build và khởi động...

## ✅ Kiểm Tra

```bash
# Xem status
docker-compose ps

# Xem logs
docker-compose logs -f
```

Truy cập: **http://localhost**

## 🛑 Dừng Project

```bash
docker-compose down
```

## 🔄 Restart

```bash
docker-compose restart
```

---

**Chi tiết hơn? Xem [SETUP_GUIDE.md](./SETUP_GUIDE.md)**


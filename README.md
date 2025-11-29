# 🎓 USTH Academic Suite

Hệ thống quản lý học tập và hỗ trợ sinh viên cho USTH.

## 🚀 Bắt Đầu Nhanh

### Yêu Cầu
- Docker Desktop (hoặc Docker Engine + Docker Compose)
- Git (để clone project)

### 3 Bước Đơn Giản

1. **Clone project**
   ```bash
   git clone <repository-url>
   cd GroupProject
   ```

2. **Cấu hình Firebase**
   ```bash
   # Tạo file .env
   cp .env.example .env
   # Mở file .env và điền thông tin Firebase
   ```

3. **Chạy project**
   ```bash
   docker-compose up -d --build
   ```

Truy cập: **http://localhost**

## 📚 Tài Liệu

- **[QUICK_START.md](./QUICK_START.md)** - Hướng dẫn nhanh 5 phút
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)** - Hướng dẫn setup chi tiết
- **[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - Xử lý sự cố

## 🏗️ Kiến Trúc

Dự án bao gồm các services:

- **portal-ui** - React frontend (port 80)
- **portal-api** - Mock API service (port 4000)
- **core-service** - Core service với Prisma (port 5001)
- **realtime-service** - Realtime service với Firebase (port 5002)
- **postgres** - PostgreSQL database (port 5432)

## 🛠️ Development

### Chạy development mode
```bash
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

### Xem logs
```bash
docker-compose logs -f
```

### Dừng services
```bash
docker-compose down
```

## 📝 Lưu Ý

- **Database tự động**: PostgreSQL được setup tự động, không cần cài đặt thủ công
- **Migrations tự động**: Prisma migrations chạy tự động khi core-service khởi động
- **Firebase required**: Cần cấu hình Firebase credentials trong file `.env`

## 📞 Hỗ Trợ

Xem [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) để xử lý các vấn đề thường gặp.

---

**Made with ❤️ for USTH**


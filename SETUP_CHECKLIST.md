# ✅ Setup Checklist

Checklist để đảm bảo setup thành công.

## 📋 Trước Khi Bắt Đầu

- [ ] Đã cài đặt Docker Desktop (hoặc Docker Engine + Docker Compose)
- [ ] Docker đang chạy (kiểm tra icon Docker ở system tray)
- [ ] Đã clone/download project về máy
- [ ] Đã mở terminal/command prompt trong thư mục project

## 🔧 Cài Đặt Docker

### Windows/Mac
- [ ] Đã tải Docker Desktop
- [ ] Đã cài đặt Docker Desktop
- [ ] Đã khởi động Docker Desktop
- [ ] Đã kiểm tra: `docker --version` (hiển thị version)
- [ ] Đã kiểm tra: `docker-compose --version` (hiển thị version)

### Linux
- [ ] Đã cài đặt Docker Engine
- [ ] Đã cài đặt Docker Compose
- [ ] Đã start Docker service: `sudo systemctl start docker`
- [ ] Đã kiểm tra: `docker --version`
- [ ] Đã kiểm tra: `docker-compose --version`
- [ ] Đã thêm user vào docker group (nếu cần)

## 📁 Project Setup

- [ ] Đã vào thư mục project: `cd GroupProject`
- [ ] Đã kiểm tra các file cần thiết:
  - [ ] `docker-compose.yml` tồn tại
  - [ ] `services/core/Dockerfile` tồn tại
  - [ ] `services/realtime/Dockerfile` tồn tại
  - [ ] `portal-api/Dockerfile` tồn tại
  - [ ] `portal-ui-react/Dockerfile` tồn tại

## 🔐 Cấu Hình Firebase

- [ ] Đã tạo file `.env` trong thư mục gốc
- [ ] Đã vào Firebase Console
- [ ] Đã vào Project Settings > Service Accounts
- [ ] Đã Generate New Private Key
- [ ] Đã copy `project_id` → `FIREBASE_PROJECT_ID`
- [ ] Đã copy `private_key` → `FIREBASE_PRIVATE_KEY` (với dấu ngoặc kép và `\n`)
- [ ] Đã copy `client_email` → `FIREBASE_CLIENT_EMAIL`
- [ ] Đã kiểm tra format file `.env` đúng:
  - [ ] `FIREBASE_PRIVATE_KEY` có dấu ngoặc kép `"`
  - [ ] Có `\n` trong private key
  - [ ] Không có lỗi syntax

## 🚀 Chạy Project

- [ ] Đã chạy: `docker-compose up -d --build`
- [ ] Đã đợi build hoàn tất (vài phút)
- [ ] Đã kiểm tra containers đang chạy: `docker-compose ps`
- [ ] Tất cả 5 containers có status `Up`:
  - [ ] `usth-postgres`
  - [ ] `usth-core-service`
  - [ ] `usth-realtime-service`
  - [ ] `usth-portal-api`
  - [ ] `usth-portal-ui`

## ✅ Kiểm Tra Logs

- [ ] Đã xem logs: `docker-compose logs -f`
- [ ] PostgreSQL logs hiển thị: `database system is ready`
- [ ] Core service logs hiển thị:
  - [ ] `PostgreSQL is ready!`
  - [ ] `Migrations completed!`
  - [ ] `Core service running on http://localhost:5001`
- [ ] Realtime service logs hiển thị: `Realtime service running on http://localhost:5002`
- [ ] Portal API logs hiển thị: `Portal API running on http://localhost:4000`
- [ ] Không có lỗi nghiêm trọng trong logs

## 🌐 Kiểm Tra Truy Cập

- [ ] Đã mở trình duyệt
- [ ] Đã truy cập http://localhost
- [ ] Frontend hiển thị (không lỗi 404)
- [ ] Đã truy cập http://localhost:4000/api/portal-data
- [ ] API trả về JSON data
- [ ] Đã truy cập http://localhost:5001/health
- [ ] Health check trả về OK

## 🗄️ Kiểm Tra Database

- [ ] Đã vào PostgreSQL container: `docker-compose exec postgres psql -U usth_user -d usth_academic`
- [ ] Đã kiểm tra tables: `\dt`
- [ ] Có các tables:
  - [ ] `User`
  - [ ] `Subject`
  - [ ] `Class`
  - [ ] `Room`
  - [ ] `Enrollment`
  - [ ] `ClassSchedule`
  - [ ] `Notification`
  - [ ] `Request`
- [ ] Đã thoát: `\q`

## 🎯 Hoàn Thành

- [ ] Tất cả services đang chạy
- [ ] Có thể truy cập frontend
- [ ] Database đã được setup
- [ ] Không có lỗi trong logs
- [ ] Project hoạt động chính xác

## 📝 Ghi Chú

Nếu có bước nào không hoàn thành:
- Xem [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
- Xem logs: `docker-compose logs -f`
- Kiểm tra status: `docker-compose ps`

---

**Chúc bạn setup thành công! 🎉**


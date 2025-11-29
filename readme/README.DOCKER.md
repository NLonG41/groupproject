# Docker Setup Guide

Hướng dẫn chạy dự án USTH Academic Suite bằng Docker. **Tất cả đã được tự động hóa, không cần cài đặt PostgreSQL thủ công!**

## ✨ Tính năng tự động

- ✅ **PostgreSQL tự động**: Database được tạo và setup tự động trong container
- ✅ **Migrations tự động**: Prisma migrations chạy tự động khi core-service khởi động
- ✅ **Không cần cài đặt thủ công**: Chỉ cần Docker và Docker Compose
- ✅ **Zero configuration**: Database, user, và schema đều được setup tự động

## Yêu cầu

- Docker Engine 20.10+
- Docker Compose 2.0+
- **KHÔNG CẦN** cài đặt PostgreSQL trên máy

## Cấu trúc Services

- **postgres**: PostgreSQL database (port 5432) - **Tự động setup**
- **core-service**: Core service với Prisma (port 5001) - **Tự động chạy migrations**
- **realtime-service**: Realtime service với Firebase (port 5002)
- **portal-api**: Mock API service (port 4000)
- **portal-ui**: React frontend (port 80)

## Production Mode

### 1. Tạo file .env

```bash
cp .env.example .env
```

Chỉnh sửa file `.env` với thông tin Firebase của bạn:
- `FIREBASE_PROJECT_ID`
- `FIREBASE_PRIVATE_KEY`
- `FIREBASE_CLIENT_EMAIL`

### 2. Build và chạy containers

```bash
# Build và start tất cả services
docker-compose up -d --build

# Xem logs
docker-compose logs -f

# Xem logs của một service cụ thể
docker-compose logs -f core-service
```

**Lần đầu chạy sẽ:**
1. Tải PostgreSQL image
2. Tạo PostgreSQL container với database `usth_academic`
3. Tự động chạy Prisma migrations để tạo schema
4. Khởi động tất cả services

### 3. Truy cập ứng dụng

- Frontend: http://localhost
- Portal API: http://localhost:4000
- Core Service: http://localhost:5001
- Realtime Service: http://localhost:5002
- PostgreSQL: localhost:5432 (user: `usth_user`, password: `usth_password`, db: `usth_academic`)

### 4. Dừng services

```bash
# Dừng tất cả services
docker-compose down

# Dừng và xóa volumes (xóa database - cẩn thận!)
docker-compose down -v
```

## Development Mode

Sử dụng development mode với hot reload:

```bash
# Chạy với development overrides
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build

# Hoặc chỉ chạy một số services
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up postgres core-service
```

## Database

### Tự động setup

Database được setup hoàn toàn tự động:
- PostgreSQL container tự động tạo database `usth_academic`
- User `usth_user` được tạo tự động
- Prisma migrations chạy tự động khi core-service khởi động
- Schema được tạo tự động từ migrations

### Kết nối database

**Từ host machine:**
```bash
psql -h localhost -U usth_user -d usth_academic
# Password: usth_password
```

**Từ container:**
```bash
docker-compose exec postgres psql -U usth_user -d usth_academic
```

### Manual migrations (nếu cần)

```bash
# Vào container
docker-compose exec core-service sh

# Chạy migrations
npx prisma migrate deploy

# Hoặc tạo migration mới (development)
npx prisma migrate dev --name migration_name
```

### Reset database (nếu cần)

```bash
# Xóa tất cả data và volumes
docker-compose down -v

# Khởi động lại (sẽ tạo lại database và chạy migrations)
docker-compose up -d --build
```

## Troubleshooting

### Xem logs

```bash
# Tất cả services
docker-compose logs

# Một service cụ thể
docker-compose logs core-service

# Follow logs
docker-compose logs -f core-service
```

### Rebuild một service

```bash
docker-compose build core-service
docker-compose up -d core-service
```

### Xóa và rebuild tất cả

```bash
docker-compose down -v
docker-compose up -d --build
```

### Kiểm tra database connection

```bash
# Vào PostgreSQL container
docker-compose exec postgres psql -U usth_user -d usth_academic

# Kiểm tra tables
\dt

# Xem users
SELECT * FROM "User";
```

### Database không kết nối được

1. Kiểm tra PostgreSQL container đang chạy:
   ```bash
   docker-compose ps postgres
   ```

2. Kiểm tra logs:
   ```bash
   docker-compose logs postgres
   ```

3. Kiểm tra network:
   ```bash
   docker network inspect groupproject_usth-network
   ```

## Environment Variables

### Core Service
- `PORT`: Port của service (default: 5001)
- `DATABASE_URL`: PostgreSQL connection string (tự động từ docker-compose)
- `EVENT_BROKER_URL`: URL của event broker (optional)

### Realtime Service
- `PORT`: Port của service (default: 5002)
- `FIREBASE_PROJECT_ID`: Firebase project ID
- `FIREBASE_PRIVATE_KEY`: Firebase private key
- `FIREBASE_CLIENT_EMAIL`: Firebase client email

### Portal API
- `PORT`: Port của service (default: 4000)

### PostgreSQL (tự động)
- `POSTGRES_USER`: usth_user
- `POSTGRES_PASSWORD`: usth_password
- `POSTGRES_DB`: usth_academic

## Volumes

- `postgres_data`: PostgreSQL data persistence (database được lưu ở đây)
- `portal-api-data`: Portal API data files
- `portal-api-logs`: Portal API log files

## Networks

Tất cả services được kết nối qua network `usth-network` để có thể giao tiếp với nhau.

## Lưu ý quan trọng

1. **Database tự động**: Không cần cài đặt PostgreSQL trên máy, mọi thứ chạy trong container
2. **Migrations tự động**: Migrations chạy tự động khi core-service khởi động
3. **Data persistence**: Database data được lưu trong Docker volume, không mất khi restart container
4. **Reset database**: Dùng `docker-compose down -v` để xóa và tạo lại database

# 🔧 Troubleshooting Guide

Hướng dẫn xử lý các vấn đề thường gặp.

## ❌ Vấn Đề Thường Gặp

### 1. Docker không chạy

**Triệu chứng:**
```
Cannot connect to the Docker daemon
```

**Giải pháp:**
- **Windows/Mac**: Mở Docker Desktop và đợi nó khởi động hoàn toàn
- **Linux**: 
  ```bash
  sudo systemctl start docker
  sudo systemctl enable docker
  ```

### 2. Port đã được sử dụng

**Triệu chứng:**
```
Error: port 80 is already allocated
```

**Giải pháp:**

**Windows:**
```powershell
# Tìm process đang dùng port 80
netstat -ano | findstr :80
# Kill process (thay PID bằng process ID)
taskkill /PID <PID> /F
```

**Mac/Linux:**
```bash
# Tìm process
lsof -i :80
# Kill process
kill -9 <PID>
```

**Hoặc thay đổi port trong docker-compose.yml:**
```yaml
portal-ui:
  ports:
    - "8080:80"  # Thay vì 80:80
```

### 3. Firebase Authentication Failed

**Triệu chứng:**
```
Error in realtime-service logs: Firebase authentication error
```

**Giải pháp:**

1. Kiểm tra file `.env`:
   ```bash
   cat .env
   ```

2. Đảm bảo format đúng:
   ```env
   FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   ```
   - Phải có dấu ngoặc kép `"`
   - Phải có `\n` giữa các dòng
   - Không có khoảng trắng thừa

3. Kiểm tra logs chi tiết:
   ```bash
   docker-compose logs realtime-service
   ```

4. Restart service:
   ```bash
   docker-compose restart realtime-service
   ```

### 4. Database Migration Failed

**Triệu chứng:**
```
Error: Migration failed in core-service logs
```

**Giải pháp:**

**Option 1: Reset database**
```bash
docker-compose down -v
docker-compose up -d --build
```

**Option 2: Chạy migrations thủ công**
```bash
docker-compose exec core-service npx prisma migrate deploy
```

**Option 3: Xem logs chi tiết**
```bash
docker-compose logs core-service
```

### 5. Container Không Start

**Triệu chứng:**
```
Container exits immediately
```

**Giải pháp:**

1. Xem logs:
   ```bash
   docker-compose logs <service-name>
   ```

2. Rebuild container:
   ```bash
   docker-compose build --no-cache <service-name>
   docker-compose up -d <service-name>
   ```

3. Kiểm tra Docker resources:
   - Windows/Mac: Docker Desktop > Settings > Resources
   - Đảm bảo có đủ RAM (tối thiểu 4GB)

### 6. Không Truy Cập Được Frontend

**Triệu chứng:**
```
Cannot access http://localhost
```

**Giải pháp:**

1. Kiểm tra container đang chạy:
   ```bash
   docker-compose ps portal-ui
   ```

2. Xem logs:
   ```bash
   docker-compose logs portal-ui
   ```

3. Kiểm tra port:
   ```bash
   # Windows
   netstat -ano | findstr :80
   
   # Mac/Linux
   lsof -i :80
   ```

4. Thử rebuild:
   ```bash
   docker-compose build --no-cache portal-ui
   docker-compose up -d portal-ui
   ```

### 7. PostgreSQL Connection Error

**Triệu chứng:**
```
Error: connect ECONNREFUSED postgres:5432
```

**Giải pháp:**

1. Kiểm tra PostgreSQL container:
   ```bash
   docker-compose ps postgres
   ```

2. Xem logs:
   ```bash
   docker-compose logs postgres
   ```

3. Đợi PostgreSQL sẵn sàng:
   ```bash
   # Kiểm tra health
   docker-compose exec postgres pg_isready -U usth_user -d usth_academic
   ```

4. Restart:
   ```bash
   docker-compose restart postgres
   # Đợi vài giây rồi restart core-service
   docker-compose restart core-service
   ```

### 8. Out of Memory

**Triệu chứng:**
```
Container killed: out of memory
```

**Giải pháp:**

1. Tăng Docker memory limit:
   - Windows/Mac: Docker Desktop > Settings > Resources > Memory
   - Tăng lên ít nhất 4GB (khuyến nghị 8GB)

2. Hoặc chạy ít services hơn:
   ```bash
   # Chỉ chạy database và core-service
   docker-compose up -d postgres core-service
   ```

### 9. Build Failed

**Triệu chứng:**
```
Error during build process
```

**Giải pháp:**

1. Xóa cache và rebuild:
   ```bash
   docker-compose build --no-cache
   ```

2. Kiểm tra disk space:
   ```bash
   # Windows
   dir
   
   # Mac/Linux
   df -h
   ```

3. Xóa images cũ:
   ```bash
   docker system prune -a
   ```

### 10. Permission Denied (Linux)

**Triệu chứng:**
```
Permission denied: /var/run/docker.sock
```

**Giải pháp:**

```bash
# Thêm user vào docker group
sudo usermod -aG docker $USER

# Đăng xuất và đăng nhập lại, hoặc:
newgrp docker
```

## 🔍 Debug Commands

### Xem tất cả logs
```bash
docker-compose logs -f
```

### Xem logs của một service
```bash
docker-compose logs -f <service-name>
```

### Kiểm tra status
```bash
docker-compose ps
```

### Vào container để debug
```bash
docker-compose exec <service-name> sh
```

### Kiểm tra network
```bash
docker network inspect groupproject_usth-network
```

### Kiểm tra volumes
```bash
docker volume ls
docker volume inspect groupproject_postgres_data
```

### Xem resource usage
```bash
docker stats
```

## 🔄 Reset Hoàn Toàn

Nếu mọi thứ không hoạt động, reset hoàn toàn:

```bash
# Dừng và xóa tất cả
docker-compose down -v

# Xóa images (optional)
docker-compose down --rmi all

# Xóa tất cả containers và volumes
docker system prune -a --volumes

# Rebuild từ đầu
docker-compose up -d --build
```

## 📞 Cần Hỗ Trợ?

1. Thu thập thông tin:
   ```bash
   # Logs
   docker-compose logs > logs.txt
   
   # Status
   docker-compose ps > status.txt
   
   # Docker info
   docker info > docker-info.txt
   ```

2. Gửi các file này cùng với mô tả vấn đề cho team

---

**Xem thêm: [SETUP_GUIDE.md](./SETUP_GUIDE.md)**


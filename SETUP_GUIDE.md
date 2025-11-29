# 🚀 Hướng Dẫn Setup Dự Án USTH Academic Suite

Hướng dẫn chi tiết để setup và chạy dự án trên thiết bị mới.

## 📋 Yêu Cầu Hệ Thống

### Phần Mềm Cần Thiết

1. **Docker Desktop** (hoặc Docker Engine + Docker Compose)
   - Windows: [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - Mac: [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - Linux: 
     ```bash
     # Ubuntu/Debian
     sudo apt-get update
     sudo apt-get install docker.io docker-compose
     sudo systemctl start docker
     sudo systemctl enable docker
     ```

2. **Git** (để clone project)
   - Windows: [Download Git](https://git-scm.com/download/win)
   - Mac: `brew install git` hoặc [Download](https://git-scm.com/download/mac)
   - Linux: `sudo apt-get install git`

3. **Text Editor** (để chỉnh sửa file .env)
   - VS Code, Notepad++, hoặc bất kỳ editor nào

### Yêu Cầu Phần Cứng

- **RAM**: Tối thiểu 4GB (khuyến nghị 8GB)
- **Disk Space**: Tối thiểu 5GB trống
- **CPU**: Bất kỳ CPU hiện đại nào

## 📦 Bước 1: Cài Đặt Docker

### Windows

1. Tải Docker Desktop từ [docker.com](https://www.docker.com/products/docker-desktop/)
2. Chạy file installer và làm theo hướng dẫn
3. Khởi động lại máy nếu được yêu cầu
4. Mở Docker Desktop và đợi nó khởi động hoàn toàn
5. Kiểm tra cài đặt:
   ```powershell
   docker --version
   docker-compose --version
   ```

### Mac

1. Tải Docker Desktop từ [docker.com](https://www.docker.com/products/docker-desktop/)
2. Kéo Docker vào Applications folder
3. Mở Docker Desktop từ Applications
4. Kiểm tra cài đặt:
   ```bash
   docker --version
   docker-compose --version
   ```

### Linux (Ubuntu/Debian)

```bash
# Cập nhật package list
sudo apt-get update

# Cài đặt dependencies
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Thêm Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setup repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cài đặt Docker Engine và Docker Compose
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Thêm user vào docker group (để chạy docker không cần sudo)
sudo usermod -aG docker $USER

# Khởi động lại hoặc đăng xuất/đăng nhập lại
```

## 📥 Bước 2: Clone Project

### Từ Git Repository

```bash
# Clone project
git clone <repository-url>
cd GroupProject

# Hoặc nếu đã có project, pull latest changes
git pull origin master
```

### Từ File ZIP

1. Giải nén file ZIP vào thư mục bạn muốn
2. Mở terminal/command prompt trong thư mục đó

## ⚙️ Bước 3: Cấu Hình Environment Variables

### 3.1. Tạo file .env

Trong thư mục gốc của project, tạo file `.env`:

**Windows (PowerShell):**
```powershell
Copy-Item .env.example .env
# Hoặc tạo file mới
New-Item -Path .env -ItemType File
```

**Mac/Linux:**
```bash
cp .env.example .env
# Hoặc nếu không có .env.example
touch .env
```

### 3.2. Cấu hình Firebase

Mở file `.env` và điền thông tin Firebase của bạn:

```env
# Firebase Configuration for Realtime Service
FIREBASE_PROJECT_ID=web-portal-us
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY_HERE\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@web-portal-us.iam.gserviceaccount.com

# Event Broker URL (optional, để trống nếu không dùng)
EVENT_BROKER_URL=
```

**Lấy thông tin Firebase:**

1. Vào [Firebase Console](https://console.firebase.google.com/)
2. Chọn project của bạn
3. Vào **Project Settings** > **Service Accounts**
4. Click **Generate New Private Key**
5. File JSON sẽ được tải về
6. Mở file JSON và copy:
   - `project_id` → `FIREBASE_PROJECT_ID`
   - `private_key` → `FIREBASE_PRIVATE_KEY` (giữ nguyên dấu ngoặc kép và `\n`)
   - `client_email` → `FIREBASE_CLIENT_EMAIL`

**Lưu ý quan trọng:**
- `FIREBASE_PRIVATE_KEY` phải được đặt trong dấu ngoặc kép `"`
- Giữ nguyên các ký tự `\n` trong private key
- Không có khoảng trắng thừa

**Ví dụ đúng:**
```env
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC...\n-----END PRIVATE KEY-----\n"
```

## 🚀 Bước 4: Chạy Dự Án

### 4.1. Kiểm tra Docker đang chạy

**Windows/Mac:**
- Mở Docker Desktop và đảm bảo nó đang chạy (icon Docker ở system tray)

**Linux:**
```bash
sudo systemctl status docker
```

### 4.2. Build và khởi động containers

Trong thư mục gốc của project:

**Windows (PowerShell):**
```powershell
docker-compose up -d --build
```

**Mac/Linux:**
```bash
docker-compose up -d --build
```

Lần đầu chạy sẽ mất vài phút để:
- Tải các Docker images
- Build các services
- Tạo PostgreSQL database
- Chạy migrations

### 4.3. Kiểm tra logs

```bash
# Xem logs của tất cả services
docker-compose logs -f

# Xem logs của một service cụ thể
docker-compose logs -f core-service
docker-compose logs -f postgres
```

**Đợi đến khi thấy:**
- `PostgreSQL is ready!`
- `Migrations completed!`
- `Core service running on http://localhost:5001`
- `Realtime service running on http://localhost:5002`
- `Portal API running on http://localhost:4000`

## ✅ Bước 5: Kiểm Tra Dự Án Đã Chạy

### 5.1. Kiểm tra containers đang chạy

```bash
docker-compose ps
```

Bạn sẽ thấy 5 containers:
- `usth-postgres` - PostgreSQL database
- `usth-core-service` - Core service
- `usth-realtime-service` - Realtime service
- `usth-portal-api` - Portal API
- `usth-portal-ui` - Frontend

Tất cả phải có status `Up` (healthy).

### 5.2. Truy cập ứng dụng

Mở trình duyệt và truy cập:

- **Frontend**: http://localhost
- **Portal API**: http://localhost:4000/api/portal-data
- **Core Service Health**: http://localhost:5001/health
- **Realtime Service**: http://localhost:5002

### 5.3. Kiểm tra database

```bash
# Vào PostgreSQL container
docker-compose exec postgres psql -U usth_user -d usth_academic

# Kiểm tra tables
\dt

# Xem danh sách users
SELECT id, email, role, "fullName" FROM "User";

# Thoát
\q
```

## 🛠️ Bước 6: Troubleshooting

### Vấn đề: Docker không chạy

**Giải pháp:**
- Windows/Mac: Mở Docker Desktop và đợi nó khởi động hoàn toàn
- Linux: `sudo systemctl start docker`

### Vấn đề: Port đã được sử dụng

**Lỗi:** `port is already allocated`

**Giải pháp:**
1. Kiểm tra port nào đang được dùng:
   ```bash
   # Windows
   netstat -ano | findstr :80
   netstat -ano | findstr :4000
   
   # Mac/Linux
   lsof -i :80
   lsof -i :4000
   ```

2. Dừng service đang dùng port đó, hoặc
3. Thay đổi port trong `docker-compose.yml`:
   ```yaml
   ports:
     - "8080:80"  # Thay vì 80:80
   ```

### Vấn đề: Firebase authentication failed

**Lỗi:** `Firebase authentication error` trong logs của realtime-service

**Giải pháp:**
1. Kiểm tra file `.env` có đúng format không
2. Đảm bảo `FIREBASE_PRIVATE_KEY` có dấu ngoặc kép và `\n`
3. Kiểm tra `FIREBASE_PROJECT_ID` và `FIREBASE_CLIENT_EMAIL` đúng chưa
4. Xem logs chi tiết:
   ```bash
   docker-compose logs realtime-service
   ```

### Vấn đề: Database migrations failed

**Lỗi:** `Migration failed` trong logs của core-service

**Giải pháp:**
```bash
# Xóa database và tạo lại
docker-compose down -v
docker-compose up -d --build

# Hoặc chạy migrations thủ công
docker-compose exec core-service npx prisma migrate deploy
```

### Vấn đề: Container không start

**Giải pháp:**
```bash
# Xem logs chi tiết
docker-compose logs <service-name>

# Rebuild container
docker-compose build --no-cache <service-name>
docker-compose up -d <service-name>

# Hoặc rebuild tất cả
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Vấn đề: Không truy cập được frontend

**Kiểm tra:**
1. Container `usth-portal-ui` đang chạy:
   ```bash
   docker-compose ps portal-ui
   ```

2. Xem logs:
   ```bash
   docker-compose logs portal-ui
   ```

3. Kiểm tra port 80:
   ```bash
   # Windows
   netstat -ano | findstr :80
   
   # Mac/Linux
   lsof -i :80
   ```

## 📝 Các Lệnh Thường Dùng

### Dừng services
```bash
docker-compose down
```

### Dừng và xóa tất cả data (reset hoàn toàn)
```bash
docker-compose down -v
```

### Xem logs
```bash
# Tất cả services
docker-compose logs -f

# Một service
docker-compose logs -f core-service
```

### Restart một service
```bash
docker-compose restart core-service
```

### Rebuild một service
```bash
docker-compose build core-service
docker-compose up -d core-service
```

### Vào container để debug
```bash
# Vào core-service
docker-compose exec core-service sh

# Vào postgres
docker-compose exec postgres psql -U usth_user -d usth_academic
```

## 🎯 Checklist Setup

- [ ] Docker đã được cài đặt và đang chạy
- [ ] Project đã được clone/download
- [ ] File `.env` đã được tạo và cấu hình Firebase
- [ ] Đã chạy `docker-compose up -d --build`
- [ ] Tất cả containers đang chạy (kiểm tra bằng `docker-compose ps`)
- [ ] Có thể truy cập http://localhost
- [ ] Database đã được tạo và migrations đã chạy

## 📞 Hỗ Trợ

Nếu gặp vấn đề, hãy:
1. Xem logs: `docker-compose logs -f`
2. Kiểm tra status: `docker-compose ps`
3. Thử rebuild: `docker-compose down && docker-compose up -d --build`
4. Liên hệ team để được hỗ trợ

## 🔄 Cập Nhật Project

Khi có code mới:

```bash
# Pull latest code
git pull origin master

# Rebuild và restart
docker-compose down
docker-compose up -d --build
```

---

**Chúc bạn setup thành công! 🎉**


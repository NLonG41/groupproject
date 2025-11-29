@echo off
REM Quick start script for Docker setup (Windows)

echo 🚀 Starting USTH Academic Suite with Docker...

REM Check if .env file exists
if not exist .env (
    echo ⚠️  .env file not found. Creating from .env.example...
    if exist .env.example (
        copy .env.example .env
        echo ✅ Created .env file. Please edit it with your Firebase credentials.
    ) else (
        echo ❌ .env.example not found. Please create .env file manually.
        exit /b 1
    )
)

REM Build and start containers
echo 📦 Building and starting containers...
docker-compose up -d --build

REM Wait for services to be ready
echo ⏳ Waiting for services to start...
timeout /t 5 /nobreak >nul

REM Show status
echo.
echo ✅ Services started! Status:
docker-compose ps

echo.
echo 🌐 Access the application at:
echo    - Frontend: http://localhost
echo    - Portal API: http://localhost:4000
echo    - Core Service: http://localhost:5001
echo    - Realtime Service: http://localhost:5002
echo.
echo 📋 View logs with: docker-compose logs -f
echo 🛑 Stop services with: docker-compose down

pause


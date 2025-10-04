@echo off
REM Jenkins Setup Script for Windows
echo 🚀 Setting up Jenkins with Docker...

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker first.
    exit /b 1
)

echo ✅ Docker is running

REM Start Jenkins using Docker Compose
echo 🐳 Starting Jenkins container...
docker-compose up -d

REM Wait for Jenkins to start
echo ⏳ Waiting for Jenkins to start (this may take a few minutes)...
timeout /t 30 /nobreak >nul

REM Check if Jenkins is running
docker ps | findstr jenkins-master >nul
if %errorlevel% equ 0 (
    echo ✅ Jenkins is running!
    echo.
    echo 📋 Jenkins Setup Information:
    echo    URL: http://localhost:8080
    echo.
    echo 🔐 Initial Admin Password:
    docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword 2>nul || echo    Password not ready yet, please wait a moment and run:
    echo    docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
    echo.
    echo 📝 Next Steps:
    echo    1. Open http://localhost:8080 in your browser
    echo    2. Enter the initial admin password shown above
    echo    3. Install suggested plugins
    echo    4. Create an admin user
    echo    5. Create a new Pipeline job
    echo    6. Configure it to use your Git repository and the Jenkinsfile
) else (
    echo ❌ Failed to start Jenkins. Check the logs:
    echo    docker-compose logs jenkins
)

pause
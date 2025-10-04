@echo off
REM Manual Pipeline Test Script for Windows
REM This simulates what Jenkins will do

echo 🚀 Starting Manual Pipeline Test...

echo 📁 Stage 1: Checkout
echo ✅ Source code already available

echo 🔨 Stage 2: Build
echo Running: mvn clean compile
call .\mvnw.cmd clean compile
if %errorlevel% neq 0 (
    echo ❌ Build failed!
    exit /b 1
)
echo ✅ Build successful

echo 🧪 Stage 3: Test
echo Running: mvn test
call .\mvnw.cmd test
if %errorlevel% neq 0 (
    echo ❌ Tests failed!
    exit /b 1
)
echo ✅ Tests passed

echo 📦 Stage 4: Package
echo Running: mvn package -DskipTests
call .\mvnw.cmd package -DskipTests
if %errorlevel% neq 0 (
    echo ❌ Packaging failed!
    exit /b 1
)
echo ✅ Packaging successful

echo 🔍 Stage 5: Code Quality Analysis
echo Running: mvn verify
call .\mvnw.cmd verify
if %errorlevel% neq 0 (
    echo ❌ Verification failed!
    exit /b 1
)
echo ✅ Verification passed

echo 🎉 All stages completed successfully!
echo 📄 Artifacts created:
dir target\*.jar

echo 🌐 Application ready for deployment!
pause
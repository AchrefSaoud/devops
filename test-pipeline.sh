#!/bin/bash
# Manual Pipeline Test Script
# This simulates what Jenkins will do

echo "🚀 Starting Manual Pipeline Test..."

echo "📁 Stage 1: Checkout"
echo "✅ Source code already available"

echo "🔨 Stage 2: Build"
echo "Running: mvn clean compile"
./mvnw.cmd clean compile
if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi
echo "✅ Build successful"

echo "🧪 Stage 3: Test"
echo "Running: mvn test"
./mvnw.cmd test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed!"
    exit 1
fi
echo "✅ Tests passed"

echo "📦 Stage 4: Package"
echo "Running: mvn package -DskipTests"
./mvnw.cmd package -DskipTests
if [ $? -ne 0 ]; then
    echo "❌ Packaging failed!"
    exit 1
fi
echo "✅ Packaging successful"

echo "🔍 Stage 5: Code Quality Analysis"
echo "Running: mvn verify"
./mvnw.cmd verify
if [ $? -ne 0 ]; then
    echo "❌ Verification failed!"
    exit 1
fi
echo "✅ Verification passed"

echo "🎉 All stages completed successfully!"
echo "📄 Artifacts created:"
ls -la target/*.jar

echo "🌐 Application ready for deployment!"
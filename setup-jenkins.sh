#!/bin/bash

# Jenkins Setup Script
echo "🚀 Setting up Jenkins with Docker..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "✅ Docker is running"

# Start Jenkins using Docker Compose
echo "🐳 Starting Jenkins container..."
docker-compose up -d

# Wait for Jenkins to start
echo "⏳ Waiting for Jenkins to start (this may take a few minutes)..."
sleep 30

# Check if Jenkins is running
if docker ps | grep -q jenkins-master; then
    echo "✅ Jenkins is running!"
    echo ""
    echo "📋 Jenkins Setup Information:"
    echo "   URL: http://localhost:8080"
    echo ""
    echo "🔐 Initial Admin Password:"
    docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null || echo "   Password not ready yet, please wait a moment and run:"
    echo "   docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword"
    echo ""
    echo "📝 Next Steps:"
    echo "   1. Open http://localhost:8080 in your browser"
    echo "   2. Enter the initial admin password shown above"
    echo "   3. Install suggested plugins"
    echo "   4. Create an admin user"
    echo "   5. Create a new Pipeline job"
    echo "   6. Configure it to use your Git repository and the Jenkinsfile"
else
    echo "❌ Failed to start Jenkins. Check the logs:"
    echo "   docker-compose logs jenkins"
fi
# Quick Start Guide - Jenkins CI/CD Pipeline

## 🚀 Quick Setup (Windows)

### 1. Prerequisites
- **Docker Desktop** installed and running
- **Git** installed
- **Java 17+** (for local development)

### 2. Start Jenkins
```bash
# Option 1: Use the provided script
.\setup-jenkins.bat

# Option 2: Manual start
docker-compose up -d
```

### 3. Access Jenkins
1. Open: http://localhost:8080
2. Get initial password:
   ```bash
   docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. Install suggested plugins
4. Create admin user

### 4. Create Pipeline Job
1. **New Item** → **Pipeline**
2. **Pipeline** section:
   - Definition: "Pipeline script from SCM"
   - SCM: Git
   - Repository URL: [Your Git Repository]
   - Script Path: `Jenkinsfile`

### 5. Test Your Application Locally
```bash
# Build and test
.\mvnw.cmd clean package

# Run the application
java -jar target/spring-jenkins-demo-1.0.0.jar

# Test endpoints
curl http://localhost:8080/
curl http://localhost:8080/health
```

## 📋 Pipeline Stages

1. **Checkout** - Get source code
2. **Build** - Compile Java code
3. **Test** - Run unit tests
4. **Package** - Create JAR file
5. **Code Quality** - Additional checks
6. **Deploy** - Deploy to staging (main branch only)

## 🔧 Troubleshooting

### Common Issues:

**Port 8080 in use:**
- Change port in `application.properties`: `server.port=8081`
- Update `docker-compose.yml` and `Dockerfile` accordingly

**Docker permission errors:**
- Ensure Docker Desktop is running
- Try running as administrator

**Jenkins not starting:**
```bash
# Check logs
docker-compose logs jenkins

# Restart containers
docker-compose restart
```

**Build failures:**
- Ensure Java 17+ is available in the Docker container
- Check Maven dependencies are accessible

### Jenkins Configuration Tips:

1. **Add Docker plugin** in Jenkins if not already installed
2. **Configure Java** in Global Tool Configuration
3. **Set up Git credentials** for private repositories
4. **Configure webhooks** for automatic builds on push

## 🏗️ Project Structure
```
devops/
├── src/                           # Source code
├── target/                        # Build output
├── Jenkinsfile                    # Pipeline definition
├── docker-compose.yml             # Jenkins setup
├── Dockerfile                     # App containerization
├── pom.xml                        # Maven configuration
├── README.md                      # Full documentation
└── setup-jenkins.bat              # Windows setup script
```

## 🌐 Endpoints

| Endpoint | Description |
|----------|-------------|
| http://localhost:8080/ | Main application |
| http://localhost:8080/health | Custom health check |
| http://localhost:8080/actuator/health | Spring Boot health |

## 📝 Next Steps

1. **Push to Git** repository
2. **Configure webhook** for automatic builds
3. **Add deployment stages** for production
4. **Integrate with SonarQube** for code quality
5. **Add notifications** (Slack, email)
6. **Set up monitoring** with Prometheus/Grafana

## 🛑 Stop Everything

```bash
# Stop Jenkins
docker-compose down

# Remove everything (including volumes)
docker-compose down -v
```

---
✅ **Success!** You now have a working Spring Boot application with Jenkins CI/CD pipeline!
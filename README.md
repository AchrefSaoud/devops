# Spring Boot Jenkins Pipeline Demo

This project demonstrates a simple Spring Boot application with a Jenkins CI/CD pipeline using Docker.

## Project Structure

```
├── src/
│   ├── main/
│   │   ├── java/com/example/springjenkinsdemo/
│   │   │   ├── SpringJenkinsDemoApplication.java
│   │   │   └── controller/HelloController.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/example/springjenkinsdemo/
│           ├── SpringJenkinsDemoApplicationTests.java
│           └── controller/HelloControllerTest.java
├── Jenkinsfile
├── docker-compose.yml
├── Dockerfile
└── pom.xml
```

## Prerequisites

- Java 17+
- Maven 3.6+
- Docker and Docker Compose
- Git

## Running the Application Locally

1. **Build the application:**
   ```bash
   mvn clean compile
   ```

2. **Run tests:**
   ```bash
   mvn test
   ```

3. **Package the application:**
   ```bash
   mvn package
   ```

4. **Run the application:**
   ```bash
   java -jar target/spring-jenkins-demo-1.0.0.jar
   ```

5. **Access the application:**
   - Main endpoint: http://localhost:8080/
   - Health endpoint: http://localhost:8080/health
   - Health actuator: http://localhost:8080/actuator/health

## Setting up Jenkins with Docker

1. **Start Jenkins using Docker Compose:**
   ```bash
   docker-compose up -d
   ```

2. **Access Jenkins:**
   - URL: http://localhost:8080
   - Get initial admin password:
     ```bash
     docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
     ```

3. **Install recommended plugins and create admin user**

## Jenkins Pipeline Setup

1. **Create a new Pipeline job in Jenkins**
2. **Configure the pipeline:**
   - Definition: Pipeline script from SCM
   - SCM: Git
   - Repository URL: [Your Git repository URL]
   - Script Path: Jenkinsfile

## Pipeline Stages

The Jenkins pipeline includes the following stages:

1. **Checkout** - Pulls the latest code from the repository
2. **Build** - Compiles the Java application using Maven
3. **Test** - Runs unit tests and publishes test results
4. **Package** - Creates the JAR file and archives it as an artifact
5. **Code Quality Analysis** - Runs additional verification
6. **Deploy to Staging** - Deploys the application (only on main branch)

## Docker Build

To build and run the application using Docker:

1. **Build the application:**
   ```bash
   mvn package
   ```

2. **Build Docker image:**
   ```bash
   docker build -t spring-jenkins-demo .
   ```

3. **Run Docker container:**
   ```bash
   docker run -p 8080:8080 spring-jenkins-demo
   ```

## Jenkins Pipeline Features

- **Docker Agent**: Uses Maven Docker image for builds
- **Automatic Testing**: Runs unit tests and publishes results
- **Artifact Archiving**: Stores built JAR files
- **Branch-based Deployment**: Only deploys main branch to staging
- **Health Checks**: Verifies application health after deployment
- **Cleanup**: Automatically cleans workspace after execution

## API Endpoints

- `GET /` - Returns a welcome message
- `GET /health` - Returns application health status
- `GET /actuator/health` - Spring Boot actuator health endpoint

## Troubleshooting

1. **Port conflicts**: If port 8080 is in use, modify the port in `application.properties` and `docker-compose.yml`
2. **Docker issues**: Ensure Docker daemon is running and you have proper permissions
3. **Jenkins permissions**: Make sure Jenkins has access to Docker socket

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests locally
5. Submit a pull request

The Jenkins pipeline will automatically run tests and build the application for all pull requests.
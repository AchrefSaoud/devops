# 🔧 Jenkins Pipeline Checkout Issue Fix

## ❌ **Current Error**
```
ERROR: 'checkout scm' is only available when using "Multibranch Pipeline" or "Pipeline script from SCM"
```

## ✅ **Solutions**

### **Option 1: Use "Pipeline script from SCM" (Recommended)**

1. **In Jenkins, create a new Pipeline job**
2. **In Pipeline section, select:**
   - Definition: **"Pipeline script from SCM"**
   - SCM: **Git**
   - Repository URL: `https://github.com/AchrefSaoud/devops.git`
   - Branch: `*/main`
   - Script Path: `Jenkinsfile`

3. **Save and run** - This will automatically checkout your code and run the pipeline

### **Option 2: Use Pipeline Script Directly**

1. **Copy the content of `Jenkinsfile.simple`**
2. **In Jenkins Pipeline job:**
   - Definition: **"Pipeline script"**
   - Paste the script content directly

### **Option 3: Upload Files to Jenkins Workspace**

If you want to test without Git integration:

1. **Use the updated `Jenkinsfile`** (which handles the checkout gracefully)
2. **Manually copy project files** to Jenkins workspace:
   ```bash
   # Copy files to Jenkins workspace
   docker exec -it jenkins-master bash
   mkdir -p /var/jenkins_home/workspace/your-pipeline-name
   # Then copy your project files there
   ```

## 🚀 **Quick Test - Copy and Paste This Pipeline**

Use this minimal pipeline script to test immediately:

```groovy
pipeline {
    agent any
    
    stages {
        stage('Test Environment') {
            steps {
                echo 'Testing Jenkins environment...'
                script {
                    if (isUnix()) {
                        sh 'pwd'
                        sh 'whoami'
                        sh 'java -version || echo "Java not found"'
                    } else {
                        bat 'cd'
                        bat 'whoami'
                        bat 'java -version || echo "Java not found"'
                    }
                }
            }
        }
        
        stage('Create Sample Project') {
            steps {
                echo 'Creating sample Maven project...'
                script {
                    if (isUnix()) {
                        sh '''
                        mkdir -p src/main/java
                        echo 'public class HelloWorld { public static void main(String[] args) { System.out.println("Hello Jenkins!"); } }' > src/main/java/HelloWorld.java
                        echo '<?xml version="1.0" encoding="UTF-8"?><project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"><modelVersion>4.0.0</modelVersion><groupId>com.example</groupId><artifactId>hello-world</artifactId><version>1.0.0</version><properties><maven.compiler.source>17</maven.compiler.source><maven.compiler.target>17</maven.compiler.target></properties></project>' > pom.xml
                        '''
                    } else {
                        bat '''
                        mkdir src\\main\\java 2>nul || echo "Directory exists"
                        echo public class HelloWorld { public static void main(String[] args) { System.out.println("Hello Jenkins!"); } } > src\\main\\java\\HelloWorld.java
                        echo ^<?xml version="1.0" encoding="UTF-8"?^>^<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"^>^<modelVersion^>4.0.0^</modelVersion^>^<groupId^>com.example^</groupId^>^<artifactId^>hello-world^</artifactId^>^<version^>1.0.0^</version^>^<properties^>^<maven.compiler.source^>17^</maven.compiler.source^>^<maven.compiler.target^>17^</maven.compiler.target^>^</properties^>^</project^> > pom.xml
                        '''
                    }
                }
            }
        }
        
        stage('Build and Test') {
            steps {
                echo 'Building sample project...'
                script {
                    if (isUnix()) {
                        sh 'ls -la'
                        sh 'cat pom.xml'
                    } else {
                        bat 'dir'
                        bat 'type pom.xml'
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Test pipeline completed!'
        }
        success {
            echo 'Test pipeline succeeded!'
        }
        failure {
            echo 'Test pipeline failed!'
        }
    }
}
```

## 📋 **Step-by-Step Fix**

### **For Your Current Spring Boot Project:**

1. **Push your code to GitHub:**
   ```bash
   git add .
   git commit -m "Add Jenkins pipeline"
   git push origin main
   ```

2. **Create new Pipeline job in Jenkins:**
   - Job type: **Pipeline**
   - Name: `spring-boot-pipeline`

3. **Configure Pipeline:**
   - Definition: **Pipeline script from SCM**
   - SCM: **Git**
   - Repository URL: `https://github.com/AchrefSaoud/devops.git`
   - Credentials: Add if private repo
   - Branch: `*/main`
   - Script Path: `Jenkinsfile`

4. **Save and Build Now**

## 🔧 **Alternative: Manual File Copy**

If you prefer not to use Git:

```bash
# Access Jenkins container
docker exec -it jenkins-master bash

# Navigate to workspace
cd /var/jenkins_home/workspace/your-pipeline-name

# Copy your project files here manually
# Or use docker cp command from host:
exit

# From host machine:
docker cp . jenkins-master:/var/jenkins_home/workspace/your-pipeline-name/
```

## ✅ **Expected Results**

After implementing the fix, you should see:
- ✅ **Checkout:** No more SCM errors
- ✅ **Build:** Maven compilation
- ✅ **Test:** Unit tests execution
- ✅ **Package:** JAR creation
- ✅ **Deploy:** Successful completion

---

🎯 **Choose Option 1 (SCM-based) for the most realistic CI/CD experience!**
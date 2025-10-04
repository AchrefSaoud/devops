# 🔧 Jenkins Plugin Installation Guide

## ❌ **Current Issue**
```
Invalid agent type "docker" specified. Must be one of [any, label, none]
```

**Cause:** Jenkins doesn't have the Docker Pipeline plugin installed.

## ✅ **Quick Fix Solutions**

### **Option 1: Use the Updated Jenkinsfile (Immediate Fix)**
The current `Jenkinsfile` has been updated to work without Docker plugins:
- ✅ Uses `agent any` instead of `agent docker`
- ✅ Uses Maven wrapper (`mvnw.cmd`) 
- ✅ Cross-platform compatible (Windows/Linux)

### **Option 2: Install Docker Pipeline Plugin**

1. **Access Jenkins:** http://localhost:8080
2. **Login:** 
   - Username: `admin`
   - Password: `aa4a555a371a493980f8802252d2ef4e`

3. **Install Plugins:**
   - Go to **Manage Jenkins** → **Manage Plugins**
   - Click **Available** tab
   - Search for and install:
     - ✅ **Docker Pipeline**
     - ✅ **Docker Commons Plugin**
     - ✅ **Pipeline: Stage View**
     - ✅ **Blue Ocean** (optional, for better UI)

4. **Restart Jenkins:**
   ```bash
   docker-compose restart
   ```

5. **Use Docker Jenkinsfile:**
   - Replace current `Jenkinsfile` with `Jenkinsfile.docker` content

## 🚀 **Test Your Pipeline Now**

### **Method 1: Test Current Jenkinsfile**
1. Create new Pipeline job in Jenkins
2. Use current `Jenkinsfile` (already updated for compatibility)
3. Run the pipeline

### **Method 2: Quick Test Script**
```bash
# Run this to verify everything works
.\test-pipeline.bat
```

## 📋 **Current Jenkinsfile Features**

```groovy
pipeline {
    agent any  // ✅ Works with basic Jenkins
    
    stages {
        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh './mvnw clean compile'
                    } else {
                        bat '.\\mvnw.cmd clean compile'  // ✅ Windows support
                    }
                }
            }
        }
        // ... other stages
    }
}
```

## 🔧 **Troubleshooting**

### **If Pipeline Still Fails:**

1. **Check Java/Maven availability:**
   ```groovy
   stage('Environment Check') {
       steps {
           script {
               if (isUnix()) {
                   sh 'java -version'
                   sh './mvnw -version'
               } else {
                   bat 'java -version'
                   bat '.\\mvnw.cmd -version'
               }
           }
       }
   }
   ```

2. **Simplify to basic test:**
   ```groovy
   pipeline {
       agent any
       stages {
           stage('Hello World') {
               steps {
                   echo 'Hello from Jenkins Pipeline!'
                   script {
                       if (isUnix()) {
                           sh 'echo "Running on Unix/Linux"'
                       } else {
                           bat 'echo "Running on Windows"'
                       }
                   }
               }
           }
       }
   }
   ```

## ✅ **Recommended Next Steps**

1. **Test current pipeline** with the updated `Jenkinsfile`
2. **Install Docker plugins** if you want containerized builds
3. **Configure tools** in Jenkins Global Tool Configuration:
   - JDK installations
   - Maven installations
4. **Set up webhooks** for automatic builds

## 📊 **Expected Results**

After using the updated Jenkinsfile, you should see:
- ✅ **Build:** Maven wrapper compiles successfully
- ✅ **Test:** Unit tests run and results published
- ✅ **Package:** JAR file created and archived
- ✅ **Quality:** Code verification passes
- ✅ **Deploy:** Staging deployment simulation

---

🎯 **The pipeline is now compatible with basic Jenkins installation!**
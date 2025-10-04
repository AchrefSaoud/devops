pipeline {
    agent {
        docker {
            image 'maven:3.9.4-openjdk-17'
            args '-v /root/.m2:/root/.m2'
        }
    }
    
    environment {
        MAVEN_OPTS = '-Dmaven.repo.local=/root/.m2/repository'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                    publishTestResults testResultsFiles: 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                sh 'mvn package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
            }
        }
        
        stage('Code Quality Analysis') {
            steps {
                echo 'Running code quality checks...'
                sh 'mvn verify'
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying to staging environment...'
                script {
                    // Here you would typically deploy to your staging environment
                    // For demo purposes, we'll just echo
                    sh 'echo "Deploying application to staging..."'
                    sh 'java -jar target/*.jar &'
                    sleep 10
                    sh 'curl -f http://localhost:8080/ || exit 1'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed.'
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        unstable {
            echo 'Pipeline is unstable!'
        }
    }
}
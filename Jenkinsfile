pipeline {
    agent any
    tools {
        jdk 'jdk20'
        nodejs 'nodejs20'
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/htrungngx/MovieWebApp.git'
            }
        }
        stage('Code Analysis') {
            environment {
                scannerHome = tool 'Sonar-scanner'
            }
            steps {
                withSonarQubeEnv('Sonarqube') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=Jenkins-Testing \
                        -Dsonar.sources=.
                    """
                }
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Build Image') {
            withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                sh 'docker build -t dckb9xz/app .'
            }
        }
        
    }
}

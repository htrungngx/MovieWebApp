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
            }
        }
        stage('Install') {
            steps {
                sh "npm install --force"
            }
        }
        stage('Build') {
            steps {
                sh "npm start"
            }
        }
    }
}

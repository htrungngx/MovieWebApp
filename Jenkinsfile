pipeline {
    agent any
    tools {
        jdk 'jdk20'
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
                        -Dsonar.sources=. \
                        -Dsonar.login=squ_91f2213c7d9fafc9c1a276e068d993fcc40d471b
                    """
                }
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}

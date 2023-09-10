pipeline {
  agent any
  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'https://github.com/htrungngx/MovieWebApp.git'
      }
    }
    stage('Code Analysis') {
      steps {
        withSonarQubeEnv('Sonarqube') {
          sh "${scannerHome}/bin/sonar-scanner \
              -Dsonar.projectKey=Jenkins-Testing \
              -Dsonar.sources=. "
        }
        timeout(time: 10, unit: 'MINUTES') {
              waitForQualityGate abortPipeline: true
      }
    }
  }
}

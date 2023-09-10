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
        withSonarQubeEnv(installationName: 'Sonarqube')
      }
    }
  }
}

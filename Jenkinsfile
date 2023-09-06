pipeline {
  agent any
  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'https://github.com/htrungngx/WebApp_pipeline.git'
      }
    }
    stage('Sonarqube') {
      environment {
          scannerHome = tool 'SonarScanner'
      }
      steps {
          withSonarQubeEnv('Sonar_Server') {
              sh "${scannerHome}/bin/sonar-scanner \
              -Dsonar.projectKey=webapppipeline-test \
              -Dsonar.sources=. "
          }
          timeout(time: 10, unit: 'MINUTES') {
              waitForQualityGate abortPipeline: true
          }
      }
    }
    stage('Building image') {
      steps {
        sh 'docker build -t dckb9xz/webpipeline:v1 .'
      }
    }
    stage('Deploy image') {
      steps {
        script {
            withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerHubID')]) {
                sh 'docker login -u dckb9xz -p ${dockerHubID}'
                sh 'docker push dckb9xz/webpipeline:v1'
            }
        }
      }
    }
  }
}

       
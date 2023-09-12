pipeline {
    agent any
    environment {
        TOKEN = credentials('teleToken')
        CHAT_ID = credentials('teleID')

        CURRENT_BUILD_NUMBER = "${currentBuild.number}"
        LINE_SKIP = "--------------------------------------------------------------"
        GIT_INFO = "Branch(Version): ${GIT_BRANCH}\nLast Message: ${GIT_MESSAGE}\nAuthor: ${GIT_AUTHOR}\nCommit: ${GIT_COMMIT_SHORT}"
        PRE_BUILD = "Jenkins is starting\n${LINE_SKIP}\n${JOB_NAME} is building"

        TEXT_SUCCESS_BUILD = "${JOB_NAME} is Success"
        TEXT_FAILURE_BUILD = "${JOB_NAME} is Failure"
    }
    tools {
        jdk 'jdk20'
        nodejs 'nodejs20'
    }
    
    stages {
        stage('Pre-Build') {
            steps {
                sh "curl --location --request POST 'https://api.telegram.org/bot${TOKEN}/sendMessage' --form text='${PRE_BUILD}' --form chat_id='${CHAT_ID}'"
            }
        }

        stage('Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/htrungngx/MovieWebApp.git'
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
        
        stage('Build Image') {
            steps {
                withDockerRegistry(
                    credentialsId: 'docker-hub',
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh 'docker build -t dckb9xz/app .'
                    sh 'docker push dckb9xz/app'
                }
            }
        }
        
        post {
            success {
                script {
                    sh "curl --location --request POST 'https://api.telegram.org/bot${TOKEN}/sendMessage' --form text='${TEXT_SUCCESS_BUILD}' --form chat_id='${CHAT_ID}'"
                }
            }
            failure {
                script {
                    sh "curl --location --request POST 'https://api.telegram.org/bot${TOKEN}/sendMessage' --form text='${TEXT_FAILURE_BUILD}' --form chat_id='${CHAT_ID}'"
                }
            }
        }
    }
}

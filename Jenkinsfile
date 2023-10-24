pipeline {
    agent any
    environment {
        //Tele-credential
        TOKEN = credentials('teleToken')
        CHAT_ID = credentials('teleID')

        //Git info
        GIT_INFO = "Branch: ${GIT_BRANCH}\nLast Message: ${GIT_MESSAGE}\nAuthor: ${GIT_AUTHOR}\nCommit: ${GIT_COMMIT_SHORT}\nBuild Number: #${CURRENT_BUILD_NUMBER}"
        CURRENT_BUILD_NUMBER = "${currentBuild.number}"
        GIT_MESSAGE = sh(returnStdout: true, script: "git log -n 1 --format=%s ${GIT_COMMIT}").trim()
        GIT_AUTHOR = sh(returnStdout: true, script: "git log -n 1 --format=%ae ${GIT_COMMIT}").trim()
        GIT_COMMIT_SHORT = sh(returnStdout: true, script: "git rev-parse --short ${GIT_COMMIT}").trim()

        PRE_BUILD = "Jenkins is starting 🚀\n ${LINE_SKIP}\n${GIT_INFO}\n ${LINE_SKIP}\n [${JOB_NAME}] is starting to build"

        LINE_SKIP = "---------------------------------------------"

        TEXT_SUCCESS_BUILD = " ✅ [${JOB_NAME}] is successfully built"
        TEXT_FAILURE_BUILD = " ❌ [${JOB_NAME}] built FAILED"
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
        //Clone code from repogistory
        stage('Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/htrungngx/MovieWebApp.git'
            }
        }
        //Send code to Analysis Server
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
        //Build code with Docker and Push to Registry
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
        //Deploy to Dev Environment
        stage('Deploy to DevEnv') {
            steps {
                echo 'Deploying and Cleaning'
                sh 'docker pull dckb9xz/app:latest'
                sh 'docker ps -a'
                sh "docker rm -f movieapp || echo 'The container does not exist'" //Remove exist container
                sh 'docker run --name movieapp -p 3000:3000 -d dckb9xz/app'
            }
        }
        //Deploy to production server
        stage('SSH to Production') {
            steps {
                sshagent(['ssh-server']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no htrung_jobs@34.88.164.172 < ssh-scripts.sh
                    """                
                }
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

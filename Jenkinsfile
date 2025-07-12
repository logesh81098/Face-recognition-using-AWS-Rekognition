pipeline {
    agent any

    stages {
        stage('Clone GitHub Repository') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/logesh81098/Face-recognition-using-AWS-Rekognition'
                    ]]
                ])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t logeshshanmugavel/face-rekognition-app-1 .'
            }
        }
        stage('List Docker Images'){
            steps{
                sh 'docker images'
            }
        }
        stage('Login Jenkins'){
            steps{
                withCredentials([usernamePassword(
                credentialsId: 'docker-hub',
                usernameVariable: 'DOCKER_USERNAME',
                passwordVariable: 'DOCKER_PASSWORD'
        )]) {
            sh '''
            echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
            echo "Logged in Successfully :)"
          '''
            }
        }
        }
        stage('Push Docker Image'){
            steps{
                sh 'docker push logeshshanmugavel/face-rekognition-app'
            }
        }
    }
}

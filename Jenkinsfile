pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "sonsoyeon/mirrorlit"
        DOCKERHUB_USERNAME = "sonsoyeon"   // Docker Hub ID
        DOCKERHUB_CREDENTIALS = "dockerhub" // Jenkins Credentials ID
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKERHUB_REPO}:${BUILD_NUMBER} ."
                    sh "docker tag ${DOCKERHUB_REPO}:${BUILD_NUMBER} ${DOCKERHUB_REPO}:latest"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: "${DOCKERHUB_CREDENTIALS}", variable: 'DOCKERHUB_TOKEN')]) {
                    sh '''
                        echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
                        docker push ${DOCKERHUB_REPO}:${BUILD_NUMBER}
                        docker push ${DOCKERHUB_REPO}:latest
                    '''
                }
            }
        }

    }

    post {
        success { echo "CI 성공" }
        failure { echo "CI 실패" }
    }
}

pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "sonsoyeon/mirrorlit"
        DOCKERHUB_CREDENTIALS = "dockerhub"
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
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push ${DOCKERHUB_REPO}:${BUILD_NUMBER}
                        docker push ${DOCKERHUB_REPO}:latest
                    '''
                }
            }
        }

        stage('Deploy to GKE') {
            
            steps {
                sh '''
                gcloud container clusters get-credentials mirrorlit-cluster --region asia-northeast3
                kubectl set image deployment/mirrorlit-deploy mirrorlit=${DOCKERHUB_REPO}:${BUILD_NUMBER}
                '''
            }
        }
    }

    post {
        success { echo "CI/CD 성공" }
        failure { echo "CI/CD 실패" }
    }
}


pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "sonsoyeon/mirrorlit"
    DOCKERHUB_CREDENTIALS = "dockerhub"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build image') {
      steps {
        script {
          app = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
        }
      }
    }

    stage('Push image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com", DOCKERHUB_CREDENTIALS) {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
  }
}

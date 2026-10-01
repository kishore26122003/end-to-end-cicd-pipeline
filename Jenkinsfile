pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'kishoreuiux2026/cicd-demo:1.0'
    }

    stages {
        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'CI/CD Build and Docker Push Successful!'
        }

        failure {
            echo 'CI/CD Build Failed!'
        }
    }
}

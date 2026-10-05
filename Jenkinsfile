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

        stage('Deploy to EC2') {
            steps {
                sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.0.152 "
                        docker pull $DOCKER_IMAGE &&
                        docker stop cicd-demo || true
                        docker rm cicd-demo || true
                        docker run -d --name cicd-demo -p 8080:8080 $DOCKER_IMAGE
                    "
                '''
            }
        }
    }

    post {
        success {
            echo 'CI/CD Build, Docker Push and Deployment Successful!'
        }

        failure {
            echo 'CI/CD Pipeline Failed!'
        }
    }
}

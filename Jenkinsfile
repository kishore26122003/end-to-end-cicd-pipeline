pipeline {
    agent any

    stages {
        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }

    post {
        success {
            echo 'CI Build Successful!'
        }

        failure {
            echo 'CI Build Failed!'
        }
    }
}

pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Successful checkout'
            }
        }
        
        stage('Build and Docker Image') {
            steps {
                script {
                    def imageTag = "padmanabhan1/todoapp"
                    docker.build(imageTag, '.')
                    echo 'Successful Build Docker Image'
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker_hub_cred', url: 'https://index.docker.io/v1/') {
                        def imageTag = "padmanabhan1/todoapp"
                        docker.image(imageTag).push()
                        echo 'Successful Push to Docker Hub'
                    }
                }
            }
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                 checkout scmGit(branches: [[name: '*/master']], extensions: [],
userRemoteConfigs: [[url: 'https://github.com/PadmanabhanSaravanan/GitHubActions.git']])
                echo 'successful checkout'
} }
        stage('Build jar and image using Docker file ') {
            steps {
                script {
                     def imageTag = "padmanabhan1/todoapp"
                    docker.build(imageTag, '.')
                    echo 'successful Build Docker Image'
                }
} }
        stage('Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker_hub_cred', url: 'https://index.docker.io/v1/') {
                        def imageTag = "vpadmanabhan1/todoapp"
                        docker.image(imageTag).push()
                        echo 'successful Push to Docker Hub'
                    }
} }
} }
}

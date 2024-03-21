# Bamboo Script for TodoApp CI/CD Pipeline

# Stage: Build
mvn clean install -Dmaven.test.skip=true
# Upload jar to folder
# Bamboo automatically archives the artifacts configured in the Maven task

# Stage: Deploy
# Download web-app content
# Bamboo will handle this automatically if artifacts are configured in the build plan

# Build Docker image
docker build -t padmanabhan1/todoapp .

# Log in to Docker Hub
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

# Push image to Docker Hub
docker push padmanabhan1/todoapp

# Deploy to Kubernetes
kubectl apply -f new-deployment.yaml

# Display all deployment and services
kubectl get all -o wide

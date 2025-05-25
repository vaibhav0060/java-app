pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = 'vaibhav0060/java-app'
        REMOTE_HOST = 'ec2-user@56.155.45.174'
        REMOTE_APP_NAME = 'java-app'
    }
      stages {
        stage('Hello world') {
            steps {
                echo'Hello world!'
            }
        
    }
    
        stage('checkout from Github') {
            steps {
                git branch : 'main',url:'https://github.com/vaibhav0060/java-app.git'
            
        }
    }
          stage('Build Docker Image'){
              steps{
                 sh"""
                 docker build -t $IMAGE_NAME:latest .
                 echo 'docker image builded'
                 """
              }
          }
          stage('push to Docker Hub'){
              steps{
                 sh"""
                 echo $DOCKERHUB_CREDENTIALS_PSW |
                 docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin 
                 docker push $IMAGE_NAME:latest 
                 """
              }
          }
          stage('Deploy to Ec2'){
              steps{
                  sshagent(['ec2-access']){
                 
               sh """
ssh -o StrictHostKeyChecking=no $REMOTE_HOST << EOF
    docker pull $IMAGE_NAME:latest
    docker stop $REMOTE_APP_NAME || true
    docker rm $REMOTE_APP_NAME || true
    docker run -d --name $REMOTE_APP_NAME -p 80:80 $IMAGE_NAME:latest
EOF
"""  
                  }
              }
          }
      }
           post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
      
}


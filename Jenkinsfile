pipeline {
  agent any

  environment {
    
    IMAGE_NAME = "qazaidi123/qazrepo2"
    IMAGE_TAG = "${BUILD_NUMBER}"
    DOCKER_CREDS = credentials('dockerhub-creds')
  }
  stages {
    stage("clone git repo") {
      steps {
       git url:"https://github.com/Qazaidi123/kubernetes.git" ,credentialsId: "git-creds", branch:"main"
      }
    }

    
    stage ("Build") {
      steps {
        sh " docker build -t $IMAGE_NAME:$IMAGE_TAG "
        
      }
    }

    
    stage ("Image push to DockerHub") {
      steps {
        sh " echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin "
        sh " docker push $IMAGE_NAME:$IMAGE_TAG "
        
      }
    }
    stage ("EKS cluster deploy") {
      steps {
        withAWS(credentials: 'AWS-CREDENTIALS') {
        sh " aws eks --region ap-south-1 update-kubeconfig --name ekscluster "
        sh " kubectl get pods "
        sh " kubectl apply -f k8s/ "

        sh "kubectl set image deployment/frontend-deployment frontend-container=$IMAGE_NAME:$IMAGE_TAG"
    

    
    
        
        }
      }
    }
  }


post {

        success {
            archiveArtifacts artifacts: '*.tar', fingerprint: true

            emailext(
                subject: "SUCCESS",
                body: " success",
                mimeType: 'text/html',
                to: 'zaidi.qumar@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "FAILED",
                body: "llll",
                mimeType: 'text/html',
                to: 'zaidi.qumar@gmail.com'
            )
        }

        unstable {
            emailext(
                subject: "FAILED",
                body: "Build Failed",
                mimeType: 'text/html',
                to: 'zaidi.qumar@gmail.com'
            )
    }
}
}

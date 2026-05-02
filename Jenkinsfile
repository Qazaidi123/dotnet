pipeline {
  agent any

  environment {
    
    IMAGE_NAME = "qazaidi123/qazrepo"
    IMAGE_TAG = "${BUILD_NUMBER}"
    DOCKER_CREDS = credentials('dockerhub-creds')
  }
  stages {
    stage("clone git repo") {
      steps {
       git url:"https://github.com/Qazaidi123/dotnet.git" ,credentialsId: "git-creds", branch:"main"
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
    stage (" Run container") {
      steps {
        
        sh " docker run -d --name dotnetcon2 -p 5000:5000 ${IMAGE_NAME}:${IMAGE:TAG}  "
      
        
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

pipeline {

  environment {
     registry = "atos06/ipiformation"
     registryCredential = 'docker-hub-credentials'
     dockerImage = ''
  }

  agent any
  
  stages {

    stage('Build de l application') {
      steps {
        script {
           dockerImage = docker.build(registry + ":$BUILD_NUMBER","./application")
        }
      }
    }

    stage('Tests') {
      parallel {

        stage('Test affichage de la page d accueil') {
          steps {
            script {
               docker.image(registry+":$BUILD_NUMBER").withRun('--rm -p 80:80 --name devops') { c ->
                  sh 'docker ps'
                  sh 'docker exec devops curl localhost:80'
                  sh 'echo "Tests passed"'
               }
            }
          }
        }

        stage('Test fonctionnel') {
          steps {
            script {
              sh 'sleep 5'
            }
          }
        }

      }
    }

    stage('Livraison') {
       steps{
          script {
             docker.withRegistry('https://registry.hub.docker.com', registryCredential ) {
                dockerImage.push("1.0")
             }
          }
       }
    }

     stage('Deploiement') {
       steps{
          script {
            def dockerRun = 'sudo docker stop monserver;sudo docker rm monserver;sudo docker rmi '+registry+':1.0;sudo docker run -d --name monserver -p 8081:80 '+registry+':1.0'
            
            sh """ssh -tt -o StrictHostKeyChecking=no vagrant@192.168.5.20 << EOF
            ${dockerRun}
            exit
            EOF""" 
          }
       }
    }
    
  }
}

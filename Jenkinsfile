@Library('my_shared_library') _

pipeline{

    agent any

    parameters{

//        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
//        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'my-java-app')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: '1.0')
//        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'srinivish')
          string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
          string(name: 'JFrog_URL', description: "name of the Application", defaultValue: 'http://34.123.193.20:8082/artifactory/example-repo-local')
    }

    stages {
         
      //   stage('Stage1: Git Checkout'){
      //               when { expression {  params.action == 'create' } }
      //       steps{
      //            git branch: 'main', url: params.Java_URL
      //       }
      //   }

        stage ('Stage1: Git Checkout') {
            when { expression {  params.action == 'create' } }
            steps {
                gitCheckout (
                  branch: 'main',
                  repoUrl: params.Java_URL
                )
            }
        }
        stage('Stage2: Maven Build : maven'){
         when { expression {  params.action == 'create' } }
               steps {
                  mvnBuild()
               }
        }
        stage('Stage4: Store Build in JFrog Artifactory'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                 sh 'curl -X PUT -u admin -p Password123456789! -T  target/my-java-app-1.0-SNAPSHOT.jar '+ JFrog_URL
               }
            }
        }

        stage('Stage5: Docker Build'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                 sh 'docker build -t srinivish/my-java-app:v1.0 . '
               }
            }

        }
        stage('Stage6: Docker Deploy') { 
            steps {
                script {
                    def containerName = "my-java-app"
                    def isRunning = sh(script: "docker inspect -f '{{.State.Running}}' $containerName", returnStatus: true) == 0
                    if (isRunning){
                        // Container is running, stop and remove it
                        sh "docker stop $containerName"
                        sh "docker rm -f $containerName"
                    }
                // Deploy container with new build
                sh "docker run $containerName -d my-java-app:1.0"
                echo "created new container: $containerName"
                }
            }
        }
   }
}
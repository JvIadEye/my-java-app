@Library('my_shared_library') _

pipeline{

    agent any

    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
//        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
//        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
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
                 sh 'curl -X PUT -u admin -p Password123456789! -T  target/my-java-app-1.0-SNAPSHOT.jar'+ JFrog_URL
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
   }
}
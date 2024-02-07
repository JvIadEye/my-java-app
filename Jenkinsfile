@Library('my_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
        string(name: 'JFrog_URL', description: "JFrog URL", defaultValue: 'http://34.29.30.7:8082/artifactory/example-repo-local/')
    }
    stages {
        stage ('Stage1: Git Checkout') {
            when { expression {  params.action == 'create' } }
            steps {
                echo "Git Checkout"
                gitCheckout (
                  branch: 'main',
                  repoUrl: params.Java_URL
                )
            }
        }
        stage('Stage2: Maven Build'){
         when { expression {  params.action == 'create' } }
               steps {
                  mvnBuild()
               }
        }
        stage('TESTING PURPOSE'){
         when { expression {  params.action == 'create' } }
               steps {
                  echo "CHECKING HOME: $env.HOME"
               }
        }
        // stage('Stage3: Artifact Maven Build'){
        //  when { expression {  params.action == 'create' } }
        //        steps {
        //           mvnArtifactory("target/my-java-app-1.0-SNAPSHOT.jar", JFrog_URL)
        //        }
        // }
    }
}
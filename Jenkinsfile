@Library('my_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
        string(name: 'JFrog_URL', description: "JFrog URL", defaultValue: 'http://34.125.71.13:8082/artifactory/example-repo-local/')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'my-java-app')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'srinivish')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: '1.0')

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
        stage('Static code analysis: Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonarqube-api'
                   statiCodeAnalysis(SonarQubecredentialsId)
               }
            }
        }
        stage('Quality Gate Status Check : Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   def SonarQubecredentialsId = 'sonarqube-api'
                   QualityGateStatus(SonarQubecredentialsId)
               }
            }
       }
        stage('Stage2: Maven Build'){
         when { expression {  params.action == 'create' } }
               steps {
                  mvnBuild()
               }
        }
        stage('Stage3: JAR to JFrog'){
         when { expression {  params.action == 'create' } }
               steps {
                  mvnArtifactory("target/my-java-app-1.0-SNAPSHOT.jar", JFrog_URL)
               }
        }
        stage('Stage4: Docker Login & Build'){
         when { expression {  params.action == 'create' } }
               steps {
                  dockerLoginBuild(params.DockerHubUser, params.ImageName, params.ImageTag)
                  }
        }   

        stage('Stage 5: Docker Image Scan: trivy '){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   dockerImageScan(params.DockerHubUser, params.ImageName, params.ImageTag)
               }
            }
        }

        stage('Stage6: Docker Deploy & Push'){
         when { expression {  params.action == 'create' } }
               steps {
                  dockerDeployPush(params.DockerHubUser, params.ImageName, params.ImageTag)
                  }
        }   

    }
}
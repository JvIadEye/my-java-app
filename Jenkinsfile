@Library('my_shared_library') _

pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'myWorkspace', description: "location for maven build", defaultValue: '/root')               
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'my-java-app')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: '1.0')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'srinivish')
        string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
        string(name: 'JFrog_URL', description: "JFrog URL", defaultValue: 'http://34.122.235.197:8082/artifactory/example-repo-local/')
    }
    stages {
        stage ('Stage1: Git Checkout') {
            when { expression {  params.action == 'create' } }
            steps {
                dir("${myWorkspace}")
                gitCheckout (
                  branch: 'main',
                  repoUrl: params.Java_URL
                )
            }
        }
        stage('Example') {
            steps {
                // Print the path of the current workspace
                script {
                    echo "Workspace directory: ${workspace}"
                }
            }
        }
        
    }
}
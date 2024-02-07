@Library('my_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
    }
    stages {
        stage ('Stage1: Git') {
            when { expression {  params.action == 'create' } }
            steps {
                workspace '/root'
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
                    echo "Workspace directory: " workspace 
                }
            }
        }
        
    }
}
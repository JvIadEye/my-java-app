@Library('my_shared_library') _
pipeline{
    agent any
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
    }
    stages {
        stage ('Stage1: Git') {
            when { expression {  params.action == 'create' } }
            steps {
                echo "Git Checkout"
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
                    echo "Hello World Example"
                    }
            }
        }
        
    }
}
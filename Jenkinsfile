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
        
        // stage('Stage2: Maven Build : maven'){
        //  when { expression {  params.action == 'create' } }
        //        steps {
        //           mvnBuild(params.myWorkspace)
        //        }
        // }
        
        // // stage('Stage3: Store Build in JFrog Artifactory'){
        // //  when { expression {  params.action == 'create' } }
        // //     steps{
        // //        script{
        // //          sh 'curl -X PUT -u admin -p Password123456789! -T  target/my-java-app-1.0-SNAPSHOT.jar '+ JFrog_URL
        // //        }
        // //     }
         
        // // }
        // stage('Stage 4: Docker Login'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        dockerLogin()
        //     }
        // }
        // stage('Stage5: Docker Build'){
        //  when { expression {  params.action == 'create' } }
        //     steps{
        //        script{
        //           echo " Image : $params.DockerHubUser/$params.ImageName:$params.ImageTag"
        //           sh 'docker build -t '+ $params.DockerHubUser + '/' + $params.ImageName + ':' + $params.ImageTag + ' .'
        //           sh 'docker push '+ $params.DockerHubUser + '/' + $params.ImageName + ':'+ $params.ImageTag + ' . '
        //        }
        //     }
         
        // }
        // stage('Stage6: Docker Deploy') { 
        //     steps {
        //         dockerDeploy(params.ImageName, params.ImageTag, params.DockerHubUser)
        //         //script {
        //         //     def containerName = "my-java-app"
        //         //     echo "container name inside Docker Deploy Statge: $containerName"
        //         //     // Check if container is running
        //         //     def isRunning = sh(script: "docker inspect -f '{{.State.Running}}' $containerName", returnStatus: true) == 0
        //         //     if (isRunning){
        //         //         // Container is running, stop and remove it
        //         //         sh "docker stop $containerName"
        //         //         sh "docker rm -f $containerName"
        //         //     }
        //         // // Deploy container with new build
        //         // sh "docker run --name $params.ImageName -d $params.DockerHubUser/$params.ImageName:$params.ImageTag"
        //         // echo "created new container: $containerName with image: $params.DockerHubUser/$params.ImageName:$params.ImageTag"
        //         //}
        //     }

        // }
    }
}


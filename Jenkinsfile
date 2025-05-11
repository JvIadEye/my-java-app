//@Library('my_shared_library') _
pipeline{
    agent any
//    parameters{
//        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
//        string(name: 'Java_URL', description: "name of the Application", defaultValue: 'https://github.com/srinivish/my-java-app.git')
//        string(name: 'JFrog_URL', description: "JFrog URL", defaultValue: 'http://34.125.71.13:8082/artifactory/example-repo-local/')
//        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'my-java-app')
//        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'srinivish')
//        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: '1.0')

//    }
    environment {
        ACTIVE_API_URL = 'https://noname.nsvnlab.io.vn/active'
        ACTIVE_BACKEND_URI = 'https://noname.nsvnlab.io.vn/active/backend'
        ACTIVE_TEST_GROUP_ID = '892b51de-67cf-4328-beea-3ade61bcdeb2'
        SEVERITY_THRESHOLD = 'none'
        ACTIVE_CONFIG_FILE_PATH = '/noname/active-config-newcollection.json'
    }
    stages {
//        stage ('Stage1: Git Checkout') {
//            when { expression {  params.action == 'create' } }
//            steps {
//                echo "Git Checkout"
//                gitCheckout (
//                branch: 'main',
//                repoUrl: params.Java_URL
//                )
//            }
//        }
//        stage('Static code analysis: Sonarqube'){
//         when { expression {  params.action == 'create' } }
//            steps{
//               script{
//                   
//                   def SonarQubecredentialsId = 'sonarqube-api'
//                   statiCodeAnalysis(SonarQubecredentialsId)
//               }
//            }
//        }
//        stage('Quality Gate Status Check : Sonarqube'){
//         when { expression {  params.action == 'create' } }
//            steps{
//               script{
                   
//                   def SonarQubecredentialsId = 'sonarqube-api'
//                   QualityGateStatus(SonarQubecredentialsId)
//               }
//            }
//       }
//       stage('Stage2: Maven Build'){
//         when { expression {  params.action == 'create' } }
//               steps {
//                  mvnBuild()
//               }
//        }
//        stage('Stage3: JAR to JFrog'){
//         when { expression {  params.action == 'create' } }
//               steps {
//                  mvnArtifactory("target/my-java-app-1.0-SNAPSHOT.jar", JFrog_URL)
//               }
//        }
//        stage('Stage4: Docker Login & Build'){
//         when { expression {  params.action == 'create' } }
//               steps {
//                  dockerLoginBuild(params.DockerHubUser, params.ImageName, params.ImageTag)
//                  }
//        }   

//        stage('Stage 5: Docker Image Scan: trivy '){
//         when { expression {  params.action == 'create' } }
//            steps{
//               script{
//                   dockerImageScan(params.DockerHubUser, params.ImageName, params.ImageTag)
//               }
//            }
//        }

//        stage('Stage6: Docker Deploy & Push'){
//         when { expression {  params.action == 'create' } }
//               steps {
//                  dockerDeployPush(params.DockerHubUser, params.ImageName, params.ImageTag)
//                  }
//       }
        stage('Active Scan') {
      steps {
        script {
          //checkout scm
          // Run your local server listening on localhost.
          //sh 'docker compose up -d'
          //sh 'sleep 5 && curl http://host.docker.internal:5002/ --retry 10 --retry-delay 1'

          // Login to Active Image Repository
          withCredentials([usernamePassword(credentialsId: 'dockerRegistryCredentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            sh 'docker login jfrog.cicd.nonamesec.com/noname-docker-release -u $USERNAME -p $PASSWORD'
            //def backendVersion = sh(script: "curl -k ${ACTIVE_API_URL}/backend/version", returnStdout: true).trim()
            //sh 'whoami'
            //sh "docker run --add-host=host.docker.internal:host-gateway -e ACTIVE_CONFIG_FILE_PATH=${ACTIVE_CONFIG_FILE_PATH} -e ACTIVE_BACKEND_URI=${ACTIVE_BACKEND_URI} -v \$(pwd)/noname:/noname jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:${backendVersion} scan --api-url=${ACTIVE_API_URL} --test-group-id=${ACTIVE_TEST_GROUP_ID} --api-token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlLZXkiOiJlMDc1YzcwMi0zNjNmLTQ5MjUtOTRhZS0yYzkyODA0YzhmZmQiLCJpZCI6IjUyYzM2OTA5LTJjOWYtNDMxZS1iNjdjLWUxOGI1NDQ5MGU5OSIsImlhdCI6MTc0NjQzNTU2MCwiZXhwIjoxNzYxOTg3NTYwLCJhdWQiOlsibm9uYW1lLW1hbmFnZW1lbnQtYXBpIl0sImlzcyI6Im5vYXV0aCJ9.YuCuK9pYyldjvaAgoibGU1VMzG0pQMnWvSywFRlqpjuAwjPqUHt5MOidsD0A-FH1b738HIleM9kp4rJUjatn67S5hegPsOM0NG-cWhh1rCvVXNaXlmyEXPMWV6vQq3_pfMdDl3mSxhMHSjkDGYKvhY9RFIEZocf80iw0nA1miOOv6iVVXrXm4Cous_tBmvLO3dMHFWr0lNRiGHqlgdqTq9bMpQfD6aN524KZbPG0YDmwzudiwggA87np7WtugLdwO_Hlxt9_Eo6om0gj4sjdHO33rCGCwdD5uyCERw7qErRUGoRuI9KiDEZFzRK54ujBe9KW4dhhauyjeoUOpLpmwA --branch-name=${env.GIT_BRANCH?.split('/')?.last()} --severity-threshold=${SEVERITY_THRESHOLD}"
          }

          // Run the scanner
          withCredentials([string(credentialsId: 'activeApiToken', variable: 'ACTIVE_API_TOKEN')]) {
            sh 'echo "$ACTIVE_API_TOKEN" | cut -d\".\" -f3'
          //def backendVersion = sh(script: "curl -k ${ACTIVE_API_URL}/backend/version", returnStdout: true).trim()
          //docker run -e ACTIVE_CONFIG_FILE_PATH='/noname/active-config.json' -v $(pwd)/noname:/noname -e ACTIVE_BACKEND_URI=https://noname.nsb.io.vn/active/backend jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:2.32.0 scan --api-url=https://noname.nsvnlab.io.vniOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFjdGl2ZS5jb20iLCJuYW1lIjoiYWRtaW4iLCJyb2xlIjoiYWRtaaW5nIjp0cnVlLCJ0ZWFtIjp7ImlkIjoiYWxsIiwibmFtZSI6ImFsbCJ9fSwiaHR0cHM6Ly9oYXN1cmEuaW8vand0L2NsYWltcyI6eyJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVJ4LWhhc3VyYS1kZWZhdWx0LXJvbGUiOiJhZG1pbiIsIngtaGFzdXJhLXVzZXItaWQiOiJhZG1pbiIsIngtaGFzdXJhLXRlYW0taWQiOiJhbGwifSwiaWF0IjoxNzQ2NjMwOb9HZdl0Xv41Z3Ugw3G64Mc --branch-name=main --severity-threshold=medium    
            sh 'docker run -e ACTIVE_CONFIG_FILE_PATH=${ACTIVE_CONFIG_FILE_PATH} -e ACTIVE_BACKEND_URI=${ACTIVE_BACKEND_URI} -v \$(pwd):/noname jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:2.32.0 scan --api-url=${ACTIVE_API_URL} --test-group-id=${ACTIVE_TEST_GROUP_ID} --api-token=\$ACTIVE_API_TOKEN --branch-name=main --severity-threshold=${SEVERITY_THRESHOLD}'
          //  sh 'docker run -e ACTIVE_CONFIG_FILE_PATH=${ACTIVE_CONFIG_FILE_PATH} -e ACTIVE_BACKEND_URI=${ACTIVE_BACKEND_URI} -v \$(pwd)/noname:/noname jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:2.32.0 scan --api-url=${ACTIVE_API_URL} --test-group-id=${ACTIVE_TEST_GROUP_ID} --api-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFjdGl2ZS5jb20iLCJuYW1lIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4iLCJlbmFibGVBY3RpdmVUZXN0aW5nIjp0cnVlLCJ0ZWFtIjp7ImlkIjoiYWxsIiwibmFtZSI6ImFsbCJ9fSwiaHR0cHM6Ly9oYXN1cmEuaW8vand0L2NsYWltcyI6eyJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbImFkbWluIiwidXNlciJdLCJ4LWhhc3VyYS1kZWZhdWx0LXJvbGUiOiJhZG1pbiIsIngtaGFzdXJhLXVzZXItaWQiOiJhZG1pbiIsIngtaGFzdXJhLXRlYW0taWQiOiJhbGwifSwiaWF0IjoxNzQ2NjMwODg4fQ.tIQzwK2XlHx0bgf5z7Zwrb9HZdl0Xv41Z3Ugw3G64Mc --branch-name=null --severity-threshold=${SEVERITY_THRESHOLD}'          
    
          //  sh "docker run --add-host='host.docker.internal:host-gateway' -e ACTIVE_CONFIG_FILE_PATH='/opt/test/Active Pharmacy Lab - REST.json' -e ACTIVE_BACKEND_URI='https://noname.nsvnlab.io.vn/active/backend/' -v \$(pwd)/noname:/noname jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:2.32.0 scan --api-url=${ACTIVE_API_URL} --test-group-id=${ACTIVE_TEST_GROUP_ID} --api-token=\$ACTIVE_API_TOKEN --branch-name=${env.GIT_BRANCH.split('/')[-1]} --severity-threshold=${SEVERITY_THRESHOLD}"
          //  sh "docker run --add-host='host.docker.internal:host-gateway' -e ACTIVE_CONFIG_FILE_PATH='/opt/test/Active Pharmacy Lab - REST.json' -e ACTIVE_BACKEND_URI='https://noname.nsvnlab.io.vn/active/backend/' -v /opt/test:/noname jfrog.cicd.nonamesec.com/noname-docker-release/active-cli:2.32.0 scan --api-url=${ACTIVE_API_URL} --test-group-id=${ACTIVE_TEST_GROUP_ID} --api-token=\$ACTIVE_API_TOKEN --branch-name=${env.GIT_BRANCH.split('/')[-1]} --severity-threshold=${SEVERITY_THRESHOLD}"
          }
        }
      }
    }
    }
}

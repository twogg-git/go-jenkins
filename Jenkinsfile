#!/usr/bin/env groovy
// The above line is used to trigger correct syntax highlighting.

pipeline {
    agent { docker { image 'golang:1.8.6' } }
    
    // Each "sh" line (shell command) is a step,
    // so if anything fails, the pipeline stops.
    stages {
        
        stage('Enviroment Setup') {   
            steps {        
                // Golang Version
                sh 'go version' 
                // Removing cached files
                // sh 'go clean -i -r -n'
                // Setting up package dependencies
                sh 'go get -v github.com/stretchr/testify/assert'
                sh 'go get -v github.com/gorilla/mux'
            }            
        }
            
        stage('Code Setup') {   
            steps {               
                // Create our project directory
                sh 'cd ${GOPATH}/src'
                sh 'mkdir -p ${GOPATH}/src/twogg-git/go-jenkins'
                // Copy all files in our Jenkins workspace to our project directory            
                sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/twogg-git/go-jenkins'
                // Copy all files in our "vendor" folder to our "src" folder
                // sh 'cp -r ${WORKSPACE}/vendor/* ${GOPATH}/src'
            }            
        }

        stage('Binary Building') {   
            steps {       
                // Build the app
                sh 'go build'
            }            
        }
    
        // https://www.thepolyglotdeveloper.com/2017/02/unit-testing-golang-application-includes-http/
        stage('Unit Testing') {
            steps {                    
                // Run Unit Tests
                sh 'go test ./... -v'   
                // Corverage Report %
                sh 'go test -cover -coverprofile=c.out'
            }
        }
        
        stage('Parallel Testing') {
            steps {
                parallel(
                    BussinesLogic: {
                        sh 'go test ./... -v'
                    },
                    Endpoints: {
                        sh 'go test ./... -v'
                    }
                )
            }
        }
        
        // Excecuted only for develop or features branches
        stage('Develop') {
            when { not { branch 'master' } }
            steps {
                echo 'Example: Validate format and good practices'
            }
        }
        
        // Excecuted when master needs sanity checks
        stage('Staging') {
            when { branch 'master' } 
            steps {
                echo 'Example: Validates databases versioning'
            }
        }
        
        //https://rezasetiadi.wordpress.com/2017/06/06/deploy-go-application-using-jenkins-pipeline/
        //go-jenkins = [your_project]
        stage('Delivery') {
            when { branch 'release' } 
            steps {
                //withEnv(['PATH=$PATH:/opt/go/bin:','GOROOT=/opt/go','GOPATH=/var/lib/jenkins/jobs/go-jenkins/workspace/']){
                //withEnv(['GOROOT=/opt/go','GOPATH=/var/lib/jenkins/jobs/go-jenkins/workspace/']){
                    dir('/var/lib/jenkins/jobs/go-jenkins/workspace/src/github.com.org/twogg-git/go-jenkins'){
                        sh 'go install'
                        sh 'ls -a'
                        
                        // cd "${WORKSPACE}"
                        // git status # should show <file> as changed or unversioned

                        // git add <file>
                        // git commit -m "Added file with automated Jenikins job"
                        // git push
                    }
                //}
            }
        }
        
     
        //https://medium.com/@gustavo.guss/jenkins-building-docker-image-and-sending-to-registry-64b84ea45ee9
        //https://jenkins.io/doc/pipeline/steps/docker-workflow/
        //https://jenkins.io/doc/book/pipeline/docker/
        //https://issues.jenkins-ci.org/browse/JENKINS-41051
        //stage('Push image') {
        //    /* Finally, we'll push the image with two tags:
        //    * First, the incremental build number from Jenkins
        //    * Second, the 'latest' tag. */
        //    withCredentials([usernamePassword( credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        //
        //        docker.withRegistry('', 'docker-hub-credentials') {
        //            sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        //            myImage.push("${env.BUILD_NUMBER}")
        //            myImage.push("latest")
        //        }
        //    }
        //}
        // stage('Build image') {   
        //    steps {
        //        script {  
        //            sh 'ls -a'
        //            docker.build(registry + ":$BUILD_NUMBER") 
        //            docker.withRegistry('', 'docker-hub-credentials') {
        //                sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        //            }
        //        }
        //    }
        //}
        
        // https://registry.hub.docker.com/
        // https://index.docker.io/v1/
        //stage('Push image') {
        //    steps {
        //        script {
        //           docker.withRegistry('', 'docker-hub-credentials') {
        //                aap.build(registry + ":$BUILD_NUMBER") 
        //                app.push("${env.BUILD_NUMBER}")	                     
        //                app.push("latest")
        //           }
        //        }
        //    }
         //}
        
        // https://registry.hub.docker.com/
        // stage('Push image') {
        //    steps {
        //        script {
        //            docker.build(registry + ":$BUILD_NUMBER") 
        //        }
        //    }
        // }
        
    }
} 

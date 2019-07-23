#!/usr/bin/env groovy
// The above line is used to trigger correct syntax highlighting.

pipeline {
    agent { docker { image 'golang:1.8.6' } }

    environment {
        registry = "twogghub/test1"
        registryCredential = 'docker-hub-credentials'
    }
    
    stages {
        stage('Build') {   
            steps {        
                
                // Golang Version
                sh 'go version'
               
                // Create our project directory
                sh 'cd ${GOPATH}/src'
                sh 'mkdir -p ${GOPATH}/src/twogg-git/go-jenkins'

                // Copy all files in our Jenkins workspace to our project directory                
                sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/twogg-git/go-jenkins'

                // Copy all files in our "vendor" folder to our "src" folder
                //sh 'cp -r ${WORKSPACE}/vendor/* ${GOPATH}/src'

                // Build the app
                sh 'go build'
            }            
        }

        // Each "sh" line (shell command) is a step,
        // so if anything fails, the pipeline stops.
        stage('Test') {
            steps {                    
                
                // Remove cached test results.
                //sh 'go clean -cache'

                // Run Unit Tests
                sh 'go test ./... -v'                                  
            }
        } 
        
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
    
        //stage('Build image') {   
        //    steps {
        //        script {  
        //            docker.withRegistry('', 'docker-hub-credentials') {
        //                // Golang Version
        //                sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        //            }
        //        }
        //    }
        //}
        
        // https://registry.hub.docker.com/
        //stage('Push image') {
        //    steps {
        //        script {
        //            docker.withRegistry('https://registry.hub.docker.com/twogghub', 'docker-hub-credentials') {
        //                app.push("${env.BUILD_NUMBER}")	                     
        //                app.push("latest")
        //            }
        //        }
        //    }
        // }
        
        // https://registry.hub.docker.com/
        stage('Push image') {
            steps {
                script {
                    docker.build(registry + ":$BUILD_NUMBER") 
                }
            }
        }
        
    }
} 

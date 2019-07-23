#!/usr/bin/env groovy
// The above line is used to trigger correct syntax highlighting.

pipeline {
    agent { docker { image 'golang:1.8.6' } }

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
        
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://docker.io/twogghub/go-jenkins', 'docker-hub-credentials') {
                        app.push("${env.BUILD_NUMBER}")	                     
                        app.push("latest")
                    }
                }
            }
        }
            
    }
} 

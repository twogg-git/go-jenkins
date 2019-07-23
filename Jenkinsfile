#!/usr/bin/env groovy
// The above line is used to trigger correct syntax highlighting.

pipeline {
    agent { docker { image 'golang:1.8.6' } }

    environment {
        registry = 'twogghub/test1'
        registryCredential = 'docker-hub-credentials'
    }
    
    // Each "sh" line (shell command) is a step,
    // so if anything fails, the pipeline stops.
    stages {
        
        stage('Enviroment Setup') {   
            steps {        
                // Golang Version
                sh 'go version' 
                // Removing cached files
                sh 'go clean -i -r -n'
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
    
        stage('Unit Testing') {
            steps {                    
                // Run Unit Tests
                sh 'go test ./... -v'   
                // Corverage Report %
                sh 'go test -cover -coverprofile=c.out'
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
    
        stage('Build image') {   
            steps {
                script {  
                    sh 'ls -a'
                    sh 'docker build -t twogghub/test1 .'
                    docker.withRegistry('', 'docker-hub-credentials') {
                        // Golang Version
                        sh "docker login -u ${USERNAME} -p ${PASSWORD}"
                    }
                }
            }
        }
        
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
        // stage('Push image') {
        //    steps {
        //        script {
        //            docker.build(registry + ":$BUILD_NUMBER") 
        //        }
        //    }
        // }
        
    }
} 

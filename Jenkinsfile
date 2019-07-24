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
                // sh 'go get -d'
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
        
        //// https://www.thepolyglotdeveloper.com/2017/02/unit-testing-golang-application-includes-http/
        stage('Unit Testing') {
            steps {
                parallel(
                    UnitTesting: {
                        sh 'go test ./... -v'
                    },
                    Coverage: {
                        sh 'go test -cover -coverprofile=c.out'
                    }
                )
            }
        }
        
        // Excecuted only for develop or features branches
        stage('Code Quality') {
            when { not { branch 'master' } }
            steps {
                // https://peter.bourgon.org/go-in-production/
                echo 'Only for development run integration testing'
                sh 'go vet'  
            }
        }
        
        //https://rezasetiadi.wordpress.com/2017/06/06/deploy-go-application-using-jenkins-pipeline/
        stage('Delivery') {
            when { branch 'master' } 
            steps {
                echo 'Only for development run integration testing and deploy!!!'
                sh 'go test -tags=integration'  
                sh 'ls'
                // /var/jenkins_home/workspace/go-jenkins_master
                //withEnv(['PATH=$PATH:/opt/go/bin:','GOROOT=/opt/go','GOPATH=/var/jenkins_home/workspace/go-jenkins_master']){
                //withEnv(['GOROOT=/opt/go','GOPATH=/var/lib/jenkins/jobs/go-jenkins_master/workspace/']){
                //    dir('/var/lib/jenkins_home/jobs/go-jenkins_master/workspace/src/github.com.org/twogg-git/go-jenkins'){
                //        sh 'go install'
                //    }
                //}
            }
        }
      
    }
} 

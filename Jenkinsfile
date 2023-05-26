pipeline {
    agent { label 'DEV' }
    triggers { pollSCM('* * * * *') }
    stages {
        stage('clone_the_code') {
            steps {
                git branch: 'master',
                       url: 'https://github.com/maheshryali123/game-of-life.git'
            }
        }
        stage('Build_the_package') {
            steps {
                sh 'java -version'
                sh 'mvn clean package'
            }
        }
    }
}
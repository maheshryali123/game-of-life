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
                sh """
                export PATH='/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:$PATH'
                java -version
                mvn clean package
                """
            }
        }
        stage('sonarscan') {
            steps {
                withSonarQubeEnv('sonar_scan') {
                    sh """
                    export PATH='/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:$PATH'
                    java -version
                    ${scannerHome}/bin/sonar-scanner
                    mvn clean package sonar:sonar
                    """
                }
            }
        }
    }
}
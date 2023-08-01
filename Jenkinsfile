pipeline {
    agent { label 'PRACTICE' }
    triggers { pollSCM ('* * * * *') }
    stages {
        stage('Clone_the_code') {
            steps {
                git branch: 'develop_branch',
                       url: 'https://github.com/maheshryali123/game-of-life.git'
            }
        }
        stage('Install_java_8') {
            steps {
                sh """
                #!/bin/bash
                echo "Java is installing in the jenkins_node"
                sudo apt install openjdk-8-jdk -y
                export PATH='/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:$PATH'
                """
            }
        }
        stage('Build_the_application') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
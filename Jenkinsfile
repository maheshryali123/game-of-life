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
        /*stage('sonarscan') {
            steps {
                withSonarQubeEnv('sonar_scan') {
                    sh """
                    export PATH='/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin:$PATH'
                    java -version
                    mvn clean package sonar:sonar
                    """
                }
            }
        }*/
        stage('docker_image_build') {
            agent { label 'k8s' }
            steps {
                sh """
                docker image build -t gameoflife123:$BUILD_ID
                docker tag forgameoflife123:$BUILD_ID 389485504177.dkr.ecr.us-east-1.amazonaws.com/forgameoflife123:$BUILD_ID
                docker push 389485504177.dkr.ecr.us-east-1.amazonaws.com/forgameoflife123:$BUILD_ID
                """
            }
        }
        stage('kubernetes_deploy_to_dev') {
            agent { label 'k8s' }
            steps {
                sh """
                kubectl apply -f de.yaml --namespace dev
                kubectl apply -f svc.yaml --namespace dev
                kubectl apply -f namespace.yaml
                """
            }
        }
    }
}
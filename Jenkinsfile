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
            agent { label 'K8S' }
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
            agent { label 'K8S' }
            steps {
                sh """
                docker image build -t forgameoflife123:$BUILD_ID .
                docker tag forgameoflife123:$BUILD_ID 389485504177.dkr.ecr.us-east-1.amazonaws.com/forgameoflife123:$BUILD_ID
                docker push 389485504177.dkr.ecr.us-east-1.amazonaws.com/forgameoflife123:$BUILD_ID
                """
            }
        }
        stage('kubernetes_deploy_to_dev') {
            agent { label 'K8S' }
            steps {
                sh """
                aws eks update-kubeconfig --region us-east-2 --name education-eks-5x0q4LbQ
                curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.25.9/2023-05-11/bin/linux/amd64/kubectl
                chmod +x ./kubectl
                mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
                echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
                kubectl apply -f de.yaml --namespace dev
                kubectl apply -f svc.yaml --namespace dev
                kubectl apply -f namespace.yaml
                """
            }
        }
    }
}
pipeline {
    agent { label 'GAMEOFLIFE' }
    triggers { pollSCM('* * * * *') }
    parameters { 
        choice(name: 'BRANCH', choices: ['master', 'gameofife-release-.1', 'gameofife-release-1.0.1'], description: 'This is for branch selection')
        string(name: 'MAVEN_BUILD', defaultValue: 'clean package', description: 'For maven goals' )
    }
    stages {
        stage('git_clone') {
            steps {
                git branch: "${params.BRANCH}",
                       url: 'https://github.com/maheshryali123/game-of-life.git'
            }
        }
        //stage('build_code') {
            //steps {
                //sh 'mvn clean package'
            //}
        //}
        stage('sonar_scan') {
            steps {
                withSonarQubeEnv('sonar_scan') {
                sh " mvn clean package sonar:sonar "
            }
        }
    }
  }
}
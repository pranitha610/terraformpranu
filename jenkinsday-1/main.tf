pipeline {
    agent any

    stages {
        stage('clone') {
            steps {
                git branch: 'main', url: 'https://github.com/pranitha610/terraformpranu/tree/main/day3'
            }
        }
        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
    }
}
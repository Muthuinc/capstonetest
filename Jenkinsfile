pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS secret access ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS sceret access key')
        SSH_CRED = credentials('avamumbai')
    }
     stages {
        stage ('build') {
            steps {
                sh """
                ./build.sh
                """
            }
        }

        stage ('deploy') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "./make.sh '$SSH_KEY' "
                    }
                }
            }
        }
    }
}
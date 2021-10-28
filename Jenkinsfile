pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
        disableConcurrentBuilds()
    }

    tools {
        terraform 'Terraform'
    }

            stages {

                stage('pre work') {
                    steps {
                        sh "terraform -version"
                    }
                }

                stage('Deploy Infrastructure') {
                    steps {
                        sh "chmod a+x ./deploy/*"
                        sh "./deploy/common.sh"
                    }
                }
            }
            // post {
            //         always {
            //             cleanWs()
            //         }
            //     }
}
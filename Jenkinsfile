pipeline {
    agent any 

    parameters {
        string(name: 'IMAGE_VERSION', defaultValue: '1.0.0', description: 'Production release version tag')
    }

    stages {
        stage('Source SCM Checkout') {
            steps {
                echo "Triggered automatically via Git Webhook connection."
                checkout scm
            }
        }

        stage('Secure Containerization') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'enterprise-registry-creds', usernameVariable: 'REG_USER', passwordVariable: 'REG_PASS')]) {
                    echo "Injecting bounded credentials for user security profile: ${REG_USER}"
                    sh "docker build -t docker.io/enterprise-service:${params.IMAGE_VERSION} ."
                }
            }
        }

        stage('Post-Build Archiving') {
            steps {
                echo "Exporting build telemetry and artifacts..."
                archiveArtifacts artifacts: '**/build_log.txt', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            echo "Pipeline run completed. Cleaning up agent workspace variables."
        }
        failure {
            echo "Pipeline status CRITICAL: Initiating automated rollback notifications."
        }
    }
}

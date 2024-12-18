pipeline {
    agent any

    environment {
        DOTNET_VERSION = '8.0' // .NET SDK versie
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Install .NET SDK') {
            steps {
                echo 'Checking and installing .NET SDK if needed...'
                sh '''
                if ! dotnet --version | grep ${DOTNET_VERSION}; then
                    echo ".NET SDK not found. Installing..."
                    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
                    chmod +x dotnet-install.sh
                    ./dotnet-install.sh --version ${DOTNET_VERSION} --install-dir /usr/share/dotnet
                    export PATH=$PATH:/usr/share/dotnet
                else
                    echo ".NET SDK ${DOTNET_VERSION} is already installed."
                fi
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                echo 'Building the .NET frontend application...'
                dir('frontend') { // Ga naar de frontend folder
                    sh 'dotnet build'
                }
            }
        }

        stage('Security Test') {
            steps {
                echo 'Running security scan (OWASP Dependency-Check)...'
                sh '''
                dependency-check.sh --project "EasyDevOpsApp" --scan . --format HTML --out reports
                '''
            }
            post {
                always {
                    archiveArtifacts artifacts: 'reports/*', allowEmptyArchive: true
                }
            }
        }

        stage('Run Application') {
            steps {
                echo 'Running the .NET frontend application...'
                dir('frontend') {
                    sh 'dotnet run --no-build'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully! 🎉'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}

pipeline {
    agent any

    environment {
        DOTNET_VERSION = '8.0' // .NET SDK versie
        SNYK_TOKEN = credentials('SNYK') // Snyk token uit Jenkins credentials
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
                echo 'Installing .NET SDK if not already installed...'
                sh '''
                if ! dotnet --version | grep ${DOTNET_VERSION}; then
                    echo ".NET SDK not found. Installing..."
                    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
                    chmod +x dotnet-install.sh
                    ./dotnet-install.sh --version ${DOTNET_VERSION} --install-dir /usr/share/dotnet
                    export PATH=$PATH:/usr/share/dotnet
                fi
                '''
            }
        }

        stage('Build Frontend') {
            steps {
                echo 'Building the .NET frontend application...'
                dir('frontend') {
                    sh 'dotnet build'
                }
            }
        }

        stage('Snyk Security Test') {
            steps {
                echo 'Running Snyk security test...'
                dir('frontend') {
                    sh '''
                    snyk auth ${SNYK_TOKEN}
                    snyk test --all-projects --severity-threshold=high
                    '''
                }
            }
            post {
                always {
                    echo 'Archiving Snyk test results...'
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

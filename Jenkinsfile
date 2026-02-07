pipeline {
    agent any

    environment {
        NODE_VERSION = '18'
        APP_NAME = 'nextjsjenkins'
        DEPLOY_DIR = "${WORKSPACE}/deploy"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                script {
                    def isUnix = isUnix()
                    
                    if (isUnix) {
                        sh '''
                            echo "Checking Node.js installation..."
                            node --version || echo "Node.js not found in PATH"
                            npm --version || echo "npm not found in PATH"
                            npm ci
                        '''
                    } else {
                        bat '''
                            echo Checking Node.js installation...
                            node --version || echo Node.js not found in PATH
                            npm --version || echo npm not found in PATH
                            npm ci
                        '''
                    }
                }
            }
        }

        stage('Lint') {
            steps {
                echo 'Running linter...'
                script {
                    def isUnix = isUnix()
                    if (isUnix) {
                        sh 'npm run lint || true'
                    } else {
                        bat 'npm run lint || echo Lint completed'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Building Next.js application...'
                script {
                    def isUnix = isUnix()
                    if (isUnix) {
                        sh 'npm run build'
                    } else {
                        bat 'npm run build'
                    }
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo 'Archiving build artifacts...'
                archiveArtifacts artifacts: '.next/**', fingerprint: true
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application locally...'
                script {
                    def isUnix = isUnix()
                    
                    if (isUnix) {
                        // Unix/Linux/Mac deployment
                        sh '''
                            mkdir -p ${DEPLOY_DIR}
                            echo "Deployment directory: ${DEPLOY_DIR}"
                            
                            # Copy built application
                            cp -r .next ${DEPLOY_DIR}/
                            cp -r public ${DEPLOY_DIR}/
                            cp package*.json ${DEPLOY_DIR}/
                            cp next.config.js ${DEPLOY_DIR}/
                            cp -r node_modules ${DEPLOY_DIR}/
                        '''
                    } else {
                        // Windows deployment
                        bat '''
                            if not exist "${DEPLOY_DIR}" mkdir "${DEPLOY_DIR}"
                            echo Deployment directory: ${DEPLOY_DIR}
                            
                            xcopy /E /I /Y .next "${DEPLOY_DIR}\\.next"
                            xcopy /E /I /Y public "${DEPLOY_DIR}\\public"
                            copy /Y package*.json "${DEPLOY_DIR}\\"
                            copy /Y next.config.js "${DEPLOY_DIR}\\"
                            xcopy /E /I /Y node_modules "${DEPLOY_DIR}\\node_modules"
                        '''
                    }
                    
                    echo "✅ Application deployed to: ${DEPLOY_DIR}"
                    echo "To start the application, run: cd ${DEPLOY_DIR} && npm start"
                }
            }
        }
        
        stage('Start Application') {
            steps {
                script {
                    echo 'Starting the application...'
                    def isUnix = isUnix()
                    
                    if (isUnix) {
                        // Unix/Linux/Mac - stop existing and start new
                        sh '''
                            pkill -f "node.*server.js" || echo "No existing process found"
                            cd ${DEPLOY_DIR}
                            nohup npm start > app.log 2>&1 &
                            echo $! > app.pid
                            sleep 3
                            echo "Application started with PID: $(cat app.pid)"
                        '''
                    } else {
                        // Windows - stop existing and start new
                        bat '''
                            taskkill /F /IM node.exe 2>nul || echo No existing process found
                            cd /d "${DEPLOY_DIR}"
                            start /B npm start > app.log 2>&1
                            timeout /t 3 /nobreak >nul
                            echo Application started. Check app.log for output.
                        '''
                    }
                    
                    echo "🚀 Application should be running at http://localhost:3000"
                    echo "Check ${DEPLOY_DIR}/app.log for application logs"
                    echo "Note: If the app doesn't start, you can manually run: cd ${DEPLOY_DIR} && npm start"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! ✅'
            // Add notifications here (email, Slack, etc.)
        }
        failure {
            echo 'Pipeline failed! ❌'
            // Add failure notifications here
        }
        always {
            echo 'Build completed. Workspace preserved for deployment.'
            // Note: We don't clean the workspace to keep the deployment directory
        }
    }
}


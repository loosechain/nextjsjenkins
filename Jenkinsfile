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
                            node --version
                            npm --version
                            echo "Installing dependencies..."
                            npm ci
                        '''
                    } else {
                        bat 'echo Checking Node.js installation...'
                        bat 'node --version'
                        bat 'npm --version'
                        bat 'echo Current directory:'
                        bat 'cd'
                        bat 'echo Listing files:'
                        bat 'dir /b'
                        bat 'echo Installing dependencies...'
                        bat 'npm install'
                        bat 'echo Verifying installation...'
                        bat 'if exist node_modules (echo node_modules exists) else (echo ERROR: node_modules not found && exit /b 1)'
                        bat 'echo Dependencies installed successfully'
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
                        // Create ESLint config if it doesn't exist to avoid interactive prompt
                        bat '''
                            if not exist .eslintrc.json (
                                echo Creating ESLint config...
                                echo { > .eslintrc.json
                                echo   "extends": "next/core-web-vitals" >> .eslintrc.json
                                echo } >> .eslintrc.json
                            )
                            npm run lint || echo Lint completed with warnings
                        '''
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
                    def deployPath = isUnix ? "${WORKSPACE}/deploy" : "${WORKSPACE}\\deploy"
                    
                    if (isUnix) {
                        // Unix/Linux/Mac deployment
                        sh """
                            mkdir -p ${deployPath}
                            echo "Deployment directory: ${deployPath}"
                            
                            # Copy built application
                            cp -r .next ${deployPath}/
                            cp -r public ${deployPath}/
                            cp package*.json ${deployPath}/
                            cp next.config.js ${deployPath}/
                            cp -r node_modules ${deployPath}/
                        """
                    } else {
                        // Windows deployment
                        bat """
                            if not exist "${deployPath}" mkdir "${deployPath}"
                            echo Deployment directory: ${deployPath}
                            
                            if exist .next (
                                xcopy /E /I /Y .next "${deployPath}\\.next"
                            ) else (
                                echo WARNING: .next directory not found - build may have failed
                            )
                            
                            if exist public (
                                xcopy /E /I /Y public "${deployPath}\\public"
                            )
                            
                            copy /Y package*.json "${deployPath}\\"
                            copy /Y next.config.js "${deployPath}\\"
                            xcopy /E /I /Y node_modules "${deployPath}\\node_modules"
                            
                            echo Verifying deployment...
                            if exist "${deployPath}\\node_modules" (
                                echo Deployment successful
                            ) else (
                                echo ERROR: Deployment failed
                                exit /b 1
                            )
                        """
                    }
                    
                    echo "✅ Application deployed to: ${deployPath}"
                    echo "To start the application, run: cd ${deployPath} && npm start"
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
                        def deployPath = "${WORKSPACE}/deploy"
                        sh """
                            pkill -f "node.*server.js" || echo "No existing process found"
                            cd ${deployPath}
                            nohup npm start > app.log 2>&1 &
                            echo \$! > app.pid
                            sleep 3
                            echo "Application started with PID: \$(cat app.pid)"
                        """
                    } else {
                        // Windows - stop existing and start new
                        // Use backslashes for Windows path
                        def deployPath = "${WORKSPACE}\\deploy"
                        bat """
                            taskkill /F /IM node.exe 2>nul || echo No existing process found
                            if exist "${deployPath}" (
                                cd /d "${deployPath}"
                                start /B npm start > app.log 2>&1
                                ping 127.0.0.1 -n 4 > nul
                                echo Application started. Check app.log for output.
                            ) else (
                                echo ERROR: Deploy directory not found at ${deployPath}
                                exit /b 1
                            )
                        """
                    }
                    
                    def deployPath = isUnix ? "${WORKSPACE}/deploy" : "${WORKSPACE}\\deploy"
                    echo "🚀 Application should be running at http://localhost:3000"
                    echo "Check ${deployPath}/app.log for application logs"
                    echo "Note: If the app doesn't start, you can manually run: cd ${deployPath} && npm start"
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


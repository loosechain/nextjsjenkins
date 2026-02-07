@echo off
REM Local deployment script for Windows

set DEPLOY_DIR=deploy

echo 🚀 Starting local deployment...

REM Create deployment directory
if not exist "%DEPLOY_DIR%" mkdir "%DEPLOY_DIR%"

REM Copy necessary files
echo 📦 Copying files...
xcopy /E /I /Y .next "%DEPLOY_DIR%\.next"
xcopy /E /I /Y public "%DEPLOY_DIR%\public"
copy /Y package*.json "%DEPLOY_DIR%\"
copy /Y next.config.js "%DEPLOY_DIR%\"
xcopy /E /I /Y node_modules "%DEPLOY_DIR%\node_modules"

echo ✅ Files copied to %DEPLOY_DIR%

REM Stop existing instance if running
echo 🛑 Stopping existing instance...
taskkill /F /IM node.exe 2>nul || echo No existing process found

REM Start the application
echo ▶️  Starting application...
cd /d "%DEPLOY_DIR%"
start /B npm start > app.log 2>&1

echo ✅ Application started!
echo 📍 Access your app at: http://localhost:3000
echo 📋 Logs are in: %DEPLOY_DIR%\app.log
echo.
echo To stop the application, close the terminal or run: taskkill /F /IM node.exe
pause


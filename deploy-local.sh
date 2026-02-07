#!/bin/bash
# Local deployment script for Unix/Linux/Mac

DEPLOY_DIR="./deploy"

echo "🚀 Starting local deployment..."

# Create deployment directory
mkdir -p ${DEPLOY_DIR}

# Copy necessary files
echo "📦 Copying files..."
cp -r .next ${DEPLOY_DIR}/
cp -r public ${DEPLOY_DIR}/
cp package*.json ${DEPLOY_DIR}/
cp next.config.js ${DEPLOY_DIR}/
cp -r node_modules ${DEPLOY_DIR}/

echo "✅ Files copied to ${DEPLOY_DIR}"

# Stop existing instance if running
echo "🛑 Stopping existing instance..."
pkill -f "node.*server.js" || echo "No existing process found"

# Start the application
echo "▶️  Starting application..."
cd ${DEPLOY_DIR}
npm start > app.log 2>&1 &
echo $! > app.pid

echo "✅ Application started!"
echo "📍 Access your app at: http://localhost:3000"
echo "📋 Logs are in: ${DEPLOY_DIR}/app.log"
echo "🆔 Process ID: $(cat app.pid)"
echo ""
echo "To stop the application, run: kill $(cat app.pid)"


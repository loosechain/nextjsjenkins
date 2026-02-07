# Connecting to Jenkins UI - Step by Step Guide

This guide will walk you through connecting your Next.js application to your Jenkins UI.

## Prerequisites

- ✅ Jenkins is installed and running (accessible at `http://localhost:8080` or your Jenkins URL)
- ✅ You have access to the Jenkins web interface
- ✅ Node.js is installed on your system

## Step 1: Initialize Git Repository (If Not Done)

Your project needs to be a Git repository for Jenkins to work with it.

### Option A: Local Git Repository (For Testing)

1. Open PowerShell or Command Prompt in your project directory
2. Run:
   ```bash
   git init
   git add .
   git commit -m "Initial commit - Next.js Jenkins project"
   ```

### Option B: Push to GitHub/GitLab (Recommended)

1. Create a new repository on GitHub/GitLab
2. Initialize and push:
   ```bash
   git init
   git add .
   git commit -m "Initial commit - Next.js Jenkins project"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

## Step 2: Access Jenkins UI

1. Open your web browser
2. Navigate to your Jenkins URL:
   - Local: `http://localhost:8080`
   - Remote: `http://your-jenkins-server:8080`
3. Log in with your Jenkins credentials

## Step 3: Install Required Jenkins Plugins

1. In Jenkins, click **Manage Jenkins** (left sidebar)
2. Click **Manage Plugins**
3. Go to the **Available** tab
4. Search for and install:
   - ✅ **Pipeline** (usually pre-installed)
   - ✅ **NodeJS Plugin** (for Node.js support)
   - ✅ **Git Plugin** (usually pre-installed)
5. Click **Install without restart** or **Download now and install after restart**
6. Restart Jenkins if prompted

## Step 4: Configure Node.js in Jenkins

1. Go to **Manage Jenkins** → **Global Tool Configuration**
2. Scroll down to **NodeJS** section
3. Click **Add NodeJS**
4. Configure:
   - **Name**: `NodeJS-18` (or any name)
   - **Version**: Select **Node.js 18.x** or higher from dropdown
   - ✅ Check **Install automatically**
5. Click **Save**

## Step 5: Create a New Jenkins Pipeline Job

### Method 1: Using Local File System (Easiest for Testing)

1. **Click "New Item"** on Jenkins dashboard
2. Enter job name: `nextjsjenkins` (or any name you prefer)
3. Select **Pipeline**
4. Click **OK**

5. **Configure the Pipeline:**
   - Scroll to **Pipeline** section
   - In **Definition**, select **Pipeline script from SCM**
   - **SCM**: Select **Git**
   - **Repository URL**: 
     - For local repo: `file:///C:/Users/jett/nextjsjenkins` (Windows)
     - For GitHub: `https://github.com/YOUR_USERNAME/YOUR_REPO.git`
   - **Credentials**: Leave empty for public repos
   - **Branch**: `*/main` or `*/master`
   - **Script Path**: `Jenkinsfile` (default)
   - Click **Save**

### Method 2: Using GitHub/GitLab (Recommended for Production)

1. **Click "New Item"** on Jenkins dashboard
2. Enter job name: `nextjsjenkins`
3. Select **Pipeline**
4. Click **OK**

5. **Configure the Pipeline:**
   - Scroll to **Pipeline** section
   - In **Definition**, select **Pipeline script from SCM**
   - **SCM**: Select **Git**
   - **Repository URL**: Your GitHub/GitLab URL
     - Example: `https://github.com/yourusername/nextjsjenkins.git`
   - **Credentials**: 
     - If private repo: Click **Add** → **Jenkins** → Add your GitHub/GitLab credentials
     - If public repo: Leave empty
   - **Branch**: `*/main` (or `*/master`)
   - **Script Path**: `Jenkinsfile`
   - Click **Save**

## Step 6: Run Your First Build

1. You should now see your job on the Jenkins dashboard
2. Click on the job name (`nextjsjenkins`)
3. Click **Build Now** (left sidebar)
4. You'll see a build appear in **Build History** (bottom left)
5. Click on the build number (#1) to see progress
6. Click **Console Output** to see detailed logs

## Step 7: Verify the Build

The pipeline will:
1. ✅ Checkout your code
2. ✅ Install Node.js dependencies
3. ✅ Run linter
4. ✅ Build the Next.js application
5. ✅ Deploy locally to `deploy/` directory
6. ✅ Start the application on `http://localhost:3000`

## Step 8: Access Your Deployed Application

After a successful build:
1. Open your browser
2. Navigate to: `http://localhost:3000`
3. You should see your Next.js application running!

## Troubleshooting

### Issue: "Node.js not found"
**Solution:**
- Go to **Manage Jenkins** → **Global Tool Configuration**
- Make sure Node.js is configured with a version selected
- Make sure **Install automatically** is checked

### Issue: "Git not found"
**Solution:**
- Install Git on your system
- Make sure Git is in your system PATH
- Restart Jenkins after installing Git

### Issue: "Cannot connect to repository"
**Solution:**
- For local file system: Use format `file:///C:/path/to/repo` (Windows) or `file:///path/to/repo` (Linux/Mac)
- For GitHub: Make sure the repository URL is correct
- For private repos: Add credentials in Jenkins

### Issue: "Build fails at npm ci"
**Solution:**
- Make sure `package.json` and `package-lock.json` exist
- If `package-lock.json` is missing, run `npm install` locally first
- Check that Node.js version matches your project requirements

### Issue: "Application not starting"
**Solution:**
- Check the console output in Jenkins for errors
- Verify port 3000 is not already in use
- Check `deploy/app.log` for application logs
- Try manually starting: `cd deploy && npm start`

## Next Steps

1. **Set up automatic builds** (see below)
2. **Add build notifications** (email, Slack, etc.)
3. **Customize deployment** location if needed
4. **Add tests** to your pipeline

## Setting Up Automatic Builds

### Option 1: Poll SCM (Check for changes periodically)

1. Go to your Jenkins job configuration
2. Scroll to **Build Triggers**
3. Check **Poll SCM**
4. Enter schedule: `H/5 * * * *` (checks every 5 minutes)
5. Click **Save**

### Option 2: GitHub Webhook (Automatic on push)

1. In Jenkins job, go to **Build Triggers**
2. Check **GitHub hook trigger for GITScm polling**
3. In GitHub: Go to repository → **Settings** → **Webhooks**
4. Click **Add webhook**
5. **Payload URL**: `http://your-jenkins-url/github-webhook/`
6. **Content type**: `application/json`
7. Click **Add webhook**

## Quick Reference

- **Jenkins URL**: Usually `http://localhost:8080`
- **Job Configuration**: Click job name → **Configure**
- **Build Now**: Click job name → **Build Now**
- **View Logs**: Click build number → **Console Output**
- **Application URL**: `http://localhost:3000` (after successful build)

---

**Need Help?** Check the main README.md for more detailed information.


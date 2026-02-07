# Setting Up Jenkins Job with Local Git - Step by Step

This guide will walk you through creating a Jenkins pipeline job that uses your local Git repository.

## ✅ Prerequisites Check

Before starting, make sure:
- [x] Git repository is initialized (already done!)
- [x] Files are committed (run `git commit -m "Initial commit"` if not done)
- [ ] Jenkins is installed and running
- [ ] You can access Jenkins UI (usually `http://localhost:8080`)

## 🎯 Step-by-Step: Create Jenkins Job

### Step 1: Open Jenkins UI

1. Open your web browser
2. Go to: `http://localhost:8080` (or your Jenkins URL)
3. Log in with your Jenkins credentials

### Step 2: Create New Item

1. On the Jenkins dashboard, click **"New Item"** (left sidebar, top)
   - If you don't see it, you might need to log in first
   
2. You'll see a page asking for:
   - **Item name**: Enter `nextjsjenkins` (or any name you like)
   - **Item type**: Select **"Pipeline"** (not Freestyle project)
   
3. Click **"OK"** button at the bottom

### Step 3: Configure the Pipeline

You'll now see the configuration page. Here's what to fill in:

#### Basic Settings (Top Section)
- **Description** (optional): You can leave this empty or add a description like "Next.js app with local deployment"

#### Build Triggers Section
- **Skip this section for now** - We'll build manually first

#### Pipeline Section (This is the important part!)

Scroll down to find the **"Pipeline"** section. Here's exactly what to set:

1. **Definition**: 
   - Click the dropdown
   - Select: **"Pipeline script from SCM"**
   - (This tells Jenkins to read the Jenkinsfile from Git)

2. **SCM**: 
   - Click the dropdown
   - Select: **"Git"**

3. **Repository URL**: 
   - **For Windows, enter exactly this:**
     ```
     file:///C:/Users/jett/nextjsjenkins
     ```
   - **Important notes:**
     - Use forward slashes `/` not backslashes `\`
     - Use `file:///` prefix (three slashes!)
     - Include the full path to your project folder
     - No `.git` at the end for local repos

4. **Credentials**: 
   - Leave this **empty** (not needed for local repos)

5. **Branch Specifier**: 
   - Enter: `*/master` or `*/main`
   - (Check which branch you're on with `git branch`)

6. **Script Path**: 
   - Enter: `Jenkinsfile`
   - (This is the default - Jenkins will look for this file)

7. **Lightweight checkout**: 
   - Leave this **unchecked** (default)

### Step 4: Save the Configuration

1. Scroll to the bottom of the page
2. Click **"Save"** button
3. You'll be taken to your new job's page

### Step 5: Configure Node.js (First Time Only)

Before running the build, Jenkins needs Node.js configured:

1. Go back to Jenkins dashboard
2. Click **"Manage Jenkins"** (left sidebar)
3. Click **"Global Tool Configuration"**
4. Scroll down to **"NodeJS"** section
5. Click **"Add NodeJS"** button
6. Fill in:
   - **Name**: `NodeJS-18` (or any name)
   - **Version**: Click dropdown, select **"Node.js 18.x"** or higher
   - ✅ Check the box: **"Install automatically"**
7. Click **"Save"** at the bottom

### Step 6: Run Your First Build

1. Go back to your job page (click `nextjsjenkins` in the dashboard)
2. Click **"Build Now"** (left sidebar)
3. You'll see a build appear in **"Build History"** (bottom left)
4. The build number will be **#1** (or higher if you've built before)

### Step 7: Watch the Build Progress

1. Click on the build number (#1) in Build History
2. You'll see a progress bar
3. Click **"Console Output"** to see detailed logs
4. Watch as it:
   - ✅ Checks out your code
   - ✅ Installs dependencies
   - ✅ Runs linter
   - ✅ Builds your app
   - ✅ Deploys locally
   - ✅ Starts the application

### Step 8: Access Your Deployed App

After the build completes successfully:
1. Open a new browser tab
2. Go to: `http://localhost:3000`
3. You should see your Next.js application! 🎉

## 📋 Quick Reference - What to Enter

When creating the Jenkins job, here's a quick checklist:

```
✅ Item name: nextjsjenkins
✅ Type: Pipeline
✅ Definition: Pipeline script from SCM
✅ SCM: Git
✅ Repository URL: file:///C:/Users/jett/nextjsjenkins
✅ Credentials: (leave empty)
✅ Branch: */master (or */main)
✅ Script Path: Jenkinsfile
```

## 🔍 Verify Your Git Branch

To check which branch you're on:
```bash
git branch
```

If you see `* master`, use `*/master` in Jenkins
If you see `* main`, use `*/main` in Jenkins

## 🐛 Troubleshooting

### Issue: "Cannot connect to repository"
**Solution:**
- Make sure the path is correct: `file:///C:/Users/jett/nextjsjenkins`
- Use forward slashes `/`, not backslashes `\`
- Make sure you've committed your files: `git commit -m "Initial commit"`
- Try the path with backslashes converted: `C:\Users\jett\nextjsjenkins` → `C:/Users/jett/nextjsjenkins`

### Issue: "Jenkinsfile not found"
**Solution:**
- Make sure `Jenkinsfile` exists in your project root
- Make sure you've committed it: `git commit -m "Initial commit"`
- Check Script Path is exactly: `Jenkinsfile` (case-sensitive)

### Issue: "Node.js not found"
**Solution:**
- Go to **Manage Jenkins** → **Global Tool Configuration**
- Make sure Node.js is added and configured
- Make sure "Install automatically" is checked

### Issue: "Build fails at checkout"
**Solution:**
- Make sure Git is installed on your system
- Make sure the repository path is correct
- Try running `git log` in your project folder to verify Git is working

### Issue: "Permission denied"
**Solution:**
- On Windows, make sure Jenkins service has access to your folder
- You might need to run Jenkins as administrator
- Or move your project to a location Jenkins can access (like `C:\Jenkins\workspace\`)

## 📸 Visual Guide

Here's what the Pipeline configuration section should look like:

```
┌─────────────────────────────────────────┐
│ Pipeline                                │
├─────────────────────────────────────────┤
│ Definition: [Pipeline script from SCM] │
│                                         │
│ SCM: [Git]                              │
│                                         │
│ Repository URL:                         │
│ [file:///C:/Users/jett/nextjsjenkins]  │
│                                         │
│ Credentials: [ - none - ]               │
│                                         │
│ Branch Specifier: [*/master]           │
│                                         │
│ Script Path: [Jenkinsfile]             │
│                                         │
│ ☐ Lightweight checkout                 │
└─────────────────────────────────────────┘
```

## ✅ Success Checklist

After setup, you should be able to:
- [ ] See your job in Jenkins dashboard
- [ ] Click "Build Now" and it starts
- [ ] See build progress in Console Output
- [ ] Build completes successfully
- [ ] Access app at `http://localhost:3000`

## 🎯 Next Steps

Once your first build works:
1. **Set up automatic builds** (optional):
   - Go to job configuration
   - Build Triggers → Poll SCM
   - Schedule: `H/5 * * * *` (checks every 5 minutes)

2. **Add build notifications** (optional):
   - Email notifications
   - Slack integration
   - etc.

3. **Customize deployment**:
   - Edit `Jenkinsfile` to change deployment location
   - Add more build steps
   - etc.

---

**That's it!** Your Next.js app is now connected to Jenkins with local Git. 🚀


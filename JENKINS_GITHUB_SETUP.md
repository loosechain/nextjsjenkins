# Jenkins Setup with GitHub - Quick Guide

Your code is already on GitHub! Here's how to configure Jenkins to use it.

## ✅ Current Status

- ✅ Code is on GitHub
- ✅ Branch: `main`
- ✅ Ready to connect to Jenkins

## 🎯 Step 1: Get Your GitHub Repository URL

Run this command to see your GitHub URL:
```bash
git remote -v
```

You'll see something like:
```
origin  https://github.com/YOUR_USERNAME/nextjsjenkins.git
```

**Copy this URL** - you'll need it for Jenkins!

## 🚀 Step 2: Create/Update Jenkins Job

### If Creating New Job:

1. **Open Jenkins UI:**
   - Go to `http://localhost:8080`
   - Click **"New Item"**

2. **Basic Settings:**
   - **Item name**: `nextjsjenkins`
   - **Type**: Select **"Pipeline"**
   - Click **"OK"**

3. **Pipeline Configuration:**
   - Scroll to **"Pipeline"** section
   - **Definition**: Select **"Pipeline script from SCM"**
   - **SCM**: Select **"Git"**
   - **Repository URL**: Paste your GitHub URL
     ```
     https://github.com/YOUR_USERNAME/nextjsjenkins.git
     ```
   - **Credentials**: 
     - If **public repo**: Leave empty (select "- none -")
     - If **private repo**: Add credentials (see below)
   - **Branch Specifier**: `*/main`
   - **Script Path**: `Jenkinsfile`
   - Click **"Save"**

### If Updating Existing Job:

1. Go to your job → Click **"Configure"**
2. Scroll to **"Pipeline"** section
3. **Repository URL**: Change from:
   ```
   file:///C:/Users/jett/nextjsjenkins
   ```
   To:
   ```
   https://github.com/YOUR_USERNAME/nextjsjenkins.git
   ```
4. **Branch Specifier**: Change to `*/main` (if not already)
5. Click **"Save"**

## 🔐 Step 3: Add Credentials (Only for Private Repos)

If your GitHub repo is **private**, you need credentials:

1. **Create Personal Access Token** (if you don't have one):
   - Go to: [github.com/settings/tokens](https://github.com/settings/tokens)
   - Click **"Generate new token"** → **"Generate new token (classic)"**
   - **Note**: "Jenkins Access"
   - **Expiration**: Choose duration
   - **Scopes**: Check **"repo"**
   - Click **"Generate token"**
   - **Copy the token** (you won't see it again!)

2. **Add to Jenkins:**
   - In Jenkins job configuration, click **"Add"** next to Credentials
   - **Kind**: Username with password
   - **Username**: Your GitHub username
   - **Password**: Your Personal Access Token (not your GitHub password!)
   - **ID**: Leave empty or name it "github-token"
   - **Description**: "GitHub Access Token"
   - Click **"Add"**
   - Select the credential from the dropdown

## ⚙️ Step 4: Configure Node.js (First Time Only)

1. **Manage Jenkins** → **Global Tool Configuration**
2. Scroll to **"NodeJS"** section
3. Click **"Add NodeJS"**
4. Configure:
   - **Name**: `NodeJS-18`
   - **Version**: Select Node.js 18.x or higher
   - ✅ Check **"Install automatically"**
5. Click **"Save"**

## 🏗️ Step 5: Run Your First Build

1. Go to your Jenkins job
2. Click **"Build Now"**
3. Watch the build progress
4. Click build number → **"Console Output"** to see logs
5. After success, visit: `http://localhost:3000`

## 🎣 Step 6: Set Up Automatic Builds (Optional)

### Option A: Poll SCM (Jenkins Checks Every X Minutes)

1. Job → **Configure** → **Build Triggers**
2. Check **"Poll SCM"**
3. Schedule: `H/5 * * * *` (every 5 minutes)
4. Click **"Save"**

### Option B: GitHub Webhook (Automatic on Push) - Recommended

1. **In Jenkins:**
   - Job → **Configure** → **Build Triggers**
   - Check **"GitHub hook trigger for GITScm polling"**
   - Click **"Save"**

2. **In GitHub:**
   - Go to your repository → **Settings** → **Webhooks**
   - Click **"Add webhook"**
   - **Payload URL**: `http://localhost:8080/github-webhook/`
     - (Or your Jenkins server URL)
   - **Content type**: `application/json`
   - **Events**: "Just the push event"
   - Click **"Add webhook"**

3. **Test:**
   - Make a change and push: `git push`
   - Jenkins should automatically build!

## 📋 Quick Reference

### Jenkins Configuration:
```
Repository URL: https://github.com/YOUR_USERNAME/nextjsjenkins.git
Branch: */main
Script Path: Jenkinsfile
Credentials: (only if private repo)
```

### Your Workflow:
```bash
# Make changes
git add .
git commit -m "Your changes"
git push

# Jenkins will build automatically (if webhook set up)
# OR click "Build Now" in Jenkins
```

## 🐛 Troubleshooting

### "Repository not found"
- Check URL is correct
- If private repo, add credentials
- Verify repo exists on GitHub

### "Authentication failed"
- Use Personal Access Token, not password
- Make sure token has "repo" scope
- Check token hasn't expired

### "Branch not found"
- You're on `main` branch (confirmed)
- Use `*/main` in Branch Specifier
- Verify branch exists on GitHub

### "Cannot connect"
- Check internet connection
- Verify GitHub URL works in browser
- Check firewall/proxy settings

## ✅ Checklist

- [ ] Get GitHub repository URL (`git remote -v`)
- [ ] Create/update Jenkins job
- [ ] Set Repository URL to GitHub
- [ ] Set Branch to `*/main`
- [ ] Add credentials (if private repo)
- [ ] Configure Node.js in Jenkins
- [ ] Run first build
- [ ] Verify app at `http://localhost:3000`
- [ ] (Optional) Set up webhook for auto-builds

---

**That's it!** Your Jenkins is now connected to GitHub. 🚀


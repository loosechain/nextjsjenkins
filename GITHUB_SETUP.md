# Setting Up GitHub and Jenkins - Complete Guide

This guide will help you push your code to GitHub and connect Jenkins to it.

## 🎯 Step 1: Create GitHub Repository

### Option A: Using GitHub Website (Recommended)

1. **Go to GitHub:**
   - Open [github.com](https://github.com) in your browser
   - Sign up (if new) or Log in

2. **Create New Repository:**
   - Click the **"+"** icon (top right) → **"New repository"**
   - Or go to: [github.com/new](https://github.com/new)

3. **Repository Settings:**
   - **Repository name**: `nextjsjenkins` (or any name you like)
   - **Description** (optional): "Next.js app deployed via Jenkins"
   - **Visibility**: 
     - ✅ **Public** (free, anyone can see code)
     - ✅ **Private** (only you can see, requires paid plan or free for students)
   - ⚠️ **DO NOT** check:
     - ❌ "Add a README file" (you already have one)
     - ❌ "Add .gitignore" (you already have one)
     - ❌ "Choose a license" (optional)
   
4. **Click "Create repository"**

5. **Copy the repository URL:**
   - You'll see a page with setup instructions
   - Copy the HTTPS URL (looks like: `https://github.com/YOUR_USERNAME/nextjsjenkins.git`)
   - **Save this URL** - you'll need it!

## 🚀 Step 2: Push Your Code to GitHub

### In Your Project Folder (PowerShell/Command Prompt)

Run these commands one by one:

```bash
# 1. Add GitHub as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/nextjsjenkins.git

# 2. Rename branch to 'main' (GitHub's default)
git branch -M main

# 3. Push your code to GitHub
git push -u origin main
```

**What each command does:**
- `git remote add origin` = Tells Git where GitHub is
- `git branch -M main` = Renames your branch to "main"
- `git push -u origin main` = Uploads your code to GitHub

**You'll be asked for credentials:**
- **Username**: Your GitHub username
- **Password**: Use a **Personal Access Token** (see below)

### Getting a Personal Access Token (GitHub Password)

GitHub no longer accepts regular passwords. You need a token:

1. **Go to GitHub Settings:**
   - Click your profile picture (top right) → **Settings**
   - Or go to: [github.com/settings/tokens](https://github.com/settings/tokens)

2. **Create Token:**
   - Click **"Developer settings"** (left sidebar)
   - Click **"Personal access tokens"** → **"Tokens (classic)"**
   - Click **"Generate new token"** → **"Generate new token (classic)"**

3. **Configure Token:**
   - **Note**: "Jenkins Access" (or any name)
   - **Expiration**: Choose how long (90 days, 1 year, etc.)
   - **Scopes**: Check **"repo"** (gives access to repositories)
   - Click **"Generate token"**

4. **Copy the Token:**
   - ⚠️ **IMPORTANT**: Copy it immediately! You won't see it again.
   - Use this token as your password when pushing

## 🔧 Step 3: Update Jenkins Configuration

### Update Your Jenkins Job

1. **Open Jenkins UI:**
   - Go to `http://localhost:8080`
   - Log in

2. **Edit Your Job:**
   - Click on your job name (`nextjsjenkins`)
   - Click **"Configure"** (left sidebar)

3. **Update Pipeline Section:**
   - Scroll to **"Pipeline"** section
   - Find **"Repository URL"**
   - **Change from:**
     ```
     file:///C:/Users/jett/nextjsjenkins
     ```
   - **Change to:**
     ```
     https://github.com/YOUR_USERNAME/nextjsjenkins.git
     ```
     (Replace `YOUR_USERNAME` with your actual GitHub username)

4. **Update Branch:**
   - **Branch Specifier**: Change to `*/main` (if you renamed to main)
   - Or keep `*/master` if you kept that branch name

5. **Credentials (If Private Repo):**
   - If your repo is **private**, you need credentials:
     - Click **"Add"** next to Credentials
     - **Kind**: Username with password
     - **Username**: Your GitHub username
     - **Password**: Your Personal Access Token (not your GitHub password!)
     - **ID**: Leave empty or give it a name like "github-token"
     - Click **"Add"**
     - Select the credential from dropdown

6. **Save:**
   - Click **"Save"** at the bottom

### If Creating New Job

If you're creating a new job, use these settings:

| Field | Value |
|-------|-------|
| **Item name** | `nextjsjenkins` |
| **Type** | Pipeline |
| **Definition** | Pipeline script from SCM |
| **SCM** | Git |
| **Repository URL** | `https://github.com/YOUR_USERNAME/nextjsjenkins.git` |
| **Credentials** | (Add if private repo) |
| **Branch Specifier** | `*/main` |
| **Script Path** | `Jenkinsfile` |

## ✅ Step 4: Test the Connection

1. **Run a Build:**
   - Go to your Jenkins job
   - Click **"Build Now"**
   - Watch the console output

2. **Verify:**
   - Build should checkout from GitHub
   - Should see: "Checking out code from repository..."
   - Build should complete successfully

## 🔄 Step 5: Workflow Going Forward

Now that you're using GitHub, here's your workflow:

### When You Make Changes:

```bash
# 1. Make changes to your code
# (edit files, add features, etc.)

# 2. Stage changes
git add .

# 3. Commit changes
git commit -m "Description of changes"

# 4. Push to GitHub
git push

# 5. Jenkins can automatically build (if you set up webhooks)
# OR manually click "Build Now" in Jenkins
```

## 🎣 Step 6: Set Up Automatic Builds (Optional)

### Option A: Poll SCM (Jenkins Checks Periodically)

1. Go to your Jenkins job → **Configure**
2. Scroll to **"Build Triggers"**
3. Check **"Poll SCM"**
4. Enter schedule: `H/5 * * * *` (checks every 5 minutes)
5. Click **Save**

### Option B: GitHub Webhook (Automatic on Push) - Recommended

1. **In Jenkins:**
   - Go to job → **Configure**
   - **Build Triggers** → Check **"GitHub hook trigger for GITScm polling"**
   - Click **Save**

2. **In GitHub:**
   - Go to your repository on GitHub
   - Click **"Settings"** (top tabs)
   - Click **"Webhooks"** (left sidebar)
   - Click **"Add webhook"**

3. **Webhook Configuration:**
   - **Payload URL**: `http://YOUR_JENKINS_URL/github-webhook/`
     - Local: `http://localhost:8080/github-webhook/`
     - Remote: `http://your-jenkins-server:8080/github-webhook/`
   - **Content type**: `application/json`
   - **Events**: Select **"Just the push event"**
   - ✅ **Active** (checked)
   - Click **"Add webhook"**

4. **Test:**
   - Make a small change
   - Push to GitHub: `git push`
   - Jenkins should automatically start a build!

## 🐛 Troubleshooting

### Issue: "Repository not found" or "Authentication failed"
**Solution:**
- Check your repository URL is correct
- If private repo, make sure credentials are set
- Use Personal Access Token, not password
- Make sure token has "repo" scope

### Issue: "Permission denied"
**Solution:**
- Verify your Personal Access Token is correct
- Make sure token hasn't expired
- Check token has "repo" permissions

### Issue: "Branch not found"
**Solution:**
- Check which branch you pushed: `git branch`
- Update Branch Specifier in Jenkins to match
- Common: `*/main` or `*/master`

### Issue: "Cannot connect to GitHub"
**Solution:**
- Check internet connection
- Verify GitHub URL is correct
- Try accessing the URL in browser
- Check if behind corporate firewall (may need proxy)

### Issue: "Webhook not triggering builds"
**Solution:**
- Make sure webhook URL is accessible from internet
- For local Jenkins, use a service like ngrok to expose it
- Check webhook delivery logs in GitHub
- Verify "GitHub hook trigger" is checked in Jenkins

## 📋 Quick Reference

### Your GitHub Repository URL Format:
```
https://github.com/YOUR_USERNAME/REPO_NAME.git
```

### Commands to Push Code:
```bash
git remote add origin https://github.com/YOUR_USERNAME/nextjsjenkins.git
git branch -M main
git push -u origin main
```

### Jenkins Repository URL:
```
https://github.com/YOUR_USERNAME/nextjsjenkins.git
```

### Jenkins Branch:
```
*/main
```
(or `*/master` if you kept that name)

## ✅ Checklist

- [ ] GitHub account created
- [ ] Repository created on GitHub
- [ ] Personal Access Token created
- [ ] Code pushed to GitHub (`git push`)
- [ ] Jenkins job updated with GitHub URL
- [ ] Jenkins credentials added (if private repo)
- [ ] Branch specifier updated to `*/main`
- [ ] Build tested successfully
- [ ] (Optional) Webhook configured for auto-builds

---

**You're all set!** Your code is now on GitHub and Jenkins can pull from it. 🚀


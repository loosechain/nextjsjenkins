# Quick Start - Connect to Jenkins UI

## 🎯 Fast Track (5 Minutes)

### 1. Make sure you have Git initialized
```bash
git add .
git commit -m "Initial commit"
```

### 2. Open Jenkins UI
- Go to: `http://localhost:8080` (or your Jenkins URL)
- Log in

### 3. Create New Pipeline Job
1. Click **"New Item"**
2. Name: `nextjsjenkins`
3. Select **Pipeline** → Click **OK**

### 4. Configure Pipeline
- **Definition**: Pipeline script from SCM
- **SCM**: Git
- **Repository URL**: 
  - **Local**: `file:///C:/Users/jett/nextjsjenkins` (Windows)
  - **GitHub**: `https://github.com/YOUR_USERNAME/YOUR_REPO.git`
- **Branch**: `*/main`
- **Script Path**: `Jenkinsfile`
- Click **Save**

### 5. Configure Node.js (First Time Only)
1. **Manage Jenkins** → **Global Tool Configuration**
2. **NodeJS** → **Add NodeJS**
3. **Name**: `NodeJS-18`
4. **Version**: Select Node.js 18.x
5. ✅ **Install automatically**
6. Click **Save**

### 6. Run Build
1. Click on your job
2. Click **Build Now**
3. Watch the build progress
4. After success, visit: `http://localhost:3000`

## ✅ That's It!

Your app is now connected to Jenkins and will deploy automatically on each build.

For detailed instructions, see [JENKINS_SETUP.md](./JENKINS_SETUP.md)


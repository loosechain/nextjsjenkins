# Git Explained - For Jenkins Setup

## 🤔 What is Git?

**Git** is a version control system that tracks changes to your code. Think of it like a time machine for your project - it saves snapshots of your code so you can:
- See what changed
- Go back to previous versions
- Share your code with others (like Jenkins)

## 🔗 Why Does Jenkins Need Git?

Jenkins needs Git because:
1. **Jenkins pulls your code from Git** - It doesn't directly access your files
2. **Jenkins reads the Jenkinsfile** - Your `Jenkinsfile` tells Jenkins what to do
3. **Version control** - Jenkins can build specific versions of your code
4. **Collaboration** - Multiple people can work on the same project

Think of it like this:
- **Your computer** = Your workspace (where you write code)
- **Git repository** = A shared storage (where code is saved)
- **Jenkins** = A robot that reads from Git and builds your app

## 📦 Git Basics - What You Need to Know

### Git Repository
A **repository** (or "repo") is a folder that Git tracks. It contains:
- Your code files
- A hidden `.git` folder (Git's history database)
- A `Jenkinsfile` (instructions for Jenkins)

### Basic Git Commands

#### 1. `git init` - Start Tracking
```bash
git init
```
**What it does:** Makes your folder a Git repository
**When to use:** First time only, in your project folder
**Status:** ✅ Already done for you!

#### 2. `git add .` - Stage Files
```bash
git add .
```
**What it does:** Tells Git "I want to save these files"
**The `.` means:** All files in the current folder
**When to use:** After you create or change files

#### 3. `git commit -m "message"` - Save a Snapshot
```bash
git commit -m "Initial commit - Next.js Jenkins project"
```
**What it does:** Saves a snapshot of your code with a message
**The message:** Describes what you changed
**When to use:** After `git add`, when you're ready to save

#### 4. `git status` - Check Status
```bash
git status
```
**What it does:** Shows what files changed and what's ready to commit
**When to use:** Anytime to see what Git knows about

## 🎯 For Your Jenkins Project - Step by Step

### Step 1: Check if Git is Initialized
```bash
git status
```
If you see "On branch main" or "On branch master" → ✅ Good!
If you see "not a git repository" → Run `git init`

### Step 2: Add Your Files
```bash
git add .
```
This stages all your files (package.json, Jenkinsfile, app folder, etc.)

### Step 3: Commit Your Files
```bash
git commit -m "Initial commit - Next.js Jenkins project"
```
This saves everything to Git's history.

### Step 4: Verify It Worked
```bash
git log
```
You should see your commit with the message you wrote.

## 🔄 Two Ways to Connect Git to Jenkins

### Option 1: Local Git Repository (Easiest for Testing)

**What it is:** Jenkins reads files directly from your computer

**Repository URL for Jenkins:**
```
file:///C:/Users/jett/nextjsjenkins
```

**Pros:**
- ✅ No internet needed
- ✅ Fast
- ✅ Simple setup

**Cons:**
- ❌ Only works if Jenkins is on the same computer
- ❌ Not good for team collaboration

**When to use:** Testing, learning, single developer

### Option 2: Remote Git Repository (GitHub/GitLab) - Recommended

**What it is:** Your code lives on the internet (GitHub, GitLab, etc.)

**Repository URL for Jenkins:**
```
https://github.com/yourusername/nextjsjenkins.git
```

**Pros:**
- ✅ Works from anywhere
- ✅ Team collaboration
- ✅ Backup of your code
- ✅ Professional setup

**Cons:**
- ❌ Requires internet
- ❌ Need to create account on GitHub/GitLab

**When to use:** Production, team projects, professional work

## 📤 How to Push to GitHub (Optional but Recommended)

If you want to use GitHub (recommended):

### Step 1: Create GitHub Repository
1. Go to [github.com](https://github.com)
2. Sign up/Log in
3. Click **"New repository"**
4. Name it: `nextjsjenkins`
5. Don't initialize with README (you already have files)
6. Click **"Create repository"**

### Step 2: Connect Your Local Git to GitHub
```bash
# Add GitHub as "remote" (where to push)
git remote add origin https://github.com/YOUR_USERNAME/nextjsjenkins.git

# Rename branch to "main" (GitHub's default)
git branch -M main

# Push your code to GitHub
git push -u origin main
```

**What this does:**
- `git remote add origin` = Tells Git where GitHub is
- `git branch -M main` = Names your branch "main"
- `git push` = Uploads your code to GitHub

### Step 3: Use GitHub URL in Jenkins
In Jenkins job configuration, use:
```
https://github.com/YOUR_USERNAME/nextjsjenkins.git
```

## 🎓 Git Workflow for This Project

Here's the typical workflow:

```
1. You write code
   ↓
2. git add .          (Stage changes)
   ↓
3. git commit -m "..." (Save snapshot)
   ↓
4. git push            (Upload to GitHub - if using)
   ↓
5. Jenkins detects change (or you click "Build Now")
   ↓
6. Jenkins pulls code from Git
   ↓
7. Jenkins reads Jenkinsfile
   ↓
8. Jenkins builds and deploys your app
```

## 🔍 Common Git Commands You'll Use

| Command | What It Does | When to Use |
|---------|-------------|-------------|
| `git status` | See what changed | Anytime |
| `git add .` | Stage all changes | After editing files |
| `git commit -m "msg"` | Save changes | After `git add` |
| `git log` | See commit history | To see what you saved |
| `git push` | Upload to GitHub | After commit (if using GitHub) |

## ❓ FAQ

### Q: Do I need GitHub?
**A:** No! You can use local Git. But GitHub is recommended for:
- Backup of your code
- Sharing with others
- Professional projects

### Q: What if I make a mistake?
**A:** Git is forgiving! You can:
- `git reset` - Undo changes
- `git checkout` - Go back to previous version
- Your files are safe - Git doesn't delete your work

### Q: Do I need to commit every time I change code?
**A:** No! Only commit when:
- You've finished a feature
- You want to save your progress
- You're ready to build/deploy

### Q: What's the difference between `git add` and `git commit`?
**A:** 
- `git add` = "I want to save these files" (staging)
- `git commit` = "Actually save them now" (saving)

Think of it like shopping:
- `git add` = Put items in shopping cart
- `git commit` = Check out and pay

## 🎯 Quick Checklist for Your Project

- [x] Git repository initialized (`git init` - already done!)
- [ ] Files added to Git (`git add .`)
- [ ] First commit made (`git commit -m "..."`)
- [ ] (Optional) Pushed to GitHub
- [ ] Jenkins job configured with Git URL
- [ ] Jenkins can read your Jenkinsfile

## 🚀 Next Steps

1. **Make your first commit:**
   ```bash
   git add .
   git commit -m "Initial commit - Next.js Jenkins project"
   ```

2. **Choose your Git setup:**
   - **Local only:** Use `file:///C:/Users/jett/nextjsjenkins` in Jenkins
   - **GitHub:** Create repo and push, then use GitHub URL in Jenkins

3. **Configure Jenkins** (see JENKINS_SETUP.md)

---

**Remember:** Git is just a way to save and share your code. Jenkins reads from Git to know what to build. That's it! 🎉


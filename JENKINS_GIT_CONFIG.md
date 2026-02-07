# Configuring Git in Jenkins

Even though Git is working, you can configure it properly in Jenkins to remove the warning.

## 🔍 Current Status

Your build log shows:
- ✅ Git IS working (checkout successful)
- ⚠️ Warning: "Selected Git installation does not exist. Using Default"

This warning is harmless, but we can fix it.

## 🛠️ How to Configure Git in Jenkins

### Method 1: Configure Git Tool (Recommended)

1. **Open Jenkins UI:**
   - Go to `http://localhost:8080`
   - Log in

2. **Navigate to Global Tool Configuration:**
   - Click **"Manage Jenkins"** (left sidebar)
   - Look for one of these:
     - **"Global Tool Configuration"**
     - **"Configure Tools"**
     - **"Tools"**
   - OR try direct URL: `http://localhost:8080/configureTools`

3. **Find Git Section:**
   - Scroll down to find **"Git"** section
   - Click **"Add Git"** button

4. **Configure Git:**
   - **Name**: `Default` (or any name like "System Git")
   - **Path to Git executable**: 
     - Find your Git path by running in PowerShell:
       ```powershell
       where.exe git
       ```
     - Common paths:
       - `C:\Program Files\Git\cmd\git.exe`
       - `C:\Program Files (x86)\Git\cmd\git.exe`
       - Or just: `git` (if in PATH)
   - Click **"Save"**

### Method 2: Find Your Git Path

Run this in PowerShell to find where Git is installed:

```powershell
where.exe git
```

Or:

```powershell
Get-Command git | Select-Object -ExpandProperty Source
```

Copy the path and use it in Jenkins configuration.

### Method 3: Use Git from PATH (Easiest)

If Git is in your system PATH (which it seems to be, since it's working):

1. In Jenkins Git configuration
2. **Path to Git executable**: Just enter `git`
3. Jenkins will use Git from your system PATH

## ✅ Verify Git is Working

Your build log already shows Git is working:
```
git --version # 'git version 2.47.1.windows.2'
Checking out Revision 238c0ee...
```

So Git configuration is **optional** - it's just to remove the warning.

## 🎯 The Real Issue

The actual problem in your build is:
- ❌ `'next' is not recognized` - Dependencies aren't installed
- This is because `npm ci` might be failing silently

Let's fix the npm installation issue in the Jenkinsfile instead!

---

**Note:** Git is working fine. The warning is just cosmetic. The real issue is npm dependencies not installing.


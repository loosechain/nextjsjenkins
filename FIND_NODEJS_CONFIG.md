# Finding Node.js Configuration in Jenkins

If you can't find "Global Tool Configuration", here are different ways to access it depending on your Jenkins setup.

## 🔍 Method 1: Different Menu Locations

The location varies by Jenkins version and setup. Try these paths:

### Option A: From Dashboard
1. On Jenkins homepage, look for:
   - **"Manage Jenkins"** (left sidebar)
   - OR **"Configure System"** (left sidebar)
   - OR click your username (top right) → **"Configure"**

### Option B: Direct URL
Try going directly to:
```
http://localhost:8080/configureTools
```
Or:
```
http://localhost:8080/manage/configureTools
```

### Option C: Through Manage Jenkins
1. Click **"Manage Jenkins"** (left sidebar)
2. Look for:
   - **"Global Tool Configuration"**
   - OR **"Tools"**
   - OR **"Configure Tools"**
   - OR scroll down to find tool-related options

## 🔍 Method 2: Check Your Jenkins Version

Different Jenkins versions have different layouts:

### Jenkins 2.x (Modern)
- **Manage Jenkins** → **Global Tool Configuration**

### Jenkins Classic/Blue Ocean
- Look for **"Configure"** or **"Settings"** icon
- Or try: **Dashboard** → **Manage Jenkins** → **Configure System**

## 🔍 Method 3: Alternative - Install Node.js Plugin First

Sometimes you need the plugin installed first:

1. **Manage Jenkins** → **Manage Plugins**
2. Go to **"Available"** tab
3. Search for: **"NodeJS Plugin"**
4. Check the box
5. Click **"Install without restart"** or **"Download now and install after restart"**
6. After restart, the option should appear

## 🔍 Method 4: Check Permissions

If you don't see the option, you might need admin permissions:

1. Check if you're logged in as admin
2. Look for **"Configure System"** instead
3. Ask your Jenkins administrator for access

## 🎯 Method 5: Configure Node.js in Pipeline Directly

If you can't find Global Tool Configuration, you can configure Node.js directly in your Jenkinsfile!

### Update Your Jenkinsfile

I'll show you how to modify the Jenkinsfile to use Node.js without Global Tool Configuration.

## 📋 What to Look For

In the Jenkins UI, look for these menu items:
- ✅ **Manage Jenkins**
- ✅ **Configure System**
- ✅ **Global Tool Configuration**
- ✅ **Tools**
- ✅ **NodeJS** (in any of the above)

## 🆘 Still Can't Find It?

If you still can't find it, we can:
1. **Configure Node.js in the Jenkinsfile directly** (no UI needed)
2. **Use a different approach** that doesn't require Global Tool Configuration
3. **Check your Jenkins installation** to see what's available

Let me know what you see in your Jenkins UI, and I'll help you find the right path!


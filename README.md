# Next.js Jenkins Deployment Guide

A simple Next.js application configured for deployment via Jenkins CI/CD pipeline.

## 🚀 Quick Start

### Prerequisites

Before you begin, make sure you have:
- **Node.js** (v18 or higher) installed
- **npm** or **yarn** package manager
- **Jenkins** server installed and running
- **Git** for version control

### Local Development

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Run the development server:**
   ```bash
   npm run dev
   ```

3. **Open your browser:**
   Navigate to [http://localhost:3000](http://localhost:3000)

4. **Build for production:**
   ```bash
   npm run build
   npm start
   ```

## 📦 Jenkins Setup Guide

> **🚀 Quick Connection Guide**: See [JENKINS_SETUP.md](./JENKINS_SETUP.md) for step-by-step instructions to connect this project to your Jenkins UI.

### Step 1: Install Jenkins

#### Windows:
1. Download Jenkins from [https://www.jenkins.io/download/](https://www.jenkins.io/download/)
2. Download the Windows installer (jenkins.msi)
3. Run the installer and follow the setup wizard
4. Jenkins will start automatically and open in your browser at `http://localhost:8080`
5. Follow the initial setup wizard to unlock Jenkins and install recommended plugins

#### Alternative (Docker):
```bash
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

### Step 2: Install Required Jenkins Plugins

1. Go to **Manage Jenkins** → **Manage Plugins**
2. Install the following plugins (if not already installed):
   - **Pipeline** (usually pre-installed)
   - **NodeJS Plugin** (for Node.js support)
   - **Git Plugin** (usually pre-installed)
   - **Docker Pipeline** (optional, if using Docker)

### Step 3: Configure Node.js in Jenkins

1. Go to **Manage Jenkins** → **Global Tool Configuration**
2. Scroll down to **NodeJS**
3. Click **Add NodeJS**
4. Set:
   - **Name**: `NodeJS-18` (or any name you prefer)
   - **Version**: Select Node.js 18.x or higher
   - Check **Install automatically**
5. Click **Save**

### Step 4: Create a New Jenkins Job

1. **Create a new Pipeline job:**
   - Click **New Item** on the Jenkins dashboard
   - Enter a name (e.g., "nextjsjenkins")
   - Select **Pipeline**
   - Click **OK**

2. **Configure the Pipeline:**
   - Scroll down to **Pipeline** section
   - In **Definition**, select **Pipeline script from SCM**
   - **SCM**: Select **Git**
   - **Repository URL**: Enter your Git repository URL
     - If using GitHub: `https://github.com/yourusername/nextjsjenkins.git`
     - If using local repo: Use the file path or set up a Git server
   - **Credentials**: Add credentials if your repo is private
   - **Branch**: `*/main` or `*/master` (depending on your default branch)
   - **Script Path**: `Jenkinsfile` (this is the default)
   - Click **Save**

### Step 5: Run Your First Build

1. Click on your job name in the Jenkins dashboard
2. Click **Build Now**
3. Watch the build progress in the **Build History** section
4. Click on the build number to see the console output
5. The pipeline will:
   - Checkout your code
   - Install dependencies
   - Run linter
   - Build the Next.js application
   - Archive artifacts
   - **Deploy locally** to the `deploy` directory
   - **Start the application** automatically

6. **After the build completes**, open your browser and go to `http://localhost:3000` to see your deployed application!

### Step 6: Understanding the Jenkinsfile

The `Jenkinsfile` in this project defines the CI/CD pipeline with these stages:

1. **Checkout**: Gets the code from your repository
2. **Install Dependencies**: Runs `npm ci` to install packages
3. **Lint**: Runs the linter (won't fail the build if linting fails)
4. **Build**: Builds the Next.js application
5. **Archive Artifacts**: Saves the build output
6. **Deploy**: Copies the built application to a local `deploy` directory
7. **Start Application**: Automatically starts the Next.js server on port 3000

### Step 7: Local Deployment

The `Jenkinsfile` is configured for **local deployment** by default. When you run a build, it will:

1. **Build the application** - Creates the production build
2. **Deploy locally** - Copies all necessary files to a `deploy` directory in your Jenkins workspace
3. **Start the application** - Automatically starts the Next.js server

#### How Local Deployment Works

After a successful build:
- The application is copied to `${WORKSPACE}/deploy` directory
- The application automatically starts on `http://localhost:3000`
- Logs are saved to `deploy/app.log`

#### Accessing Your Deployed Application

1. **After Jenkins build completes**, open your browser
2. Navigate to: `http://localhost:3000`
3. You should see your Next.js application running

#### Manual Deployment (Alternative)

If you prefer to deploy manually without Jenkins:

**Windows:**
```bash
deploy-local.bat
```

**Linux/Mac:**
```bash
chmod +x deploy-local.sh
./deploy-local.sh
```

**Or manually:**
1. Build the application: `npm run build`
2. Navigate to the project directory
3. Run: `npm start`
4. Open `http://localhost:3000` in your browser

#### Customizing Deployment Location

To deploy to a different local directory, edit the `DEPLOY_DIR` environment variable in the `Jenkinsfile`:

```groovy
environment {
    DEPLOY_DIR = "C:/deployments/nextjsjenkins"  // Windows
    // or
    DEPLOY_DIR = "/var/www/nextjsjenkins"        // Linux/Mac
}
```

#### Other Deployment Options

If you want to deploy elsewhere instead of locally:

##### Option A: Deploy to a Server via SSH

Modify the Deploy stage in `Jenkinsfile`:
```groovy
stage('Deploy') {
    steps {
        sh '''
            scp -r .next user@your-server:/path/to/app/
            ssh user@your-server "cd /path/to/app && npm start"
        '''
    }
}
```

##### Option B: Deploy Using Docker

```groovy
stage('Deploy') {
    steps {
        sh '''
            docker build -t nextjsjenkins:latest .
            docker stop nextjsjenkins || true
            docker rm nextjsjenkins || true
            docker run -d -p 3000:3000 --name nextjsjenkins nextjsjenkins:latest
        '''
    }
}
```

### Step 8: Set Up Automatic Builds (Optional)

To trigger builds automatically on Git push:

1. Go to your Jenkins job configuration
2. Scroll to **Build Triggers**
3. Check **GitHub hook trigger for GITScm polling** (if using GitHub)
   OR
4. Check **Poll SCM** and set schedule: `H/5 * * * *` (checks every 5 minutes)
5. Save

For GitHub webhooks:
- Go to your GitHub repository → Settings → Webhooks
- Add webhook URL: `http://your-jenkins-url/github-webhook/`
- Set content type to `application/json`

## 🐳 Docker Deployment

This project includes a `Dockerfile` for containerized deployment:

```bash
# Build the Docker image
docker build -t nextjsjenkins .

# Run the container
docker run -p 3000:3000 nextjsjenkins
```

## 📁 Project Structure

```
nextjsjenkins/
├── app/                 # Next.js app directory
│   ├── layout.tsx      # Root layout
│   ├── page.tsx        # Home page
│   └── globals.css     # Global styles
├── Jenkinsfile         # Jenkins pipeline configuration
├── Dockerfile          # Docker configuration
├── deploy-local.sh     # Manual deployment script (Unix/Linux/Mac)
├── deploy-local.bat    # Manual deployment script (Windows)
├── package.json        # Dependencies and scripts
├── next.config.js      # Next.js configuration
├── tsconfig.json       # TypeScript configuration
└── README.md           # This file
```

## 🔧 Troubleshooting

### Jenkins can't find Node.js
- Make sure Node.js plugin is installed
- Configure Node.js in Global Tool Configuration
- Check that the Node.js version matches your project requirements

### Build fails with "npm: command not found"
- Install Node.js plugin in Jenkins
- Configure Node.js in Jenkins Global Tool Configuration
- Make sure Node.js is added to PATH in Jenkins environment

### Permission denied errors
- Check Jenkins user permissions
- Ensure Jenkins has access to the workspace directory
- On Linux/Mac, you may need to adjust file permissions

### Build artifacts not found
- Check that the build actually completed successfully
- Verify the `.next` directory exists after build
- Adjust the archiveArtifacts path if needed

### Application not accessible after deployment
- Check if the application started successfully by viewing `deploy/app.log`
- Verify port 3000 is not already in use: `netstat -ano | findstr :3000` (Windows) or `lsof -i :3000` (Linux/Mac)
- Check Jenkins console output for any errors during the Start Application stage
- Try manually starting: `cd deploy && npm start`

## 📚 Additional Resources

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)

## 🎯 Next Steps

1. **Set up your Git repository** and push this code
2. **Configure Jenkins** following the steps above
3. **Customize the deployment** stage for your target environment
4. **Set up notifications** (email, Slack, etc.) for build status
5. **Add tests** to your pipeline for better quality assurance

## 📝 License

This project is open source and available for use.

---

**Happy Deploying! 🚀**


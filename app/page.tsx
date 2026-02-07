export default function Home() {
  return (
    <main className="container">
      <div className="content">
        <h1>Welcome to Next.js + Jenkins</h1>
        <p className="subtitle">
          This application is deployed via Jenkins CI/CD pipeline
        </p>
        <div className="info-card">
          <h2>Application Status</h2>
          <p className="status">✅ Running Successfully</p>
          <p className="details">
            Built with Next.js {process.env.npm_package_dependencies_next || '14.0.0'}
          </p>
        </div>
        <div className="features">
          <h2>Features</h2>
          <ul>
            <li>🚀 Next.js 14 with App Router</li>
            <li>🔧 TypeScript Support</li>
            <li>📦 Automated CI/CD with Jenkins</li>
            <li>🎨 Modern UI with CSS</li>
          </ul>
        </div>
      </div>
    </main>
  )
}


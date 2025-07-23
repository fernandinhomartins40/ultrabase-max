#!/usr/bin/env node

const fs = require('fs')
const path = require('path')
const { execSync } = require('child_process')
const readline = require('readline')

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

const question = (query) => new Promise((resolve) => rl.question(query, resolve))

console.log(`
🚀 Ultrabase Setup Script
=========================

This script will help you set up Ultrabase (multi-tenant Supabase) on your machine.
`)

async function main() {
  try {
    console.log('\n📋 Checking prerequisites...')
    
    // Check Node.js version
    const nodeVersion = process.version
    const majorVersion = parseInt(nodeVersion.slice(1).split('.')[0])
    if (majorVersion < 22) {
      console.error('❌ Node.js 22 or higher is required')
      process.exit(1)
    }
    console.log(`✅ Node.js ${nodeVersion} detected`)

    // Check pnpm
    try {
      execSync('pnpm --version', { stdio: 'ignore' })
      console.log('✅ pnpm detected')
    } catch {
      console.error('❌ pnpm is required. Install with: npm install -g pnpm')
      process.exit(1)
    }

    // Check Docker
    try {
      execSync('docker --version', { stdio: 'ignore' })
      console.log('✅ Docker detected')
    } catch {
      console.error('❌ Docker is required. Install from https://docker.com')
      process.exit(1)
    }

    // Check Docker Compose
    try {
      execSync('docker compose version', { stdio: 'ignore' })
      console.log('✅ Docker Compose detected')
    } catch {
      console.error('❌ Docker Compose is required')
      process.exit(1)
    }

    console.log('\n📦 Installing dependencies...')
    execSync('pnpm install', { stdio: 'inherit' })

    console.log('\n🔧 Setting up environment...')
    
    // Copy environment files if they don't exist
    const dockerEnvPath = path.join(__dirname, '..', 'docker', '.env')
    const dockerEnvExamplePath = path.join(__dirname, '..', 'docker', '.env.example')
    
    if (!fs.existsSync(dockerEnvPath) && fs.existsSync(dockerEnvExamplePath)) {
      fs.copyFileSync(dockerEnvExamplePath, dockerEnvPath)
      console.log('✅ Created docker/.env from example')
    }

    // Ask for configuration
    console.log('\n⚙️  Configuration')
    const apiUrl = await question('API URL (default: http://localhost:8000): ') || 'http://localhost:8000'
    const studioUrl = await question('Studio URL (default: http://localhost:8082): ') || 'http://localhost:8082'

    // Update .env file
    const envContent = fs.readFileSync(dockerEnvPath, 'utf8')
    const updatedEnv = envContent
      .replace(/API_EXTERNAL_URL=.*/, `API_EXTERNAL_URL=${apiUrl}`)
      .replace(/SUPABASE_PUBLIC_URL=.*/, `SUPABASE_PUBLIC_URL=${apiUrl}`)
      .replace(/SITE_URL=.*/, `SITE_URL=${studioUrl}`)
    
    fs.writeFileSync(dockerEnvPath, updatedEnv)
    console.log('✅ Updated environment configuration')

    console.log('\n🗄️  Setting up database...')
    
    // Start Supabase services
    console.log('Starting services...')
    execSync('cd docker && docker compose up -d', { stdio: 'inherit' })

    // Wait for services to be ready
    console.log('Waiting for services to be ready...')
    await new Promise(resolve => setTimeout(resolve, 10000))

    // Apply migrations
    console.log('Applying database migrations...')
    try {
      execSync('pnpm supabase db reset --local', { stdio: 'inherit' })
      console.log('✅ Database migrations applied')
    } catch (error) {
      console.warn('⚠️  Could not apply migrations automatically. Run manually: pnpm supabase db reset --local')
    }

    console.log('\n🎉 Setup Complete!')
    console.log(`
📍 Access Points:
   • Studio: ${studioUrl}
   • API: ${apiUrl}
   • Docs: http://localhost:3001/docs

🔑 Default Credentials:
   • Studio: Check docker/.env for DASHBOARD_USERNAME and DASHBOARD_PASSWORD

📚 Next Steps:
   1. Open ${studioUrl} in your browser
   2. Create your first organization
   3. Create your first project
   4. Invite team members

🛠️  Development:
   • Start development: pnpm dev
   • Start studio only: pnpm dev:studio
   • Run tests: pnpm test:studio

❓ Need help?
   • Check ULTRABASE_README.md
   • Join our Discord: https://discord.gg/ultrabase
   • Open an issue: https://github.com/fernandinhomartins40/ultrabase-max/issues
    `)

  } catch (error) {
    console.error('\n❌ Setup failed:', error.message)
    console.log('\n💡 Try running the steps manually:')
    console.log('1. pnpm install')
    console.log('2. cd docker && docker compose up -d')
    console.log('3. pnpm supabase db reset --local')
  } finally {
    rl.close()
  }
}

main()

import { Command } from 'commander'
import chalk from 'chalk'
import inquirer from 'inquirer'
import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'
import { homedir } from 'os'

const program = new Command()

// Ultrabase CLI Configuration
interface UltrabaseConfig {
  apiUrl: string
  accessToken: string
  currentProject?: string
  currentOrganization?: string
}

class UltrabaseCLI {
  private configPath: string
  private config: UltrabaseConfig

  constructor() {
    this.configPath = path.join(homedir(), '.ultrabase', 'config.json')
    this.config = this.loadConfig()
  }

  private loadConfig(): UltrabaseConfig {
    try {
      if (fs.existsSync(this.configPath)) {
        const configData = fs.readFileSync(this.configPath, 'utf8')
        return JSON.parse(configData)
      }
    } catch (error) {
      console.error('Error loading config:', error)
    }

    return {
      apiUrl: 'http://localhost:8082',
      accessToken: '',
    }
  }

  private saveConfig() {
    try {
      const configDir = path.dirname(this.configPath)
      if (!fs.existsSync(configDir)) {
        fs.mkdirSync(configDir, { recursive: true })
      }

      fs.writeFileSync(this.configPath, JSON.stringify(this.config, null, 2))
    } catch (error) {
      console.error('Error saving config:', error)
    }
  }

  async login(apiUrl?: string) {
    console.log(chalk.blue('🔐 Ultrabase Login'))

    const answers = await inquirer.prompt([
      {
        type: 'input',
        name: 'apiUrl',
        message: 'API URL:',
        default: apiUrl || this.config.apiUrl,
      },
      {
        type: 'input',
        name: 'accessToken',
        message: 'Access Token:',
        validate: (input) => input.length > 0 || 'Access token is required',
      },
    ])

    this.config.apiUrl = answers.apiUrl
    this.config.accessToken = answers.accessToken

    // Test the connection
    try {
      const response = await fetch(`${answers.apiUrl}/api/ultrabase/organizations`, {
        headers: {
          Authorization: `Bearer ${answers.accessToken}`,
        },
      })

      if (!response.ok) {
        throw new Error('Invalid credentials')
      }

      this.saveConfig()
      console.log(chalk.green('✅ Successfully logged in!'))
    } catch (error) {
      console.error(chalk.red('❌ Login failed:', error))
    }
  }

  async listOrganizations() {
    console.log(chalk.blue('🏢 Your Organizations'))

    try {
      const response = await fetch(`${this.config.apiUrl}/api/ultrabase/organizations`, {
        headers: {
          Authorization: `Bearer ${this.config.accessToken}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to fetch organizations')
      }

      const organizations = await response.json()

      if (organizations.length === 0) {
        console.log(chalk.yellow('No organizations found'))
        return
      }

      organizations.forEach((org: any) => {
        console.log(`${chalk.green('•')} ${org.name} (${org.slug}) - ${org.role}`)
      })
    } catch (error) {
      console.error(chalk.red('❌ Error:', error))
    }
  }

  async listProjects() {
    console.log(chalk.blue('📁 Your Projects'))

    try {
      const response = await fetch(`${this.config.apiUrl}/api/ultrabase/projects`, {
        headers: {
          Authorization: `Bearer ${this.config.accessToken}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to fetch projects')
      }

      const projects = await response.json()

      if (projects.length === 0) {
        console.log(chalk.yellow('No projects found'))
        return
      }

      projects.forEach((project: any) => {
        console.log(
          `${chalk.green('•')} ${project.name} (${project.slug}) - ${project.organizationName}`
        )
        console.log(`  Role: ${project.role}, Status: ${project.status}`)
      })
    } catch (error) {
      console.error(chalk.red('❌ Error:', error))
    }
  }

  async createOrganization() {
    console.log(chalk.blue('🏢 Create New Organization'))

    const answers = await inquirer.prompt([
      {
        type: 'input',
        name: 'name',
        message: 'Organization name:',
        validate: (input) => input.length > 0 || 'Name is required',
      },
      {
        type: 'input',
        name: 'slug',
        message: 'Organization slug:',
        validate: (input) =>
          /^[a-z0-9-]+$/.test(input) || 'Slug must be lowercase letters, numbers, and hyphens',
      },
      {
        type: 'input',
        name: 'billingEmail',
        message: 'Billing email (optional):',
      },
    ])

    try {
      const response = await fetch(`${this.config.apiUrl}/api/ultrabase/organizations`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${this.config.accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(answers),
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error || 'Failed to create organization')
      }

      const organization = await response.json()
      console.log(chalk.green(`✅ Organization "${organization.name}" created successfully!`))
    } catch (error) {
      console.error(chalk.red('❌ Error:', error))
    }
  }

  async createProject() {
    console.log(chalk.blue('📁 Create New Project'))

    // First, list organizations
    const orgResponse = await fetch(`${this.config.apiUrl}/api/ultrabase/organizations`, {
      headers: {
        Authorization: `Bearer ${this.config.accessToken}`,
      },
    })

    if (!orgResponse.ok) {
      console.error(chalk.red('❌ Failed to fetch organizations'))
      return
    }

    const organizations = await orgResponse.json()

    if (organizations.length === 0) {
      console.log(
        chalk.yellow('No organizations found. Create one first with: ultrabase org create')
      )
      return
    }

    const answers = await inquirer.prompt([
      {
        type: 'list',
        name: 'organizationId',
        message: 'Select organization:',
        choices: organizations.map((org: any) => ({
          name: `${org.name} (${org.slug})`,
          value: org.id,
        })),
      },
      {
        type: 'input',
        name: 'name',
        message: 'Project name:',
        validate: (input) => input.length > 0 || 'Name is required',
      },
      {
        type: 'input',
        name: 'description',
        message: 'Project description (optional):',
      },
    ])

    try {
      const response = await fetch(`${this.config.apiUrl}/api/ultrabase/projects`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${this.config.accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(answers),
      })

      if (!response.ok) {
        const error = await response.json()
        throw new Error(error.error || 'Failed to create project')
      }

      const project = await response.json()
      console.log(chalk.green(`✅ Project "${project.name}" created successfully!`))
      console.log(chalk.blue(`🔗 URL: ${this.config.apiUrl}/project/${project.slug}`))
    } catch (error) {
      console.error(chalk.red('❌ Error:', error))
    }
  }

  async useProject(projectSlug: string) {
    try {
      const response = await fetch(`${this.config.apiUrl}/api/ultrabase/projects`, {
        headers: {
          Authorization: `Bearer ${this.config.accessToken}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to fetch projects')
      }

      const projects = await response.json()
      const project = projects.find((p: any) => p.slug === projectSlug)

      if (!project) {
        console.error(chalk.red(`❌ Project "${projectSlug}" not found`))
        return
      }

      this.config.currentProject = project.id
      this.config.currentOrganization = project.organizationId
      this.saveConfig()

      console.log(chalk.green(`✅ Now using project: ${project.name}`))
    } catch (error) {
      console.error(chalk.red('❌ Error:', error))
    }
  }

  async showStatus() {
    console.log(chalk.blue('📊 Ultrabase Status'))
    console.log(`API URL: ${this.config.apiUrl}`)
    console.log(`Logged in: ${this.config.accessToken ? 'Yes' : 'No'}`)
    console.log(`Current project: ${this.config.currentProject || 'None'}`)
    console.log(`Current organization: ${this.config.currentOrganization || 'None'}`)
  }
}

// CLI Commands
const cli = new UltrabaseCLI()

program
  .name('ultrabase')
  .description('Ultrabase CLI - Multi-tenant Supabase management')
  .version('1.0.0')

// Login command
program
  .command('login')
  .description('Login to Ultrabase')
  .option('--url <url>', 'API URL')
  .action(async (options) => {
    await cli.login(options.url)
  })

// Organization commands
const orgCmd = program.command('org').description('Organization management')

orgCmd
  .command('list')
  .alias('ls')
  .description('List your organizations')
  .action(async () => {
    await cli.listOrganizations()
  })

orgCmd
  .command('create')
  .description('Create a new organization')
  .action(async () => {
    await cli.createOrganization()
  })

// Project commands
const projectCmd = program.command('project').description('Project management')

projectCmd
  .command('list')
  .alias('ls')
  .description('List your projects')
  .action(async () => {
    await cli.listProjects()
  })

projectCmd
  .command('create')
  .description('Create a new project')
  .action(async () => {
    await cli.createProject()
  })

projectCmd
  .command('use <slug>')
  .description('Set the current project')
  .action(async (slug: string) => {
    await cli.useProject(slug)
  })

// Status command
program
  .command('status')
  .description('Show current status')
  .action(async () => {
    await cli.showStatus()
  })

// Export for programmatic use
export { UltrabaseCLI, program }
export default program

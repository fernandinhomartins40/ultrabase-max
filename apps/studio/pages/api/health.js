// Health check endpoint for Docker and load balancers
export default function handler(req, res) {
  // Only allow GET method
  if (req.method !== 'GET') {
    return res.status(405).json({
      error: 'Method not allowed',
      message: `Method ${req.method} not allowed. Use GET.`,
    })
  }

  try {
    // Basic health check information
    const healthCheck = {
      status: 'healthy',
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      environment: process.env.NODE_ENV || 'development',
      service: 'ultrabase-studio',
      version: process.env.npm_package_version || '1.0.0',
      deployment_platform: process.env.NEXT_PUBLIC_DEPLOYMENT_PLATFORM || 'unknown',
      memory: {
        used: Math.round(process.memoryUsage().heapUsed / 1024 / 1024),
        total: Math.round(process.memoryUsage().heapTotal / 1024 / 1024),
        rss: Math.round(process.memoryUsage().rss / 1024 / 1024),
      },
    }

    // Additional checks for production environment
    if (process.env.NODE_ENV === 'production') {
      // Check if required environment variables are set
      const requiredEnvVars = ['SUPABASE_URL', 'SUPABASE_ANON_KEY', 'SUPABASE_SERVICE_KEY']

      const missingEnvVars = requiredEnvVars.filter((varName) => !process.env[varName])

      if (missingEnvVars.length > 0) {
        healthCheck.status = 'unhealthy'
        healthCheck.error = 'Missing required environment variables'
        healthCheck.details = {
          missing: missingEnvVars,
        }
        return res.status(503).json(healthCheck)
      }
    }

    // Set headers for proper health check response
    res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate')
    res.setHeader('Pragma', 'no-cache')
    res.setHeader('Expires', '0')
    res.setHeader('Content-Type', 'application/json')

    res.status(200).json(healthCheck)
  } catch (error) {
    console.error('Health check failed:', error)

    const healthCheck = {
      status: 'unhealthy',
      timestamp: new Date().toISOString(),
      service: 'ultrabase-studio',
      error: 'Internal server error',
      message: error.message || 'Unknown error',
    }

    res.status(503).json(healthCheck)
  }
}

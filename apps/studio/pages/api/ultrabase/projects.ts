import { NextApiRequest, NextApiResponse } from 'next'
import { createClient } from '@supabase/supabase-js'
import { generateProjectSlug } from 'lib/ultrabase-tenant'

// Create a Supabase client for server-side operations
function createServerSupabaseClient(req: NextApiRequest, res: NextApiResponse) {
  const supabaseUrl = process.env.SUPABASE_URL || 'http://localhost:8000'
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY || process.env.SERVICE_ROLE_KEY || ''
  
  return createClient(supabaseUrl, supabaseServiceKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  })
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const supabase = createServerSupabaseClient(req, res)

  try {
    // Check authentication
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser()

    if (authError || !user) {
      return res.status(401).json({ error: 'Unauthorized' })
    }

    switch (req.method) {
      case 'GET':
        return handleGetProjects(req, res, supabase, user.id)
      case 'POST':
        return handleCreateProject(req, res, supabase, user.id)
      default:
        res.setHeader('Allow', ['GET', 'POST'])
        return res.status(405).json({ error: 'Method not allowed' })
    }
  } catch (error) {
    console.error('Projects API error:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

async function handleGetProjects(
  req: NextApiRequest,
  res: NextApiResponse,
  supabase: any,
  userId: string
) {
  try {
    const { data: projects, error } = await supabase
      .from('ultrabase.projects')
      .select(`
        *,
        ultrabase.project_members!inner(
          role
        ),
        ultrabase.organizations!inner(
          name
        )
      `)
      .eq('ultrabase.project_members.user_id', userId)
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Error fetching projects:', error)
      return res.status(500).json({ error: 'Failed to fetch projects' })
    }

    const formattedProjects = projects.map((project: any) => ({
      id: project.id,
      name: project.name,
      slug: project.slug,
      description: project.description,
      organizationId: project.organization_id,
      organizationName: project.ultrabase.organizations.name,
      role: project.ultrabase.project_members[0]?.role || 'viewer',
      status: project.status,
      createdAt: project.created_at,
      updatedAt: project.updated_at,
      metadata: project.metadata,
      databaseConfig: project.database_config,
      apiConfig: project.api_config,
    }))

    return res.status(200).json(formattedProjects)
  } catch (error) {
    console.error('Error in handleGetProjects:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

async function handleCreateProject(
  req: NextApiRequest,
  res: NextApiResponse,
  supabase: any,
  userId: string
) {
  try {
    const { name, description, organizationId } = req.body

    if (!name || !organizationId) {
      return res.status(400).json({ error: 'Name and organization ID are required' })
    }

    // Check if user has permission to create projects in this organization
    const { data: membership, error: membershipError } = await supabase
      .from('ultrabase.organization_members')
      .select('role')
      .eq('organization_id', organizationId)
      .eq('user_id', userId)
      .single()

    if (membershipError || !membership) {
      return res.status(403).json({ error: 'Access denied to this organization' })
    }

    // Generate unique slug
    let slug = generateProjectSlug(name)
    let counter = 1
    let uniqueSlug = slug

    while (true) {
      const { data: existingProject } = await supabase
        .from('ultrabase.projects')
        .select('id')
        .eq('organization_id', organizationId)
        .eq('slug', uniqueSlug)
        .single()

      if (!existingProject) break
      
      uniqueSlug = `${slug}-${counter}`
      counter++
    }

    // Create project
    const { data: project, error: projectError } = await supabase
      .from('ultrabase.projects')
      .insert({
        name,
        slug: uniqueSlug,
        description,
        organization_id: organizationId,
      })
      .select()
      .single()

    if (projectError) {
      console.error('Error creating project:', projectError)
      return res.status(500).json({ error: 'Failed to create project' })
    }

    // Add user as owner of the project
    const { error: memberError } = await supabase
      .from('ultrabase.project_members')
      .insert({
        project_id: project.id,
        user_id: userId,
        role: 'owner',
      })

    if (memberError) {
      console.error('Error adding project member:', memberError)
      return res.status(500).json({ error: 'Failed to add project member' })
    }

    // Create project-specific schema
    const projectSchemaName = `project_${project.id.replace(/-/g, '_')}`
    
    const { error: schemaError } = await supabase.rpc('create_project_schema', {
      schema_name: projectSchemaName
    })

    if (schemaError) {
      console.error('Error creating project schema:', schemaError)
      // Don't fail the request, schema creation can be handled separately
    }

    const formattedProject = {
      id: project.id,
      name: project.name,
      slug: project.slug,
      description: project.description,
      organizationId: project.organization_id,
      organizationName: '', // Will be populated by frontend
      role: 'owner',
      status: project.status,
      createdAt: project.created_at,
      updatedAt: project.updated_at,
      metadata: project.metadata,
      databaseConfig: project.database_config,
      apiConfig: project.api_config,
    }

    return res.status(201).json(formattedProject)
  } catch (error) {
    console.error('Error in handleCreateProject:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

import { NextApiRequest, NextApiResponse } from 'next'
import { createServerSupabaseClient } from '@supabase/auth-helpers-nextjs'
import { TenantContextManager } from 'lib/ultrabase-tenant'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const supabase = createServerSupabaseClient({ req, res })

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
        return handleGetOrganizations(req, res, supabase, user.id)
      case 'POST':
        return handleCreateOrganization(req, res, supabase, user.id)
      default:
        res.setHeader('Allow', ['GET', 'POST'])
        return res.status(405).json({ error: 'Method not allowed' })
    }
  } catch (error) {
    console.error('Organizations API error:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

async function handleGetOrganizations(
  req: NextApiRequest,
  res: NextApiResponse,
  supabase: any,
  userId: string
) {
  try {
    const { data: organizations, error } = await supabase
      .from('ultrabase.organizations')
      .select(`
        *,
        ultrabase.organization_members!inner(
          role
        )
      `)
      .eq('ultrabase.organization_members.user_id', userId)
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Error fetching organizations:', error)
      return res.status(500).json({ error: 'Failed to fetch organizations' })
    }

    const formattedOrganizations = organizations.map((org: any) => ({
      id: org.id,
      name: org.name,
      slug: org.slug,
      billingEmail: org.billing_email,
      createdAt: org.created_at,
      updatedAt: org.updated_at,
      metadata: org.metadata,
      isPersonal: org.is_personal,
      status: org.status,
      role: org.ultrabase.organization_members[0]?.role || 'member',
    }))

    return res.status(200).json(formattedOrganizations)
  } catch (error) {
    console.error('Error in handleGetOrganizations:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

async function handleCreateOrganization(
  req: NextApiRequest,
  res: NextApiResponse,
  supabase: any,
  userId: string
) {
  try {
    const { name, slug, billingEmail } = req.body

    if (!name || !slug) {
      return res.status(400).json({ error: 'Name and slug are required' })
    }

    // Check if slug is already taken
    const { data: existingOrg } = await supabase
      .from('ultrabase.organizations')
      .select('id')
      .eq('slug', slug)
      .single()

    if (existingOrg) {
      return res.status(409).json({ error: 'Organization slug already exists' })
    }

    // Create organization
    const { data: organization, error: orgError } = await supabase
      .from('ultrabase.organizations')
      .insert({
        name,
        slug,
        billing_email: billingEmail,
      })
      .select()
      .single()

    if (orgError) {
      console.error('Error creating organization:', orgError)
      return res.status(500).json({ error: 'Failed to create organization' })
    }

    // Add user as owner
    const { error: memberError } = await supabase
      .from('ultrabase.organization_members')
      .insert({
        organization_id: organization.id,
        user_id: userId,
        role: 'owner',
      })

    if (memberError) {
      console.error('Error adding organization member:', memberError)
      return res.status(500).json({ error: 'Failed to add organization member' })
    }

    const formattedOrganization = {
      id: organization.id,
      name: organization.name,
      slug: organization.slug,
      billingEmail: organization.billing_email,
      createdAt: organization.created_at,
      updatedAt: organization.updated_at,
      metadata: organization.metadata,
      isPersonal: organization.is_personal,
      status: organization.status,
      role: 'owner',
    }

    return res.status(201).json(formattedOrganization)
  } catch (error) {
    console.error('Error in handleCreateOrganization:', error)
    return res.status(500).json({ error: 'Internal server error' })
  }
}

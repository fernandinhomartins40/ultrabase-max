import { createClient } from '@supabase/supabase-js'
import { Database } from 'types'

// Tenant context interface
export interface TenantContext {
  projectId: string
  organizationId: string
  userId: string
  role: string
}

// Multi-tenant client configuration
export interface MultiTenantConfig {
  projectId: string
  organizationId: string
  apiUrl: string
  anonKey: string
  serviceKey?: string
}

// Create a multi-tenant Supabase client
export function createMultiTenantClient(config: MultiTenantConfig) {
  const client = createClient<Database>(config.apiUrl, config.anonKey, {
    auth: {
      persistSession: true,
      autoRefreshToken: true,
    },
    global: {
      headers: {
        'X-Project-ID': config.projectId,
        'X-Organization-ID': config.organizationId,
      },
    },
  })

  return client
}

// Tenant context manager
export class TenantContextManager {
  private static instance: TenantContextManager
  private currentContext: TenantContext | null = null

  static getInstance(): TenantContextManager {
    if (!TenantContextManager.instance) {
      TenantContextManager.instance = new TenantContextManager()
    }
    return TenantContextManager.instance
  }

  setContext(context: TenantContext) {
    this.currentContext = context
  }

  getContext(): TenantContext | null {
    return this.currentContext
  }

  clearContext() {
    this.currentContext = null
  }

  isValidContext(): boolean {
    return this.currentContext !== null && 
           this.currentContext.projectId !== '' && 
           this.currentContext.organizationId !== ''
  }
}

// Project selector utility
export interface ProjectInfo {
  id: string
  name: string
  slug: string
  organizationId: string
  organizationName: string
  role: string
  status: 'active' | 'inactive' | 'suspended'
}

// Tenant-aware API routes
export const ULTRABASE_ROUTES = {
  organizations: '/api/ultrabase/organizations',
  projects: '/api/ultrabase/projects',
  projectMembers: '/api/ultrabase/projects/[id]/members',
  projectInvitations: '/api/ultrabase/projects/[id]/invitations',
  tenantContext: '/api/ultrabase/tenant/context',
}

// Error types for multi-tenant operations
export class TenantError extends Error {
  constructor(
    message: string,
    public code: string,
    public statusCode: number = 400
  ) {
    super(message)
    this.name = 'TenantError'
  }
}

export class ProjectNotFoundError extends TenantError {
  constructor(projectId: string) {
    super(`Project ${projectId} not found`, 'PROJECT_NOT_FOUND', 404)
  }
}

export class OrganizationNotFoundError extends TenantError {
  constructor(organizationId: string) {
    super(`Organization ${organizationId} not found`, 'ORGANIZATION_NOT_FOUND', 404)
  }
}

export class InsufficientPermissionsError extends TenantError {
  constructor(requiredRole: string) {
    super(`Insufficient permissions. Required role: ${requiredRole}`, 'INSUFFICIENT_PERMISSIONS', 403)
  }
}

// Utility functions for tenant management
export function validateTenantContext(context: TenantContext): boolean {
  return !!(context.projectId && context.organizationId && context.userId)
}

export function generateProjectSlug(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .substring(0, 50)
}

export function generateOrganizationSlug(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .substring(0, 50)
}

// Database schema names
export function getProjectSchemaName(projectId: string): string {
  return `project_${projectId.replace(/-/g, '_')}`
}

export function getOrganizationSchemaName(organizationId: string): string {
  return `org_${organizationId.replace(/-/g, '_')}`
}

// Connection string utilities
export function buildConnectionString(
  host: string,
  port: number,
  database: string,
  username: string,
  password: string
): string {
  return `postgresql://${username}:${password}@${host}:${port}/${database}`
}

// Role hierarchy
export const ROLE_HIERARCHY = {
  owner: 4,
  admin: 3,
  developer: 2,
  viewer: 1,
  member: 1,
} as const

export function hasRequiredRole(
  userRole: keyof typeof ROLE_HIERARCHY,
  requiredRole: keyof typeof ROLE_HIERARCHY
): boolean {
  return ROLE_HIERARCHY[userRole] >= ROLE_HIERARCHY[requiredRole]
}

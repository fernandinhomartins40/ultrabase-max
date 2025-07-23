-- Ultrabase Multi-tenant Schema
-- This migration adds the necessary tables for multi-tenant support

-- Create schema for multi-tenant tables
CREATE SCHEMA IF NOT EXISTS ultrabase;

-- Organizations table
CREATE TABLE IF NOT EXISTS ultrabase.organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    billing_email TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}',
    is_personal BOOLEAN DEFAULT FALSE,
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'suspended', 'deleted'))
);

-- Projects table
CREATE TABLE IF NOT EXISTS ultrabase.projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES ultrabase.organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}',
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended', 'deleted')),
    database_config JSONB DEFAULT '{}',
    api_config JSONB DEFAULT '{}',
    UNIQUE(organization_id, slug)
);

-- Project members table
CREATE TABLE IF NOT EXISTS ultrabase.project_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES ultrabase.projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('owner', 'admin', 'developer', 'viewer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    invited_by UUID,
    UNIQUE(project_id, user_id)
);

-- Project invitations table
CREATE TABLE IF NOT EXISTS ultrabase.project_invitations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES ultrabase.projects(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'developer', 'viewer')),
    invited_by UUID NOT NULL,
    token TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    accepted_at TIMESTAMP WITH TIME ZONE,
    UNIQUE(project_id, email)
);

-- Organization members table
CREATE TABLE IF NOT EXISTS ultrabase.organization_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES ultrabase.organizations(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('owner', 'admin', 'member')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(organization_id, user_id)
);

-- Project configurations table
CREATE TABLE IF NOT EXISTS ultrabase.project_configs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES ultrabase.projects(id) ON DELETE CASCADE,
    config_key TEXT NOT NULL,
    config_value JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(project_id, config_key)
);

-- Project databases table (for connection management)
CREATE TABLE IF NOT EXISTS ultrabase.project_databases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES ultrabase.projects(id) ON DELETE CASCADE,
    database_name TEXT NOT NULL,
    connection_string TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(project_id, database_name)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_organizations_slug ON ultrabase.organizations(slug);
CREATE INDEX IF NOT EXISTS idx_projects_organization_id ON ultrabase.projects(organization_id);
CREATE INDEX IF NOT EXISTS idx_projects_slug ON ultrabase.projects(slug);
CREATE INDEX IF NOT EXISTS idx_project_members_project_id ON ultrabase.project_members(project_id);
CREATE INDEX IF NOT EXISTS idx_project_members_user_id ON ultrabase.project_members(user_id);
CREATE INDEX IF NOT EXISTS idx_project_invitations_project_id ON ultrabase.project_invitations(project_id);
CREATE INDEX IF NOT EXISTS idx_project_invitations_email ON ultrabase.project_invitations(email);
CREATE INDEX IF NOT EXISTS idx_project_invitations_token ON ultrabase.project_invitations(token);
CREATE INDEX IF NOT EXISTS idx_organization_members_organization_id ON ultrabase.organization_members(organization_id);
CREATE INDEX IF NOT EXISTS idx_organization_members_user_id ON ultrabase.organization_members(user_id);

-- Create updated_at triggers
CREATE OR REPLACE FUNCTION ultrabase.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE ON ultrabase.organizations
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON ultrabase.projects
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_project_members_updated_at BEFORE UPDATE ON ultrabase.project_members
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_project_invitations_updated_at BEFORE UPDATE ON ultrabase.project_invitations
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_organization_members_updated_at BEFORE UPDATE ON ultrabase.organization_members
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_project_configs_updated_at BEFORE UPDATE ON ultrabase.project_configs
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

CREATE TRIGGER update_project_databases_updated_at BEFORE UPDATE ON ultrabase.project_databases
    FOR EACH ROW EXECUTE FUNCTION ultrabase.update_updated_at_column();

-- Enable Row Level Security
ALTER TABLE ultrabase.organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.project_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.project_invitations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.organization_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.project_configs ENABLE ROW LEVEL SECURITY;
ALTER TABLE ultrabase.project_databases ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Organizations policies
CREATE POLICY "Users can view organizations they are members of" ON ultrabase.organizations
    FOR SELECT USING (
        id IN (
            SELECT organization_id 
            FROM ultrabase.organization_members 
            WHERE user_id = auth.uid()
        )
    );

-- Projects policies
CREATE POLICY "Users can view projects they have access to" ON ultrabase.projects
    FOR SELECT USING (
        id IN (
            SELECT project_id 
            FROM ultrabase.project_members 
            WHERE user_id = auth.uid()
        )
    );

-- Project members policies
CREATE POLICY "Users can view project members for projects they have access to" ON ultrabase.project_members
    FOR SELECT USING (
        project_id IN (
            SELECT project_id 
            FROM ultrabase.project_members 
            WHERE user_id = auth.uid()
        )
    );

-- Project invitations policies
CREATE POLICY "Users can view invitations for projects they have access to" ON ultrabase.project_invitations
    FOR SELECT USING (
        project_id IN (
            SELECT project_id 
            FROM ultrabase.project_members 
            WHERE user_id = auth.uid()
        )
    );

-- Organization members policies
CREATE POLICY "Users can view organization members for organizations they are part of" ON ultrabase.organization_members
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id 
            FROM ultrabase.organization_members 
            WHERE user_id = auth.uid()
        )
    );

-- Insert seed data
INSERT INTO ultrabase.organizations (name, slug, billing_email, is_personal) VALUES
    ('Personal', 'personal', 'user@example.com', true);

-- Create default project
INSERT INTO ultrabase.projects (organization_id, name, slug, description) VALUES
    ((SELECT id FROM ultrabase.organizations WHERE slug = 'personal'), 'Default Project', 'default', 'Your default Ultrabase project');

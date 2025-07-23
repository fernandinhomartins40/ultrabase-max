-- Ultrabase Seed Data
-- This file contains sample data for testing the multi-tenant functionality

-- Insert sample organizations
INSERT INTO ultrabase.organizations (id, name, slug, billing_email, is_personal, status) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'Acme Corporation', 'acme-corp', 'billing@acme.com', false, 'active'),
    ('550e8400-e29b-41d4-a716-446655440002', 'Tech Startup Inc', 'tech-startup', 'admin@techstartup.com', false, 'active'),
    ('550e8400-e29b-41d4-a716-446655440003', 'Personal Workspace', 'personal-workspace', 'user@example.com', true, 'active');

-- Insert sample projects
INSERT INTO ultrabase.projects (id, organization_id, name, slug, description, status, database_config, api_config) VALUES
    -- Acme Corporation projects
    ('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Main Application', 'main-app', 'Primary application for Acme Corp', 'active', '{"max_connections": 100}', '{"rate_limit": 1000}'),
    ('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Analytics Dashboard', 'analytics', 'Business intelligence and analytics', 'active', '{"max_connections": 50}', '{"rate_limit": 500}'),
    
    -- Tech Startup projects
    ('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Customer Portal', 'customer-portal', 'Customer-facing application', 'active', '{"max_connections": 75}', '{"rate_limit": 750}'),
    ('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Admin Panel', 'admin-panel', 'Internal administration panel', 'active', '{"max_connections": 25}', '{"rate_limit": 250}'),
    
    -- Personal projects
    ('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Personal Blog', 'personal-blog', 'My personal blog and portfolio', 'active', '{"max_connections": 10}', '{"rate_limit": 100}');

-- Insert sample users (these would normally be created through auth.users)
-- For demo purposes, we'll use UUIDs that match typical auth.users structure
INSERT INTO auth.users (id, instance_id, aud, role, email, encrypted_password, email_confirmed_at, created_at, updated_at) VALUES
    ('770e8400-e29b-41d4-a716-446655440001', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'admin@acme.com', '$2a$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', NOW(), NOW(), NOW()),
    ('770e8400-e29b-41d4-a716-446655440002', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'developer@acme.com', '$2a$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', NOW(), NOW(), NOW()),
    ('770e8400-e29b-41d4-a716-446655440003', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'ceo@techstartup.com', '$2a$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', NOW(), NOW(), NOW()),
    ('770e8400-e29b-41d4-a716-446655440004', '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', 'user@example.com', '$2a$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', NOW(), NOW(), NOW());

-- Insert organization memberships
INSERT INTO ultrabase.organization_members (organization_id, user_id, role) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 'owner'),
    ('550e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440002', 'admin'),
    ('550e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440003', 'owner'),
    ('550e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440004', 'owner');

-- Insert project memberships
INSERT INTO ultrabase.project_members (project_id, user_id, role, invited_by) VALUES
    -- Acme projects
    ('660e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 'owner', '770e8400-e29b-41d4-a716-446655440001'),
    ('660e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440002', 'developer', '770e8400-e29b-41d4-a716-446655440001'),
    ('660e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440001', 'owner', '770e8400-e29b-41d4-a716-446655440001'),
    ('660e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 'viewer', '770e8400-e29b-41d4-a716-446655440001'),
    
    -- Tech Startup projects
    ('660e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 'owner', '770e8400-e29b-41d4-a716-446655440003'),
    ('660e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440003', 'owner', '770e8400-e29b-41d4-a716-446655440003'),
    
    -- Personal projects
    ('660e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440004', 'owner', '770e8400-e29b-41d4-a716-446655440004');

-- Insert sample project configurations
INSERT INTO ultrabase.project_configs (project_id, config_key, config_value) VALUES
    ('660e8400-e29b-41d4-a716-446655440001', 'api_rate_limit', '{"requests_per_minute": 1000, "burst_limit": 100}'),
    ('660e8400-e29b-41d4-a716-446655440001', 'database_config', '{"max_connections": 100, "connection_timeout": 30}'),
    ('660e8400-e29b-41d4-a716-446655440001', 'storage_config', '{"max_file_size": 52428800, "allowed_types": ["image/*", "application/pdf"]}'),
    
    ('660e8400-e29b-41d4-a716-446655440002', 'api_rate_limit', '{"requests_per_minute": 500, "burst_limit": 50}'),
    ('660e8400-e29b-41d4-a716-446655440002', 'database_config', '{"max_connections": 50, "connection_timeout": 30}'),
    
    ('660e8400-e29b-41d4-a716-446655440003', 'api_rate_limit', '{"requests_per_minute": 750, "burst_limit": 75}'),
    ('660e8400-e29b-41d4-a716-446655440003', 'database_config', '{"max_connections": 75, "connection_timeout": 30}');

-- Insert sample project invitations
INSERT INTO ultrabase.project_invitations (project_id, email, role, invited_by, token, expires_at) VALUES
    ('660e8400-e29b-41d4-a716-446655440001', 'newuser@acme.com', 'developer', '770e8400-e29b-41d4-a716-446655440001', 'invite-token-001', NOW() + INTERVAL '7 days'),
    ('660e8400-e29b-41d4-a716-446655440003', 'consultant@example.com', 'viewer', '770e8400-e29b-41d4-a716-446655440003', 'invite-token-002', NOW() + INTERVAL '3 days');

-- Create sample project schemas
SELECT create_project_schema('project_660e8400_e29b_41d4_a716_446655440001');
SELECT create_project_schema('project_660e8400_e29b_41d4_a716_446655440002');
SELECT create_project_schema('project_660e8400_e29b_41d4_a716_446655440003');
SELECT create_project_schema('project_660e8400_e29b_41d4_a716_446655440004');
SELECT create_project_schema('project_660e8400_e29b_41d4_a716_446655440005');

-- Insert sample data into project schemas
-- Main Application project
CREATE TABLE IF NOT EXISTS project_660e8400_e29b_41d4_a716_446655440001.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT UNIQUE NOT NULL,
    full_name TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS project_660e8400_e29b_41d4_a716_446655440001.posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    content TEXT,
    author_id UUID REFERENCES project_660e8400_e29b_41d4_a716_446655440001.users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO project_660e8400_e29b_41d4_a716_446655440001.users (email, full_name) VALUES
    ('admin@acme.com', 'Acme Admin'),
    ('user1@acme.com', 'John Doe'),
    ('user2@acme.com', 'Jane Smith');

INSERT INTO project_660e8400_e29b_41d4_a716_446655440001.posts (title, content, author_id) VALUES
    ('Welcome to Acme', 'This is our main application', (SELECT id FROM project_660e8400_e29b_41d4_a716_446655440001.users WHERE email = 'admin@acme.com')),
    ('Getting Started', 'How to use our platform', (SELECT id FROM project_660e8400_e29b_41d4_a716_446655440001.users WHERE email = 'user1@acme.com'));

-- Analytics Dashboard project
CREATE TABLE IF NOT EXISTS project_660e8400_e29b_41d4_a716_446655440002.analytics_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name TEXT NOT NULL,
    properties JSONB,
    user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO project_660e8400_e29b_41d4_a716_446655440002.analytics_events (event_name, properties) VALUES
    ('page_view', '{"page": "/dashboard", "user_agent": "Chrome"}'),
    ('button_click', '{"button": "export", "location": "reports"}');

-- Enable RLS on project tables
ALTER TABLE project_660e8400_e29b_41d4_a716_446655440001.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE project_660e8400_e29b_41d4_a716_446655440001.posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE project_660e8400_e29b_41d4_a716_446655440002.analytics_events ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for project tables
CREATE POLICY "Users can view all users" ON project_660e8400_e29b_41d4_a716_446655440001.users FOR SELECT USING (true);
CREATE POLICY "Users can create posts" ON project_660e8400_e29b_41d4_a716_446655440001.posts FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can view all posts" ON project_660e8400_e29b_41d4_a716_446655440001.posts FOR SELECT USING (true);

CREATE POLICY "Users can view analytics" ON project_660e8400_e29b_41d4_a716_446655440002.analytics_events FOR SELECT USING (true);
CREATE POLICY "Users can create analytics events" ON project_660e8400_e29b_41d4_a716_446655440002.analytics_events FOR INSERT WITH CHECK (true);

-- Grant permissions
GRANT USAGE ON SCHEMA project_660e8400_e29b_41d4_a716_446655440001 TO authenticated;
GRANT USAGE ON SCHEMA project_660e8400_e29b_41d4_a716_446655440002 TO authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA project_660e8400_e29b_41d4_a716_446655440001 TO authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA project_660e8400_e29b_41d4_a716_446655440002 TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA project_660e8400_e29b_41d4_a716_446655440001 TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA project_660e8400_e29b_41d4_a716_446655440002 TO authenticated;

-- Create indexes for better performance
CREATE INDEX idx_users_email ON project_660e8400_e29b_41d4_a716_446655440001.users(email);
CREATE INDEX idx_posts_author ON project_660e8400_e29b_41d4_a716_446655440001.posts(author_id);
CREATE INDEX idx_posts_created_at ON project_660e8400_e29b_41d4_a716_446655440001.posts(created_at DESC);
CREATE INDEX idx_events_name ON project_660e8400_e29b_41d4_a716_446655440002.analytics_events(event_name);
CREATE INDEX idx_events_created_at ON project_660e8400_e29b_41d4_a716_446655440002.analytics_events(created_at DESC);

-- Create views for project statistics
CREATE OR REPLACE VIEW ultrabase.project_stats AS
SELECT 
    p.id as project_id,
    p.name as project_name,
    p.slug as project_slug,
    o.name as organization_name,
    COUNT(DISTINCT pm.user_id) as member_count,
    p.created_at,
    p.updated_at
FROM ultrabase.projects p
JOIN ultrabase.organizations o ON p.organization_id = o.id
LEFT JOIN ultrabase.project_members pm ON p.id = pm.project_id
GROUP BY p.id, p.name, p.slug, o.name, p.created_at, p.updated_at;

-- Create function to get project usage stats
CREATE OR REPLACE FUNCTION ultrabase.get_project_usage_stats(project_uuid UUID)
RETURNS TABLE (
    total_tables INTEGER,
    total_rows BIGINT,
    total_size BIGINT,
    last_activity TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(*)::INTEGER,
        SUM(reltuples::BIGINT),
        SUM(pg_total_relation_size(c.oid))::BIGINT,
        MAX(pg_stat_get_last_vacuum_time(c.oid))
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'project_' || REPLACE(project_uuid::TEXT, '-', '_')
    AND c.relkind = 'r';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant permissions on ultrabase schema
GRANT USAGE ON SCHEMA ultrabase TO authenticated;
GRANT SELECT ON ALL TABLES IN SCHEMA ultrabase TO authenticated;
GRANT INSERT, UPDATE, DELETE ON ultrabase.project_configs TO authenticated;
GRANT INSERT, UPDATE, DELETE ON ultrabase.project_databases TO authenticated;

-- Create indexes for performance
CREATE INDEX idx_organizations_status ON ultrabase.organizations(status);
CREATE INDEX idx_projects_organization_status ON ultrabase.projects(organization_id, status);
CREATE INDEX idx_project_members_project_role ON ultrabase.project_members(project_id, role);
CREATE INDEX idx_organization_members_org_role ON ultrabase.organization_members(organization_id, role);

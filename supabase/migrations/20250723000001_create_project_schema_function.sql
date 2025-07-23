-- Function to create a new project schema
CREATE OR REPLACE FUNCTION create_project_schema(schema_name TEXT)
RETURNS VOID AS $$
DECLARE
    full_schema_name TEXT;
BEGIN
    -- Ensure schema name starts with 'project_'
    IF NOT schema_name LIKE 'project_%' THEN
        RAISE EXCEPTION 'Schema name must start with project_';
    END IF;

    full_schema_name := quote_ident(schema_name);
    
    -- Create the schema
    EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I', schema_name);
    
    -- Grant permissions
    EXECUTE format('GRANT USAGE ON SCHEMA %I TO authenticated', schema_name);
    EXECUTE format('GRANT CREATE ON SCHEMA %I TO authenticated', schema_name);
    EXECUTE format('GRANT USAGE ON SCHEMA %I TO service_role', schema_name);
    EXECUTE format('GRANT CREATE ON SCHEMA %I TO service_role', schema_name);
    
    -- Set default privileges
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT USAGE, SELECT ON SEQUENCES TO authenticated', schema_name);
    EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT EXECUTE ON FUNCTIONS TO authenticated', schema_name);
    
    RAISE NOTICE 'Schema % created successfully', schema_name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to drop a project schema
CREATE OR REPLACE FUNCTION drop_project_schema(schema_name TEXT)
RETURNS VOID AS $$
BEGIN
    -- Ensure schema name starts with 'project_'
    IF NOT schema_name LIKE 'project_%' THEN
        RAISE EXCEPTION 'Schema name must start with project_';
    END IF;

    -- Drop the schema and all its contents
    EXECUTE format('DROP SCHEMA IF EXISTS %I CASCADE', schema_name);
    
    RAISE NOTICE 'Schema % dropped successfully', schema_name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to clone schema structure
CREATE OR REPLACE FUNCTION clone_schema_structure(
    source_schema TEXT,
    target_schema TEXT
) RETURNS VOID AS $$
DECLARE
    obj RECORD;
BEGIN
    -- Ensure target schema exists
    EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I', target_schema);
    
    -- Clone tables
    FOR obj IN
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = source_schema
        AND table_type = 'BASE TABLE'
    LOOP
        EXECUTE format(
            'CREATE TABLE %I.%I (LIKE %I.%I INCLUDING ALL)',
            target_schema, obj.table_name,
            source_schema, obj.table_name
        );
    END LOOP;
    
    -- Clone sequences
    FOR obj IN
        SELECT sequence_name 
        FROM information_schema.sequences 
        WHERE sequence_schema = source_schema
    LOOP
        EXECUTE format(
            'CREATE SEQUENCE %I.%I',
            target_schema, obj.sequence_name
        );
    END LOOP;
    
    -- Clone functions
    FOR obj IN
        SELECT routine_name, routine_type 
        FROM information_schema.routines 
        WHERE routine_schema = source_schema
    LOOP
        -- This is a simplified version - in practice you'd need to reconstruct the function
        RAISE NOTICE 'Skipping function % - manual recreation required', obj.routine_name;
    END LOOP;
    
    RAISE NOTICE 'Schema % cloned from %', target_schema, source_schema;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get project database info
CREATE OR REPLACE FUNCTION get_project_database_info(project_uuid UUID)
RETURNS TABLE (
    schema_name TEXT,
    table_count INTEGER,
    total_size BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        schemaname::TEXT,
        COUNT(*)::INTEGER,
        SUM(pg_total_relation_size(schemaname||'.'||tablename))::BIGINT
    FROM pg_tables
    WHERE schemaname = 'project_' || REPLACE(project_uuid::TEXT, '-', '_')
    GROUP BY schemaname;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to migrate data between schemas
CREATE OR REPLACE FUNCTION migrate_project_data(
    source_project_id UUID,
    target_project_id UUID
) RETURNS VOID AS $$
DECLARE
    source_schema TEXT;
    target_schema TEXT;
BEGIN
    source_schema := 'project_' || REPLACE(source_project_id::TEXT, '-', '_');
    target_schema := 'project_' || REPLACE(target_project_id::TEXT, '-', '_');
    
    -- This is a placeholder - actual migration would need to be more sophisticated
    RAISE NOTICE 'Migrating data from % to %', source_schema, target_schema;
    
    -- Example migration for a specific table
    -- EXECUTE format('INSERT INTO %I.my_table SELECT * FROM %I.my_table', target_schema, source_schema);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

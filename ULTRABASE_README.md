# Ultrabase - Multi-tenant Supabase Fork

Ultrabase is a multi-tenant fork of Supabase that allows users to manage multiple projects and organizations within a single platform, similar to supabase.com but running on your own infrastructure.

## 🚀 Features

### ✅ Multi-tenancy Support
- **Organizations**: Create and manage multiple organizations
- **Projects**: Each organization can have multiple isolated projects
- **User Management**: Invite team members with role-based access control
- **Data Isolation**: Complete isolation between projects using PostgreSQL schemas

### ✅ Project Management
- **Project Creation**: Create new projects with automatic schema provisioning
- **Project Switching**: Seamlessly switch between projects in the dashboard
- **Team Collaboration**: Invite members to projects with different roles
- **Organization Management**: Manage billing and team members per organization

### ✅ Security & Isolation
- **Row Level Security (RLS)**: Database-level security policies
- **Schema Isolation**: Each project gets its own PostgreSQL schema
- **Role-based Access**: Fine-grained permissions (owner, admin, developer, viewer)
- **API Context**: All APIs are contextualized by project and organization

### ✅ Developer Experience
- **CLI Tool**: Command-line interface for project management
- **Dashboard**: Web-based management interface
- **API Endpoints**: RESTful APIs for all operations
- **TypeScript Support**: Full type safety throughout

## 🏗️ Architecture

### Database Schema
- **ultrabase.organizations**: Organization management
- **ultrabase.projects**: Project configuration and metadata
- **ultrabase.project_members**: Project membership and roles
- **ultrabase.project_invitations**: Team invitation system
- **ultrabase.organization_members**: Organization membership
- **ultrabase.project_configs**: Project-specific configurations
- **ultrabase.project_databases**: Database connection management

### Isolation Strategy
- **Schema-based isolation**: Each project gets its own PostgreSQL schema
- **Connection pooling**: Optimized connection management per project
- **Context propagation**: Project and organization context in all requests

## 🚀 Quick Start

### 1. Setup Environment
```bash
# Clone the repository
git clone https://github.com/fernandinhomartins40/ultrabase-max.git ultrabase
cd ultrabase

# Install dependencies
pnpm install

# Copy environment files
cp docker/.env.example docker/.env
```

### 2. Start Services
```bash
# Start all services
cd docker
docker compose up

# Or start individual services
pnpm dev:studio
```

### 3. Apply Migrations
```bash
# Apply multi-tenant migrations
pnpm supabase db reset --local
```

### 4. Access Dashboard
- **Studio**: http://localhost:8082
- **API**: http://localhost:8000

## 📋 Usage

### Web Dashboard
1. **Register/Login**: Create your account
2. **Create Organization**: Set up your first organization
3. **Create Project**: Add projects to your organization
4. **Invite Team**: Add members to projects with appropriate roles

### CLI Usage
```bash
# Install CLI globally
npm install -g @ultrabase/cli

# Login
ultrabase login

# Create organization
ultrabase org create

# Create project
ultrabase project create

# List projects
ultrabase project list

# Switch project
ultrabase project use my-project
```

### API Usage
```typescript
// Create multi-tenant client
import { createMultiTenantClient } from '@ultrabase/client'

const client = createMultiTenantClient({
  projectId: 'your-project-id',
  organizationId: 'your-org-id',
  apiUrl: 'http://localhost:8000',
  anonKey: 'your-anon-key'
})
```

## 🔧 Development

### Project Structure
```
ultrabase/
├── apps/
│   ├── studio/          # Dashboard application
│   └── docs/           # Documentation
├── packages/
│   ├── cli/            # Command-line interface
│   └── ui/             # Shared UI components
├── supabase/
│   ├── migrations/     # Database migrations
│   └── seed.sql        # Seed data
└── docker/             # Docker configuration
```

### Development Commands
```bash
# Start development environment
pnpm dev

# Start specific services
pnpm dev:studio
pnpm dev:docs

# Run tests
pnpm test:studio

# Build
pnpm build
```

### Database Development
```bash
# Reset database
pnpm supabase db reset --local

# Generate types
pnpm supabase gen types typescript --local > types/database.ts

# Apply migrations
pnpm supabase migration up
```

## 🔐 Security Features

### Authentication & Authorization
- **JWT-based authentication**: Secure token-based auth
- **Role-based access control**: Granular permissions
- **Organization isolation**: Users can only access their organizations
- **Project isolation**: Projects are completely isolated

### Data Protection
- **Schema isolation**: Each project in separate schema
- **RLS policies**: Row-level security at database level
- **API validation**: Request validation and sanitization
- **Audit logging**: Track all user actions

## 📊 Monitoring & Analytics

### Built-in Monitoring
- **Project metrics**: Usage per project
- **User activity**: Track user actions
- **Performance metrics**: API response times
- **Error tracking**: Centralized error logging

### Custom Analytics
- **Usage tracking**: Track feature usage
- **Billing integration**: Ready for billing systems
- **Custom events**: Track custom business metrics

## 🚀 Deployment

### Self-hosted
```bash
# Production deployment
docker compose -f docker-compose.prod.yml up -d

# With custom domain
docker compose -f docker-compose.prod.yml -f docker-compose.custom.yml up -d
```

### Cloud Deployment
- **AWS**: ECS, RDS, S3
- **GCP**: Cloud Run, Cloud SQL, Cloud Storage
- **Azure**: Container Instances, PostgreSQL, Blob Storage

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

Apache 2.0 - See [LICENSE](LICENSE) for details

## 🆘 Support

- **Documentation**: [docs.ultrabase.dev](https://docs.ultrabase.dev)
- **Discord**: [discord.gg/ultrabase](https://discord.gg/ultrabase)
- **Issues**: [GitHub Issues](https://github.com/fernandinhomartins40/ultrabase-max/issues)

## 🔄 Migration from Supabase

### Database Migration
1. **Backup**: Create backup of existing Supabase instance
2. **Schema Migration**: Use provided migration scripts
3. **Data Migration**: Migrate data to new schema structure
4. **Testing**: Verify all functionality works

### Application Migration
1. **API Changes**: Update API endpoints to include project context
2. **Authentication**: Update auth flows for multi-tenant
3. **Database Connections**: Update connection strings per project

## 📈 Roadmap

### Phase 1: Core Multi-tenancy ✅
- [x] Organization management
- [x] Project creation and isolation
- [x] User roles and permissions
- [x] CLI tool

### Phase 2: Advanced Features 🚧
- [ ] Billing integration
- [ ] Advanced analytics
- [ ] Custom domains per project
- [ ] API rate limiting per project

### Phase 3: Enterprise Features 📋
- [ ] SSO integration
- [ ] Audit logs
- [ ] Advanced security features
- [ ] Multi-region deployment

---

**Ultrabase** - Making multi-tenant Supabase deployment simple and scalable.

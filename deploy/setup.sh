#!/bin/bash
set -e

# Script de setup para deploy da Ultrabase na VPS
# Uso: ./setup.sh <imagem_docker>

IMAGE_NAME=${1:-ghcr.io/fernandinhomartins40/ultrabase-max:latest}
echo "🚀 Iniciando deploy da Ultrabase com imagem: $IMAGE_NAME"
echo "📅 $(date)"

# Create logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Função para verificar se o comando foi executado com sucesso
check_command() {
    if [ $? -eq 0 ]; then
        log "✅ $1"
    else
        log "❌ $1"
        exit 1
    fi
}

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    log "❌ Docker não está instalado. Instalando..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    check_command "Docker instalado"
    rm get-docker.sh
fi

# Verificar se Docker Compose está disponível
if ! docker compose version &> /dev/null; then
    log "❌ Docker Compose não está disponível"
    exit 1
fi

# Criar diretório de trabalho
mkdir -p /opt/ultrabase
cd /opt/ultrabase

# Criar arquivo .env se não existir
if [ ! -f .env ]; then
    log "⚙️  Criando arquivo .env..."
    cat > .env << 'EOF'
# Configurações básicas do PostgreSQL
POSTGRES_PASSWORD=ultrabase_secure_password_2024
POSTGRES_DB=postgres
POSTGRES_PORT=5432
POSTGRES_HOST=db

# Configurações JWT
JWT_SECRET=your-super-secret-jwt-token-with-at-least-32-characters-long-for-production-use
JWT_EXPIRY=3600

# Chaves de API (geradas automaticamente - substitua por valores seguros em produção)
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InVsdHJhYmFzZSIsImlhdCI6MTcwMDAwMDAwMCwiZXhwIjoxODAwMDAwMDAwfQ.abc123xyz
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoidWx0cmFiYXNlIiwiaWF0IjoxNzAwMDAwMDAwLCJleHAiOjE4MDAwMDAwMDB9.xyz789abc

# Configurações do Kong
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443

# Configurações do Studio
STUDIO_DEFAULT_ORGANIZATION=Ultrabase Production
STUDIO_DEFAULT_PROJECT=Main Project
STUDIO_DEFAULT_ORGANIZATION=Ultrabase Production
SUPABASE_PUBLIC_URL=http://31.97.85.98

# Configurações de email (configure com seu SMTP)
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=false
SMTP_ADMIN_EMAIL=admin@ultrabase.com
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
SMTP_SENDER_NAME=Ultrabase

# Configurações de telefone (desabilitadas por padrão)
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false

# Configurações de segurança
DISABLE_SIGNUP=false
ADDITIONAL_REDIRECT_URLS=http://localhost:3000,http://31.97.85.98
SITE_URL=http://31.97.85.98
API_EXTERNAL_URL=http://31.97.85.98:8000

# Configurações do pooler
POOLER_PROXY_PORT_TRANSACTION=6543
POOLER_DEFAULT_POOL_SIZE=20
POOLER_MAX_CLIENT_CONN=100
POOLER_TENANT_ID=ultrabase-prod
POOLER_DB_POOL_SIZE=5

# Configurações de analytics
LOGFLARE_PUBLIC_ACCESS_TOKEN=your-logflare-public-token
LOGFLARE_PRIVATE_ACCESS_TOKEN=your-logflare-private-token

# Configurações de ambiente
NODE_ENV=production
NEXT_PUBLIC_ENVIRONMENT=production
NEXT_PUBLIC_IS_PLATFORM=false
NEXT_PUBLIC_SUPABASE_URL=http://31.97.85.98:8000
NEXT_PUBLIC_SUPABASE_ANON_KEY=${ANON_KEY}
EOF
    check_command "Arquivo .env criado"
fi

# Criar scripts de inicialização do banco
log "⚙️  Criando scripts de inicialização do banco..."
mkdir -p init-db

# Script para criar extensões e configurações básicas
cat > init-db/01-init.sql << 'EOF'
-- Ultrabase Database Initialization
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "btree_gin";
CREATE EXTENSION IF NOT EXISTS "btree_gist";

-- Create basic schemas
CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS storage;
CREATE SCHEMA IF NOT EXISTS realtime;
CREATE SCHEMA IF NOT EXISTS vault;

-- Create basic tables for multi-tenant support
CREATE TABLE IF NOT EXISTS public.organizations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID REFERENCES public.organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    database_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(organization_id, slug)
);

-- Insert default organization and project
INSERT INTO public.organizations (id, name, slug) 
VALUES ('00000000-0000-0000-0000-000000000000', 'Default Organization', 'default')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.projects (id, organization_id, name, slug, database_url)
VALUES ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000000', 'Default Project', 'default', 'postgresql://postgres:ultrabase_secure_password_2024@db:5432/postgres')
ON CONFLICT (organization_id, slug) DO NOTHING;

-- Basic RLS setup
ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

-- Create policies (basic setup - customize as needed)
CREATE POLICY "Enable read access for all users" ON public.organizations FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON public.projects FOR SELECT USING (true);

COMMIT;
EOF

# Criar docker-compose.yml
log "⚙️  Criando docker-compose.yml..."
cat > docker-compose.yml << EOF
version: '3.8'

services:
  ultrabase:
    image: $IMAGE_NAME
    container_name: ultrabase-app
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
      - HOSTNAME=0.0.0.0
      - NEXT_TELEMETRY_DISABLED=1
      - NEXT_PUBLIC_IS_PLATFORM=false
      - NEXT_PUBLIC_ENVIRONMENT=production
      - NEXT_PUBLIC_SUPABASE_URL=http://31.97.85.98:8000
      - NEXT_PUBLIC_SUPABASE_ANON_KEY=\${ANON_KEY}
      - SUPABASE_SERVICE_KEY=\${SERVICE_ROLE_KEY}
      - DATABASE_URL=postgresql://postgres:\${POSTGRES_PASSWORD}@db:5432/\${POSTGRES_DB}
    env_file:
      - .env
    volumes:
      - ./data:/app/data
      - ./logs:/app/logs
      - /etc/localtime:/etc/localtime:ro
    healthcheck:
      test: ["CMD", "/app/health-check.sh"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    depends_on:
      db:
        condition: service_healthy
    networks:
      - ultrabase-network

  db:
    image: supabase/postgres:15.8.1.060
    container_name: ultrabase-db
    restart: unless-stopped
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=\${POSTGRES_PASSWORD}
      - POSTGRES_DB=\${POSTGRES_DB}
      - JWT_SECRET=\${JWT_SECRET}
      - JWT_EXP=\${JWT_EXPIRY}
      - POSTGRES_HOST_AUTH_METHOD=trust
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init-db:/docker-entrypoint-initdb.d
      - /etc/localtime:/etc/localtime:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d postgres"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    networks:
      - ultrabase-network

  nginx:
    image: nginx:alpine
    container_name: ultrabase-nginx
    restart: unless-stopped
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - /etc/localtime:/etc/localtime:ro
    depends_on:
      ultrabase:
        condition: service_healthy
    networks:
      - ultrabase-network
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3

volumes:
  postgres_data:
    driver: local

networks:
  ultrabase-network:
    driver: bridge
EOF

# Criar nginx.conf
log "⚙️  Criando nginx.conf..."
cat > nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    upstream ultrabase {
        server ultrabase:3000;
    }

    # Basic settings
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    client_max_body_size 50M;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_comp_level 6;
    gzip_types
        text/plain
        text/css
        text/xml
        text/javascript
        application/javascript
        application/xml+rss
        application/json
        application/xml
        image/svg+xml;

    # Rate limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    limit_req_zone $binary_remote_addr zone=auth:10m rate=5r/s;

    server {
        listen 80;
        server_name _;
        
        # Security
        server_tokens off;
        
        # Rate limiting for API endpoints
        location /api/ {
            limit_req zone=api burst=20 nodelay;
            proxy_pass http://ultrabase;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }
        
        # Rate limiting for auth endpoints
        location /auth/ {
            limit_req zone=auth burst=10 nodelay;
            proxy_pass http://ultrabase;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }
        
        # Main application
        location / {
            proxy_pass http://ultrabase;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
            proxy_buffering off;
        }
        
        # Health check endpoint (no rate limiting)
        location /health {
            access_log off;
            proxy_pass http://ultrabase/health;
            proxy_set_header Host $host;
            proxy_connect_timeout 5s;
            proxy_send_timeout 5s;
            proxy_read_timeout 5s;
        }
        
        # Nginx health check
        location /nginx-health {
            access_log off;
            return 200 "healthy\n";
            add_header Content-Type text/plain;
        }
    }
}
EOF

# Criar diretórios necessários
mkdir -p data logs backups

# Criar script de atualização
log "⚙️  Criando scripts de gerenciamento..."
cat > update.sh << 'EOF'
#!/bin/bash
set -e

NEW_IMAGE=$1
if [ -z "$NEW_IMAGE" ]; then
    echo "❌ Uso: $0 <nova_imagem>"
    exit 1
fi

echo "🔄 Atualizando Ultrabase para: $NEW_IMAGE"

# Create backup
./backup.sh

# Update docker-compose.yml with new image
sed -i "s|image: .*|image: $NEW_IMAGE|" docker-compose.yml

# Pull new image
docker pull $NEW_IMAGE

# Restart services
docker compose down
docker compose up -d

# Wait for health check
echo "⏳ Aguardando serviços..."
sleep 30

# Verify deployment
if curl -f -s http://localhost/health >/dev/null 2>&1; then
    echo "✅ Atualização concluída com sucesso!"
else
    echo "❌ Falha na atualização. Verifique os logs."
    exit 1
fi

# Clean old images
docker image prune -f

echo "✅ Atualização concluída!"
EOF

chmod +x update.sh

# Criar script de backup
cat > backup.sh << 'EOF'
#!/bin/bash
set -e

BACKUP_DIR="/opt/ultrabase/backups"
DATE=$(date +%Y%m%d_%H%M%S)

echo "💾 Criando backup..."

mkdir -p $BACKUP_DIR

# Backup do banco de dados
if docker ps | grep -q ultrabase-db; then
    echo "📦 Backup do banco de dados..."
    docker exec ultrabase-db pg_dump -U postgres postgres > $BACKUP_DIR/db_backup_$DATE.sql
    check_command "Backup do banco criado"
else
    echo "⚠️  Container do banco não está rodando, pulando backup do BD"
fi

# Backup dos arquivos de configuração
echo "📦 Backup das configurações..."
tar -czf $BACKUP_DIR/config_backup_$DATE.tar.gz \
    docker-compose.yml nginx.conf .env init-db/ \
    --exclude=backups --exclude=logs 2>/dev/null || true

# Remover backups antigos (manter últimos 7 dias)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete 2>/dev/null || true
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete 2>/dev/null || true

echo "✅ Backup criado: $BACKUP_DIR/db_backup_$DATE.sql"
EOF

chmod +x backup.sh

# Criar script de logs
cat > logs.sh << 'EOF'
#!/bin/bash
case "$1" in
    app|ultrabase)
        docker logs -f ultrabase-app
        ;;
    db|database)
        docker logs -f ultrabase-db
        ;;
    nginx|web)
        docker logs -f ultrabase-nginx
        ;;
    all)
        docker compose logs -f
        ;;
    *)
        echo "Uso: $0 {app|db|nginx|all}"
        echo ""
        echo "  app/ultrabase - Logs da aplicação principal"
        echo "  db/database   - Logs do banco de dados"
        echo "  nginx/web     - Logs do servidor web"
        echo "  all           - Logs de todos os serviços"
        exit 1
        ;;
esac
EOF

chmod +x logs.sh

# Criar script de status
cat > status.sh << 'EOF'
#!/bin/bash
echo "📊 Status dos serviços Ultrabase:"
echo "================================"
docker compose ps
echo ""
echo "📈 Uso de recursos:"
echo "=================="
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"
echo ""
echo "🌐 Endpoints disponíveis:"
echo "========================"
echo "Aplicação:     http://31.97.85.98"
echo "Health Check:  http://31.97.85.98/health"
echo "Banco direto:  31.97.85.98:5432"
echo ""
echo "📋 Logs rápidos:"
echo "================"
echo "Para ver logs: ./logs.sh {app|db|nginx|all}"
EOF

chmod +x status.sh

# Parar containers antigos se existirem
log "🛑 Parando containers antigos..."
docker compose down --remove-orphans 2>/dev/null || true

# Limpar imagens antigas para economizar espaço
log "🧹 Limpando imagens antigas..."
docker image prune -f || true

# Atualizar imagem
log "📥 Baixando imagem: $IMAGE_NAME"
docker pull $IMAGE_NAME
check_command "Imagem baixada"

# Iniciar serviços com logs
log "🚀 Iniciando serviços..."
docker compose up -d
check_command "Serviços iniciados"

# Aguardar inicialização com timeout
log "⏳ Aguardando inicialização dos serviços..."
timeout=180
counter=0
while [ $counter -lt $timeout ]; do
    if curl -sf -m 5 http://localhost/health > /dev/null 2>&1; then
        log "✅ Serviços inicializados com sucesso!"
        break
    fi
    sleep 5
    counter=$((counter + 5))
    log "⏳ Aguardando... ($counter/$timeout segundos)"
done

if [ $counter -ge $timeout ]; then
    log "❌ Timeout na inicialização dos serviços"
    log "📊 Status dos containers:"
    docker compose ps
    log "📋 Logs do container principal:"
    docker compose logs --tail=20 ultrabase
    exit 1
fi

# Verificar saúde dos serviços
log "🔍 Verificando saúde dos serviços..."
docker compose ps

# Teste final de conectividade
if curl -f -s -m 10 http://localhost/health > /dev/null 2>&1; then
    log "✅ Deploy realizado com sucesso! Serviço está rodando!"
    log "🌐 Acesse: http://31.97.85.98"
else
    log "❌ Serviço não está respondendo corretamente"
    docker compose logs --tail=50
    exit 1
fi

# Configurar backup automático (opcional)
if ! crontab -l 2>/dev/null | grep -q "backup.sh"; then
    log "📅 Configurando backup automático diário às 3h..."
    (crontab -l 2>/dev/null; echo "0 3 * * * /opt/ultrabase/backup.sh") | crontab -
    check_command "Backup automático configurado"
fi

echo ""
echo "🎉 Deploy concluído com sucesso!"
echo ""
echo "🌐 Acesso:"
echo "  Aplicação:     http://31.97.85.98"
echo "  Health Check:  http://31.97.85.98/health"
echo ""
echo "📋 Comandos úteis:"
echo "  ./status.sh        - Ver status dos serviços"
echo "  ./logs.sh app      - Ver logs da aplicação"
echo "  ./logs.sh db       - Ver logs do banco"
echo "  ./logs.sh nginx    - Ver logs do nginx"
echo "  ./logs.sh all      - Ver todos os logs"
echo "  ./backup.sh        - Criar backup"
echo "  ./update.sh <img>  - Atualizar aplicação"
echo ""
echo "📂 Diretórios:"
echo "  /opt/ultrabase/data     - Dados da aplicação"
echo "  /opt/ultrabase/logs     - Logs da aplicação"
echo "  /opt/ultrabase/backups  - Backups automáticos"

#!/bin/bash
set -e

# Script de setup para deploy da Ultrabase na VPS
# Uso: ./setup.sh <imagem_docker>

IMAGE_NAME=${1:-ghcr.io/fernandinhomartins40/ultrabase-max:latest}
echo "🚀 Iniciando deploy com imagem: $IMAGE_NAME"

# Criar diretório de trabalho
mkdir -p /opt/ultrabase
cd /opt/ultrabase

# Criar arquivo .env se não existir
if [ ! -f .env ]; then
    echo "⚙️  Criando arquivo .env..."
    cat > .env << 'EOF'
# Configurações básicas do PostgreSQL
POSTGRES_PASSWORD=ultrabase_secure_password_2024
POSTGRES_DB=postgres
POSTGRES_PORT=5432
POSTGRES_HOST=db

# Configurações JWT
JWT_SECRET=your-super-secret-jwt-token-with-at-least-32-characters-long
JWT_EXPIRY=3600

# Chaves de API
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJzZXJ2aWNlX3JvbGUiLAogICAgImlzcyI6ICJzdXBhYmFzZS1kZW1vIiwKICAgICJpYXQiOiAxNjQxNzY5MjAwLAogICAgImV4cCI6IDE3OTk1MzU2MDAKfQ.DaYlNEoUrrEn2Ig7tqibS-PHK5vgusbcbo7X36XVt4Q

# Configurações do Kong
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443

# Configurações do Studio
STUDIO_DEFAULT_ORGANIZATION=Ultrabase
STUDIO_DEFAULT_PROJECT=Production
SUPABASE_PUBLIC_URL=http://localhost

# Configurações de email (desabilitadas por padrão)
ENABLE_EMAIL_SIGNUP=false
ENABLE_EMAIL_AUTOCONFIRM=false
SMTP_ADMIN_EMAIL=admin@example.com
SMTP_HOST=localhost
SMTP_PORT=2500
SMTP_USER=user
SMTP_PASS=pass
SMTP_SENDER_NAME=Ultrabase

# Configurações de telefone (desabilitadas por padrão)
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false

# Configurações de segurança
DISABLE_SIGNUP=false
ADDITIONAL_REDIRECT_URLS=
SITE_URL=http://localhost:3000
API_EXTERNAL_URL=http://localhost:8000

# Configurações do pooler
POOLER_PROXY_PORT_TRANSACTION=6543
POOLER_DEFAULT_POOL_SIZE=20
POOLER_MAX_CLIENT_CONN=100
POOLER_TENANT_ID=ultrabase
POOLER_DB_POOL_SIZE=5

# Configurações de analytics
LOGFLARE_PUBLIC_ACCESS_TOKEN=your-logflare-public-token
LOGFLARE_PRIVATE_ACCESS_TOKEN=your-logflare-private-token
EOF
fi

# Criar docker-compose.yml
echo "⚙️  Criando docker-compose.yml..."
cat > docker-compose.yml << EOF
version: '3.8'

services:
  ultrabase:
    image: $IMAGE_NAME
    container_name: ultrabase-app
    restart: unless-stopped
    ports:
      - "3000:3000"
      - "8000:8000"
    environment:
      - NODE_ENV=production
    env_file:
      - .env
    volumes:
      - ./data:/app/data
      - ./logs:/app/logs
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    depends_on:
      - db

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
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init-db:/docker-entrypoint-initdb.d
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

  nginx:
    image: nginx:alpine
    container_name: ultrabase-nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - ultrabase

volumes:
  postgres_data:
EOF

# Criar nginx.conf
echo "⚙️  Criando nginx.conf..."
cat > nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    upstream ultrabase {
        server ultrabase:3000;
    }

    upstream ultrabase-api {
        server ultrabase:8000;
    }

    # Rate limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    limit_req_zone $binary_remote_addr zone=web:10m rate=30r/s;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;

    server {
        listen 80;
        server_name _;
        
        # Redirect HTTP to HTTPS in production
        # return 301 https://$server_name$request_uri;
        
        location / {
            limit_req zone=web burst=20 nodelay;
            proxy_pass http://ultrabase;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }
        
        location /api/ {
            limit_req zone=api burst=50 nodelay;
            proxy_pass http://ultrabase-api;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
        }
        
        location /health {
            access_log off;
            return 200 "healthy\n";
            add_header Content-Type text/plain;
        }
    }
}
EOF

# Criar diretórios necessários
mkdir -p data logs ssl init-db

# Criar script de atualização
cat > update.sh << 'EOF'
#!/bin/bash
set -e

echo "🔄 Atualizando Ultrabase..."

# Parar containers
docker-compose down

# Atualizar imagem
docker pull $1

# Iniciar containers
docker-compose up -d

# Limpar imagens antigas
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
docker exec ultrabase-db pg_dump -U postgres postgres > $BACKUP_DIR/db_backup_$DATE.sql

# Backup dos arquivos de configuração
tar -czf $BACKUP_DIR/config_backup_$DATE.tar.gz docker-compose.yml nginx.conf .env

# Remover backups antigos (manter últimos 7 dias)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "✅ Backup criado: $BACKUP_DIR/db_backup_$DATE.sql"
EOF

chmod +x backup.sh

# Criar script de logs
cat > logs.sh << 'EOF'
#!/bin/bash
case "$1" in
    app)
        docker logs -f ultrabase-app
        ;;
    db)
        docker logs -f ultrabase-db
        ;;
    nginx)
        docker logs -f ultrabase-nginx
        ;;
    *)
        echo "Uso: $0 {app|db|nginx}"
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
docker-compose ps
echo ""
echo "📈 Uso de recursos:"
echo "=================="
docker stats --no-stream
EOF

chmod +x status.sh

# Parar containers antigos se existirem
docker-compose down || true

# Atualizar imagem
echo "📥 Baixando imagem: $IMAGE_NAME"
docker pull $IMAGE_NAME

# Iniciar serviços
echo "🚀 Iniciando serviços..."
docker-compose up -d

# Aguardar inicialização
echo "⏳ Aguardando inicialização..."
sleep 30

# Verificar saúde dos serviços
echo "🔍 Verificando saúde dos serviços..."
docker-compose ps

# Criar health check endpoint
curl -f http://localhost/health && echo "✅ Serviço está rodando!" || echo "❌ Serviço não está respondendo"

# Configurar backup automático (opcional)
if ! crontab -l | grep -q "backup.sh"; then
    echo "📅 Configurando backup automático diário às 3h..."
    (crontab -l 2>/dev/null; echo "0 3 * * * /opt/ultrabase/backup.sh") | crontab -
fi

echo ""
echo "🎉 Deploy concluído com sucesso!"
echo ""
echo "Acesse: http://31.97.85.98"
echo ""
echo "Comandos úteis:"
echo "  ./status.sh    - Ver status dos serviços"
echo "  ./logs.sh app  - Ver logs da aplicação"
echo "  ./backup.sh    - Criar backup"
echo "  ./update.sh    - Atualizar aplicação"

# ✅ Checklist de Preparação para Deploy - Ultrabase VPS

## 🔧 Configuração do Ambiente

### ✅ VPS Configuration
- [x] VPS IP: 31.97.85.98
- [x] Usuário: root
- [x] Sistema: Ubuntu 20.04+ ou Debian 10+
- [x] Portas liberadas: 80, 443, 3000, 8000, 5432

### ✅ Docker Installation
```bash
# Verificar se Docker está instalado
docker --version
docker-compose --version

# Se não estiver instalado:
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

### ✅ GitHub Secrets Configuration
Vá em: Settings > Secrets and variables > Actions

- [x] **VPS_PASSWORD**: Senha SSH do root@31.97.85.98

## 🚀 Arquivos de Deploy Criados

### ✅ GitHub Actions Workflow
- [x] `.github/workflows/deploy-vps.yml` - Workflow completo de deploy

### ✅ Docker Configuration
- [x] `Dockerfile` - Multi-stage build otimizado
- [x] `.dockerignore` - Arquivos a serem ignorados

### ✅ Deploy Scripts
- [x] `deploy/setup.sh` - Script de instalação na VPS
- [x] `deploy/update.sh` - Script de atualização
- [x] `deploy/backup.sh` - Script de backup
- [x] `deploy/logs.sh` - Script de visualização de logs
- [x] `deploy/status.sh` - Script de status dos serviços
- [x] `deploy/README.md` - Documentação completa

### ✅ Environment Configuration
- [x] `.env.production` - Configurações de produção
- [x] `docker-compose.yml` - Gerado dinamicamente pelo script

## 🧪 Testes Necessários

### ✅ Build Test
```bash
# Testar build local
docker build -t ultrabase-test .
```

### ✅ Health Check
```bash
# Verificar se a aplicação responde
curl -f http://localhost:3000/health
```

### ✅ Database Connection
```bash
# Testar conexão com PostgreSQL
docker exec ultrabase-db pg_isready -U postgres
```

## 🔐 Segurança

### ✅ SSL Certificate (Let's Encrypt)
```bash
# Instalar Certbot
apt update && apt install certbot python3-certbot-nginx -y

# Obter certificado SSL
certbot --nginx -d seu-dominio.com
```

### ✅ Firewall Configuration
```bash
# Instalar UFW
apt install ufw -y

# Configurar regras
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
```

## 📊 Monitoramento

### ✅ Health Checks
- [x] Endpoint: http://31.97.85.98/health
- [x] Docker health checks configurados
- [x] Nginx rate limiting ativado

### ✅ Backup Automático
- [x] Configurado para rodar diariamente às 3h
- [x] Backups armazenados em `/opt/ultrabase/backups/`
- [x] Retenção de 7 dias

## 🚀 Execução do Deploy

### ✅ Método 1: GitHub Actions (Automático)
1. Push para branch `main`
2. Workflow executa automaticamente
3. Deploy completo em ~5-10 minutos

### ✅ Método 2: Manual via Script
```bash
# Conectar na VPS
ssh root@31.97.85.98

# Executar script de setup
bash -c "$(curl -fsSL https://raw.githubusercontent.com/fernandinhomartins40/ultrabase-max/main/deploy/setup.sh)"
```

## 📋 Verificação Final

### ✅ Antes do Deploy
- [ ] Todas as secrets configuradas no GitHub
- [ ] Dockerfile testado localmente
- [ ] Scripts de deploy testados
- [ ] Variáveis de ambiente revisadas

### ✅ Após o Deploy
- [ ] Aplicação acessível em http://31.97.85.98
- [ ] Banco de dados funcionando
- [ ] Logs sem erros críticos
- [ ] Backup automático configurado
- [ ] Monitoramento ativo

## 🔄 Manutenção

### ✅ Comandos Úteis
```bash
# Status dos serviços
cd /opt/ultrabase && ./status.sh

# Ver logs
./logs.sh app    # Aplicação
./logs.sh db     # Banco de dados
./logs.sh nginx  # Nginx

# Criar backup
./backup.sh

# Atualizar aplicação
./update.sh ghcr.io/fernandinhomartins40/ultrabase-max:latest
```

## 🚨 Troubleshooting Rápido

### Problemas Comuns:
1. **Porta já em uso**: `lsof -i :3000`
2. **Docker não inicia**: `systemctl restart docker`
3. **Permissões**: `chmod +x deploy/*.sh`
4. **Logs detalhados**: `docker-compose logs -f`

## 📞 Suporte

Em caso de problemas:
1. Verifique os logs: `./logs.sh app`
2. Verifique status: `./status.sh`
3. Crie backup antes de alterações
4. Abra issue no GitHub com logs relevantes

---

**Status**: ✅ **PRONTO PARA DEPLOY**
**Última atualização**: 23/07/2025 21:56
**Versão**: 1.0.0

# Deploy Ultrabase VPS

Este diretório contém os arquivos necessários para realizar o deploy da Ultrabase em uma VPS.

## 📋 Pré-requisitos

- VPS com Ubuntu 20.04+ ou Debian 10+
- Docker e Docker Compose instalados
- Portas 80, 443, 3000 e 8000 liberadas
- Acesso SSH com usuário root

## 🚀 Instalação Automática

O deploy é feito automaticamente via GitHub Actions quando há push na branch `main`.

### Configuração das Secrets no GitHub

Vá em Settings > Secrets and variables > Actions e adicione:

- `VPS_PASSWORD`: Senha SSH do usuário root da VPS

## 🔧 Instalação Manual

Se preferir instalar manualmente:

1. **Conectar na VPS:**
   ```bash
   ssh root@31.97.85.98
   ```

2. **Instalar Docker (se não tiver):**
   ```bash
   curl -fsSL https://get.docker.com -o get-docker.sh
   sh get-docker.sh
   ```

3. **Executar o script de setup:**
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/fernandinhomartins40/ultrabase-max/main/deploy/setup.sh)"
   ```

## 📁 Estrutura de Arquivos

```
/opt/ultrabase/
├── docker-compose.yml    # Configuração dos containers
├── nginx.conf           # Configuração do Nginx
├── .env                 # Variáveis de ambiente
├── setup.sh             # Script de instalação
├── update.sh            # Script de atualização
├── backup.sh            # Script de backup
├── logs.sh              # Script de logs
├── status.sh            # Script de status
├── data/                # Dados persistentes
├── logs/                # Logs da aplicação
├── ssl/                 # Certificados SSL
├── backups/             # Backups automáticos
└── init-db/             # Scripts de inicialização do banco
```

## 🐳 Comandos Úteis

### Verificar status dos serviços
```bash
cd /opt/ultrabase
./status.sh
```

### Ver logs
```bash
./logs.sh app    # Logs da aplicação
./logs.sh db     # Logs do banco de dados
./logs.sh nginx  # Logs do nginx
```

### Atualizar aplicação
```bash
./update.sh ghcr.io/fernandinhomartins40/ultrabase-max:nova-tag
```

### Criar backup
```bash
./backup.sh
```

### Parar serviços
```bash
docker-compose down
```

### Iniciar serviços
```bash
docker-compose up -d
```

## 🔐 Segurança

### Configurar SSL (Let's Encrypt)
```bash
# Instalar Certbot
apt update && apt install certbot python3-certbot-nginx -y

# Obter certificado
certbot --nginx -d seu-dominio.com
```

### Firewall UFW
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

## 🔄 Backup Automático

O backup automático está configurado para rodar diariamente às 3h.
Backups são armazenados em `/opt/ultrabase/backups/` e mantidos por 7 dias.

## 🚨 Troubleshooting

### Serviço não inicia
```bash
# Verificar logs
docker-compose logs

# Verificar portas
netstat -tulpn | grep :3000

# Reiniciar serviços
docker-compose restart
```

### Banco de dados não conecta
```bash
# Verificar se o PostgreSQL está rodando
docker-compose ps db

# Verificar logs do banco
docker-compose logs db
```

### Problemas de memória
```bash
# Verificar uso de memória
free -h
docker stats

# Reiniciar containers
docker-compose restart
```

## 📞 Suporte

Em caso de problemas:
1. Verifique os logs com `./logs.sh app`
2. Verifique o status com `./status.sh`
3. Crie um backup antes de tentar soluções
4. Abra uma issue no GitHub

## 📝 Notas

- A aplicação roda na porta 3000 (HTTP) e 8000 (API)
- O PostgreSQL roda na porta 5432
- O Nginx faz proxy reverso na porta 80
- Certificados SSL são armazenados em `./ssl/`
- Dados persistentes são armazenados em volumes Docker

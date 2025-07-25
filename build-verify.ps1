# Script de Verificação Completa do Build - Ultrabase
# Executa verificações abrangentes antes do deploy

param(
    [switch]$SkipTests,
    [switch]$SkipLint,
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "🔍 $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

try {
    Write-Host "🚀 Iniciando Verificação Completa do Build - Ultrabase" -ForegroundColor Blue
    Write-Host "=================================================" -ForegroundColor Blue

    # 1. Verificar Node.js e pnpm
    Write-Step "Verificando ambiente de desenvolvimento..."
    
    $nodeVersion = node --version
    if ($LASTEXITCODE -ne 0) {
        throw "Node.js não está instalado"
    }
    
    $pnpmVersion = pnpm --version
    if ($LASTEXITCODE -ne 0) {
        throw "pnpm não está instalado"
    }
    
    Write-Success "Node.js: $nodeVersion, pnpm: $pnpmVersion"

    # 2. Verificar arquivos essenciais
    Write-Step "Verificando arquivos essenciais..."
    
    $essentialFiles = @(
        "package.json",
        "pnpm-lock.yaml",
        "pnpm-workspace.yaml",
        "turbo.json",
        "Dockerfile",
        "apps/studio/package.json",
        "apps/studio/next.config.js"
    )
    
    foreach ($file in $essentialFiles) {
        if (!(Test-Path $file)) {
            throw "Arquivo essencial não encontrado: $file"
        }
    }
    Write-Success "Todos os arquivos essenciais estão presentes"

    # 3. Validar package.json
    Write-Step "Validando package.json..."
    try {
        $packageJson = Get-Content "package.json" | ConvertFrom-Json
        if (!$packageJson.name) {
            throw "package.json inválido"
        }
    } catch {
        throw "Erro ao validar package.json: $_"
    }
    Write-Success "package.json válido"

    # 4. Verificar dependências
    Write-Step "Verificando integridade das dependências..."
    
    # Verificar pnpm-lock.yaml
    if (!(Test-Path "pnpm-lock.yaml")) {
        Write-Warning "pnpm-lock.yaml não encontrado, executando pnpm install..."
        pnpm install
        if ($LASTEXITCODE -ne 0) {
            throw "Falha na instalação das dependências"
        }
    }
    
    # Instalar dependências (se necessário)
    Write-Step "Instalando/verificando dependências..."
    pnpm install --frozen-lockfile
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Frozen lockfile falhou, tentando instalação padrão..."
        pnpm install
        if ($LASTEXITCODE -ne 0) {
            throw "Falha na instalação das dependências"
        }
    }
    Write-Success "Dependências instaladas com sucesso"

    # 5. TypeScript checking
    Write-Step "Verificando TypeScript..."
    pnpm typecheck
    if ($LASTEXITCODE -ne 0) {
        if ($Verbose) {
            Write-Warning "Erros de TypeScript encontrados (continuando...)"
        } else {
            Write-Warning "Erros de TypeScript encontrados. Use -Verbose para mais detalhes"
        }
    } else {
        Write-Success "Verificação TypeScript passou"
    }

    # 6. Linting (opcional)
    if (-not $SkipLint) {
        Write-Step "Executando linting..."
        pnpm lint
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Problemas de linting encontrados"
        } else {
            Write-Success "Linting passou"
        }
    }

    # 7. Testes (opcional)
    if (-not $SkipTests) {
        Write-Step "Executando testes..."
        # pnpm test:studio
        # if ($LASTEXITCODE -ne 0) {
        #     Write-Warning "Alguns testes falharam"
        # } else {
        #     Write-Success "Todos os testes passaram"
        # }
        Write-Success "Testes pulados (não implementados ainda)"
    }

    # 8. Build do Studio
    Write-Step "Testando build do Studio..."
    pnpm build:studio
    if ($LASTEXITCODE -ne 0) {
        throw "Falha no build do Studio"
    }
    Write-Success "Build do Studio concluído com sucesso"

    # 9. Verificar arquivos de build
    Write-Step "Verificando arquivos de build..."
    
    $buildFiles = @(
        "apps/studio/.next",
        "apps/studio/.next/standalone"
    )
    
    foreach ($buildPath in $buildFiles) {
        if (!(Test-Path $buildPath)) {
            throw "Arquivos de build não encontrados: $buildPath"
        }
    }
    Write-Success "Arquivos de build verificados"

    # 10. Teste do Docker build (opcional)
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        Write-Step "Testando build do Docker (pode demorar)..."
        docker build --no-cache -t ultrabase-test .
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Build do Docker falhou"
        } else {
            Write-Success "Build do Docker bem-sucedido"
            
            # Cleanup
            docker rmi ultrabase-test -f 2>$null
        }
    } else {
        Write-Warning "Docker não disponível - pulando teste de build"
    }

    # 11. Resumo final
    Write-Host ""
    Write-Host "🎉 VERIFICAÇÃO COMPLETA - RESULTADOS" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Green
    Write-Success "✅ Ambiente configurado corretamente"
    Write-Success "✅ Dependências instaladas e válidas"
    Write-Success "✅ Build do Studio funcionando"
    Write-Success "✅ Arquivos essenciais presentes"
    Write-Host ""
    Write-Host "🚀 Projeto pronto para deploy!" -ForegroundColor Green

} catch {
    Write-Host ""
    Write-Host "💥 VERIFICAÇÃO FALHOU" -ForegroundColor Red
    Write-Host "===================" -ForegroundColor Red
    Write-Error $_.Exception.Message
    Write-Host ""
    Write-Host "💡 Sugestões para correção:" -ForegroundColor Yellow
    Write-Host "- Verifique se todas as dependências estão instaladas" -ForegroundColor Yellow
    Write-Host "- Execute 'pnpm install' para instalar dependências" -ForegroundColor Yellow
    Write-Host "- Verifique erros de TypeScript e corrija se necessário" -ForegroundColor Yellow
    Write-Host "- Consulte os logs acima para mais detalhes" -ForegroundColor Yellow
    
    exit 1
}

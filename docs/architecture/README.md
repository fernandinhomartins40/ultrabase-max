# Arquitetura do Ultrabase

## Visão Geral

O Ultrabase é um fork multi-tenant do Supabase, projetado para gerenciar múltiplos projetos e organizações em uma única instância.

## Arquitetura do Sistema

```
┌─────────────────────────────────────────────────────────────┐
│                    Ultrabase Platform                      │
├─────────────────────────────────────────────────────────────┤
│  Apps Layer                                                 │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐      │
│  │   WWW    │ │  Studio  │ │   Docs   │ │   CMS    │      │
│  │  (Site)  │ │(Dashboard)│ │ (Guides) │ │(Content) │      │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘      │
├─────────────────────────────────────────────────────────────┤
│  Packages Layer (Shared)                                   │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐          │
│  │  Common │ │   UI    │ │ Config  │ │  Types  │          │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘          │
├─────────────────────────────────────────────────────────────┤
│  Infrastructure Layer                                      │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐          │
│  │  PostgreSQL │ │   Storage   │ │   Auth      │          │
│  │  (Database) │ │  (Files)    │ │ (Sessions)  │          │
│  └─────────────┘ └─────────────┘ └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## Estrutura do Monorepo

### Apps (`/apps`)
- **www**: Site principal (supabase.com)
- **studio**: Dashboard administrativo
- **docs**: Documentação e guias
- **cms**: Sistema de gerenciamento de conteúdo
- **design-system**: Sistema de design
- **ui-library**: Biblioteca de componentes

### Packages (`/packages`)
- **common**: Componentes React compartilhados
- **ui**: Componentes de UI base
- **config**: Configurações compartilhadas
- **shared-data**: Dados compartilhados
- **tsconfig**: Configurações TypeScript

## Multi-Tenancy

O Ultrabase implementa multi-tenancy através de:

1. **Isolamento de Schema**: Cada tenant tem seu próprio schema
2. **Auth Contextual**: Autenticação baseada no contexto do tenant
3. **Organizações**: Agrupamento de projetos por organização
4. **Projetos**: Unidades isoladas dentro de organizações

## Tecnologias Principais

- **Frontend**: Next.js, React, TypeScript
- **Backend**: PostgreSQL, PostgREST
- **Build System**: Turbo (monorepo)
- **Package Manager**: pnpm
- **Containerização**: Docker
- **CI/CD**: GitHub Actions

## Fluxo de Dados

```
Client Request
     ↓
Load Balancer
     ↓
Next.js Apps
     ↓
API Gateway
     ↓
PostgreSQL
```

## Padrões de Design

### Arquitetura Hexagonal
- Separação clara entre domínio e infraestrutura
- Adaptadores para diferentes interfaces

### Event-Driven
- Comunicação assíncrona entre serviços
- Padrão pub/sub para notificações

### Microservices-Ready
- Estrutura preparada para decomposição
- APIs bem definidas entre componentes 
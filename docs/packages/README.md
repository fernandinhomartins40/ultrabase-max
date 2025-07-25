# Packages Compartilhados - Ultrabase

Esta pasta contém todos os packages compartilhados entre as aplicações do monorepo.

## 📦 Packages Disponíveis

### Core Packages

#### `ai-commands`
- **Propósito**: Comandos e helpers relacionados a IA
- **Usado por**: Apps que implementam funcionalidades de IA
- **Tipo**: Utilitários

#### `common`
- **Propósito**: Componentes React e utilitários compartilhados
- **Usado por**: Todos os apps
- **Tipo**: Componentes e hooks

#### `config`
- **Propósito**: Configurações compartilhadas (ESLint, Prettier, etc.)
- **Usado por**: Todo o monorepo
- **Tipo**: Configuração

#### `shared-data`
- **Propósito**: Dados estáticos compartilhados
- **Usado por**: Apps que precisam de dados centralizados
- **Tipo**: Dados

#### `tsconfig`
- **Propósito**: Configurações TypeScript base
- **Usado por**: Todo o monorepo
- **Tipo**: Configuração

### UI Packages

#### `ui`
- **Propósito**: Componentes de UI base (design system)
- **Usado por**: Todos os apps frontend
- **Tipo**: Componentes UI
- **Features**: Radix UI, Tailwind CSS, Shadcn/ui

#### `ui-patterns`
- **Propósito**: Padrões de UI complexos e compostos
- **Usado por**: Apps que precisam de padrões específicos
- **Tipo**: Componentes compostos

#### `icons`
- **Propósito**: Biblioteca de ícones
- **Usado por**: Apps que precisam de ícones customizados
- **Tipo**: Assets

### Tool Packages

#### `api-types`
- **Propósito**: Tipos TypeScript para APIs
- **Usado por**: Apps que consomem APIs
- **Tipo**: Tipos

#### `build-icons`
- **Propósito**: Scripts para processar ícones
- **Usado por**: Build process
- **Tipo**: Build tools

#### `cli`
- **Propósito**: CLI do Ultrabase
- **Usado por**: Desenvolvimento e deploy
- **Tipo**: Ferramenta

#### `eslint-config-supabase`
- **Propósito**: Configuração ESLint específica
- **Usado por**: Todo o monorepo
- **Tipo**: Configuração

#### `generator`
- **Propósito**: Geradores de código e documentação
- **Usado por**: Build process
- **Tipo**: Build tools

#### `pg-meta`
- **Propósito**: Metadados e utilitários PostgreSQL
- **Usado por**: Apps que interagem com banco
- **Tipo**: Database utilities

## 🏗️ Estrutura Recomendada

Cada package deve seguir esta estrutura:

```
package-name/
├── src/                   # Código fonte
│   ├── index.ts          # Entry point
│   ├── components/       # Componentes (se aplicável)
│   ├── utils/            # Utilitários
│   └── types/            # Tipos TypeScript
├── dist/                 # Build output
├── tests/                # Testes
├── package.json          # Configuração
├── tsconfig.json         # TypeScript config
├── README.md             # Documentação
└── CHANGELOG.md          # Histórico de mudanças
```

## 🔄 Dependências

### Princípios:

1. **Minimal Dependencies**: Mantenha dependências mínimas
2. **Peer Dependencies**: Use peer deps para React, Next.js, etc.
3. **Workspace Dependencies**: Use `workspace:*` para packages internos
4. **Catalog**: Use `catalog:` para dependências versionadas

### Exemplo package.json:

```json
{
  "name": "package-name",
  "version": "0.0.0",
  "main": "./index.ts",
  "types": "./index.ts",
  "dependencies": {
    "other-package": "workspace:*"
  },
  "peerDependencies": {
    "react": "catalog:",
    "next": "catalog:"
  }
}
```

## 🧪 Testes

Cada package deve incluir:

- **Unit tests**: Para funções e componentes
- **Integration tests**: Para fluxos complexos
- **Type tests**: Para validação de tipos

## 📚 Documentação

Cada package deve ter:

- **README.md**: Documentação principal
- **CHANGELOG.md**: Histórico de mudanças
- **API docs**: Para packages complexos

## 🔧 Manutenção

### Adicionando um novo package:

1. Criar estrutura seguindo o padrão
2. Adicionar ao `pnpm-workspace.yaml`
3. Configurar build no `turbo.json`
4. Documentar no README do package
5. Adicionar testes básicos

### Atualizando packages:

1. Seguir semantic versioning
2. Atualizar CHANGELOG.md
3. Executar testes
4. Verificar dependentes 
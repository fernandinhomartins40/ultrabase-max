# Guia de Estrutura de Pastas - Ultrabase

Este documento define os padrões de estrutura de pastas para manter consistência no monorepo.

## 📁 Estrutura Geral do Monorepo

```
ultrabase-max/
├── apps/                    # Aplicações
├── packages/               # Packages compartilhados
├── docs/                   # Documentação centralizada
├── scripts/                # Scripts utilitários
├── config/                 # Configurações compartilhadas
├── docker/                 # Configurações Docker
├── e2e/                    # Testes end-to-end
├── examples/               # Exemplos de uso
├── supabase/               # Configurações Supabase
└── deploy/                 # Scripts de deploy
```

## 📱 Estrutura Padrão para Apps

### Next.js Apps (`/apps/{app-name}`)

```
app-name/
├── src/                    # Código fonte
│   ├── app/               # App Router (Next.js 13+)
│   ├── components/        # Componentes React
│   ├── lib/               # Utilities e helpers
│   ├── hooks/             # Custom React hooks
│   ├── types/             # Definições TypeScript
│   ├── styles/            # Estilos CSS/SCSS
│   └── data/              # Dados estáticos
├── public/                # Assets estáticos
├── tests/                 # Testes
├── .eslintrc.js           # Configuração ESLint
├── tsconfig.json          # Configuração TypeScript
├── next.config.mjs        # Configuração Next.js
├── package.json           # Dependências
└── README.md             # Documentação do app
```

## 📦 Estrutura Padrão para Packages

```
package-name/
├── src/                   # Código fonte
│   ├── index.ts          # Entry point principal
│   ├── components/       # Componentes (se aplicável)
│   ├── utils/            # Funções utilitárias
│   ├── types/            # Tipos TypeScript
│   └── constants/        # Constantes
├── dist/                 # Build output (ignorado no git)
├── tests/                # Testes
├── .eslintrc.js          # Configuração ESLint
├── tsconfig.json         # Configuração TypeScript
├── package.json          # Dependências e config
├── README.md             # Documentação
└── CHANGELOG.md          # Log de mudanças
```

## 🎨 Convenções de Nomenclatura

### Arquivos e Pastas

- **PascalCase**: Componentes React (`Button.tsx`, `UserCard.tsx`)
- **camelCase**: Funções, hooks, utilities (`getUserData.ts`, `useAuth.ts`)
- **kebab-case**: URLs, IDs, CSS classes (`user-profile`, `nav-item`)
- **snake_case**: Database, environment variables (`user_id`, `DATABASE_URL`)

## 🔧 Configurações Padronizadas

### ESLint

```javascript
// Usar configuração base do monorepo
module.exports = {
  extends: ['../../config/eslint/next.js'], // ou base.js para non-Next.js
}
```

### TypeScript

```json
{
  "extends": "../../config/tsconfig/base.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### Prettier

```json
{
  "extends": "../../config/prettier/base.json"
}
```

## ✅ Checklist para Novos Apps/Packages

### Antes de criar:

- [ ] Nome segue convenções (kebab-case)
- [ ] Propósito está claro e documentado
- [ ] Não duplica funcionalidade existente

### Durante criação:

- [ ] Seguir estrutura de pastas padrão
- [ ] Configurar ESLint, Prettier, TypeScript
- [ ] Adicionar scripts padronizados
- [ ] Criar README.md

### Após criação:

- [ ] Testes básicos funcionando
- [ ] Build sem erros
- [ ] Lint sem warnings
- [ ] Documentação atualizada
- [ ] Adicionado ao workspace (pnpm-workspace.yaml) 
# Padrões de Testes - Ultrabase

Este documento define os padrões de testes para manter qualidade e consistência no monorepo.

## 🧪 Tipos de Testes

### 1. **Unit Tests** (Testes Unitários)
- **Propósito**: Testar funções, hooks e componentes isoladamente
- **Framework**: Jest + React Testing Library
- **Localização**: `__tests__/` ou `*.test.ts/tsx`
- **Coverage**: Mínimo 70%

### 2. **Integration Tests** (Testes de Integração)
- **Propósito**: Testar fluxos entre componentes
- **Framework**: Jest + React Testing Library
- **Localização**: `__tests__/integration/`
- **Coverage**: Fluxos críticos

### 3. **E2E Tests** (Testes End-to-End)
- **Propósito**: Testar aplicação completa
- **Framework**: Playwright
- **Localização**: `/e2e/`
- **Coverage**: Jornadas do usuário

## 📁 Estrutura de Testes

### Apps

```
app-name/
├── src/
│   ├── components/
│   │   ├── Button/
│   │   │   ├── Button.tsx
│   │   │   └── __tests__/
│   │   │       ├── Button.test.tsx
│   │   │       └── Button.integration.test.tsx
│   │   └── __tests__/
│   │       └── components.integration.test.tsx
│   ├── lib/
│   │   ├── utils.ts
│   │   └── __tests__/
│   │       └── utils.test.ts
│   └── hooks/
│       ├── useAuth.ts
│       └── __tests__/
│           └── useAuth.test.ts
├── __tests__/
│   ├── setup.ts
│   ├── fixtures/
│   └── __mocks__/
└── jest.config.js
```

### Packages

```
package-name/
├── src/
│   ├── index.ts
│   ├── components/
│   │   └── __tests__/
│   └── utils/
│       └── __tests__/
├── tests/
│   ├── fixtures/
│   ├── __mocks__/
│   └── integration/
└── jest.config.js
```

## ⚙️ Configuração

### Jest Base

Todos os projetos devem estender a configuração base:

```javascript
// jest.config.js
const baseConfig = require('../../config/testing/jest.config.base.js')

module.exports = {
  ...baseConfig,
  // Configurações específicas do projeto
  displayName: 'app-name',
  rootDir: '.',
  testMatch: [
    '<rootDir>/src/**/__tests__/**/*.(ts|tsx)',
    '<rootDir>/src/**/*.(test|spec).(ts|tsx)',
  ],
}
```

### Setup por App

```javascript
// jest.setup.js
import '../../config/testing/jest.setup.js'

// Configurações específicas do app
// Mock APIs, contextos, etc.
```

## 🧩 Padrões de Escrita

### 1. **Nomenclatura**

```typescript
// ✅ Bom
describe('Button Component', () => {
  it('should render with correct text', () => {})
  it('should handle click events', () => {})
  it('should apply custom className', () => {})
})

// ❌ Ruim
describe('Button', () => {
  it('works', () => {})
  it('test click', () => {})
})
```

### 2. **Estrutura AAA**

```typescript
// Arrange, Act, Assert
it('should update count when button is clicked', () => {
  // Arrange
  const { getByRole } = render(<Counter initialCount={0} />)
  const button = getByRole('button', { name: /increment/i })
  
  // Act
  fireEvent.click(button)
  
  // Assert
  expect(getByRole('button')).toHaveTextContent('1')
})
```

### 3. **Testing Components**

```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { Button } from '../Button'

describe('Button Component', () => {
  it('should render children correctly', () => {
    render(<Button>Click me</Button>)
    expect(screen.getByRole('button')).toHaveTextContent('Click me')
  })

  it('should call onClick when clicked', () => {
    const handleClick = jest.fn()
    render(<Button onClick={handleClick}>Click me</Button>)
    
    fireEvent.click(screen.getByRole('button'))
    expect(handleClick).toHaveBeenCalledTimes(1)
  })

  it('should apply custom className', () => {
    render(<Button className="custom-class">Click me</Button>)
    expect(screen.getByRole('button')).toHaveClass('custom-class')
  })
})
```

### 4. **Testing Hooks**

```typescript
import { renderHook, act } from '@testing-library/react'
import { useCounter } from '../useCounter'

describe('useCounter Hook', () => {
  it('should initialize with correct value', () => {
    const { result } = renderHook(() => useCounter(5))
    expect(result.current.count).toBe(5)
  })

  it('should increment count', () => {
    const { result } = renderHook(() => useCounter(0))
    
    act(() => {
      result.current.increment()
    })
    
    expect(result.current.count).toBe(1)
  })
})
```

### 5. **Testing Utils**

```typescript
import { formatDate, validateEmail } from '../utils'

describe('Utility Functions', () => {
  describe('formatDate', () => {
    it('should format date correctly', () => {
      const date = new Date('2023-01-01')
      expect(formatDate(date)).toBe('01/01/2023')
    })

    it('should handle invalid dates', () => {
      expect(formatDate(null)).toBe('')
    })
  })

  describe('validateEmail', () => {
    it('should validate correct emails', () => {
      expect(validateEmail('test@example.com')).toBe(true)
    })

    it('should reject invalid emails', () => {
      expect(validateEmail('invalid-email')).toBe(false)
    })
  })
})
```

## 🎯 Mocks

### 1. **API Mocks**

```typescript
// __mocks__/api.ts
export const mockApi = {
  getUser: jest.fn().mockResolvedValue({ id: 1, name: 'John' }),
  updateUser: jest.fn().mockResolvedValue({ success: true }),
}

// Em testes
jest.mock('../api', () => require('../__mocks__/api'))
```

### 2. **Component Mocks**

```typescript
// __mocks__/ComplexComponent.tsx
export const ComplexComponent = jest.fn(() => <div>Mocked Component</div>)

// Em testes
jest.mock('../ComplexComponent', () => 
  require('../__mocks__/ComplexComponent')
)
```

### 3. **Context Mocks**

```typescript
// __mocks__/AuthContext.tsx
export const mockAuthContext = {
  user: { id: 1, name: 'John' },
  login: jest.fn(),
  logout: jest.fn(),
}

export const AuthProvider = ({ children }) => (
  <AuthContext.Provider value={mockAuthContext}>
    {children}
  </AuthContext.Provider>
)
```

## 📊 Coverage

### Métricas Mínimas

- **Statements**: 70%
- **Branches**: 70%
- **Functions**: 70%
- **Lines**: 70%

### Exclusões

```javascript
// jest.config.js
collectCoverageFrom: [
  'src/**/*.(ts|tsx)',
  '!src/**/*.d.ts',
  '!src/**/*.stories.(ts|tsx)',
  '!src/**/index.(ts|tsx)',
  '!src/**/__tests__/**',
  '!src/**/__mocks__/**',
]
```

## 🚀 Scripts Padronizados

### Package.json

```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --watchAll=false",
    "test:debug": "jest --debug"
  }
}
```

### Turbo Configuration

```json
// turbo.json
{
  "pipeline": {
    "test": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "test:ci": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    }
  }
}
```

## ✅ Checklist de Qualidade

### Antes de Fazer Commit:

- [ ] Todos os testes passam
- [ ] Coverage mínimo atingido
- [ ] Nenhum teste ignorado sem justificativa
- [ ] Mocks apropriados utilizados
- [ ] Testes seguem padrões de nomenclatura

### Code Review:

- [ ] Testes cobrem casos de sucesso e erro
- [ ] Testes são legíveis e bem estruturados
- [ ] Mocks não são over-engineered
- [ ] Performance dos testes é adequada

### CI/CD:

- [ ] Testes executam em pipeline
- [ ] Coverage é reportado
- [ ] Testes paralelos quando possível
- [ ] Artefatos de teste são coletados

## 🛠️ Ferramentas

### Principais:

- **Jest**: Test runner e framework
- **React Testing Library**: Testing utilities para React
- **Playwright**: E2E testing
- **MSW**: API mocking
- **Testing Library Jest DOM**: Matchers adicionais

### Plugins Úteis:

- **jest-axe**: Testes de acessibilidade
- **jest-environment-jsdom**: Ambiente DOM para testes
- **identity-obj-proxy**: Mock para CSS modules

---

**Lembre-se**: Testes são documentação viva do código. Escreva-os pensando em quem vai ler e manter no futuro. 
module.exports = {
  extends: [
    './base.js',
    'next/core-web-vitals',
    'eslint-config-supabase/next',
  ],
  rules: {
    // Regras específicas para Next.js
    '@next/next/no-img-element': 'error',
    '@next/next/no-html-link-for-pages': 'error',
    'react/no-unescaped-entities': 'off',
    'react/display-name': 'off',
  },
  overrides: [
    {
      files: ['pages/**/*', 'app/**/*'],
      rules: {
        'import/no-default-export': 'off',
      },
    },
  ],
} 
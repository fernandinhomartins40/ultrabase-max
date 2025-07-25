#!/usr/bin/env node

/**
 * Script de Validação Pós-Deploy
 * Verifica se o deploy foi bem-sucedido testando endpoints críticos
 */

const https = require('https');
const http = require('http');

const CONFIG = {
  baseUrl: process.env.DEPLOYMENT_URL || 'http://31.97.85.98',
  timeout: 30000,
  retries: 3,
  retryDelay: 5000
};

// Lista de endpoints para testar
const ENDPOINTS = [
  {
    path: '/health',
    name: 'Health Check',
    critical: true,
    expectedStatus: 200
  },
  {
    path: '/api/health',
    name: 'API Health Check',
    critical: true,
    expectedStatus: 200
  },
  {
    path: '/',
    name: 'Main Application',
    critical: true,
    expectedStatus: [200, 301, 302]
  },
  {
    path: '/project/default',
    name: 'Default Project',
    critical: false,
    expectedStatus: [200, 301, 302]
  }
];

function log(level, message, ...args) {
  const timestamp = new Date().toISOString();
  const prefix = {
    info: '📋',
    success: '✅',
    error: '❌',
    warning: '⚠️'
  }[level] || '📋';
  
  console.log(`${prefix} [${timestamp}] ${message}`, ...args);
}

function makeRequest(url, timeout = CONFIG.timeout) {
  return new Promise((resolve, reject) => {
    const urlObj = new URL(url);
    const client = urlObj.protocol === 'https:' ? https : http;
    
    const request = client.get(url, {
      timeout,
      headers: {
        'User-Agent': 'Ultrabase-Deploy-Validator/1.0'
      }
    }, (response) => {
      let data = '';
      response.on('data', chunk => data += chunk);
      response.on('end', () => {
        resolve({
          statusCode: response.statusCode,
          headers: response.headers,
          data: data.length > 1000 ? data.substring(0, 1000) + '...' : data
        });
      });
    });

    request.on('timeout', () => {
      request.destroy();
      reject(new Error('Request timeout'));
    });

    request.on('error', reject);
  });
}

async function testEndpoint(endpoint, retryCount = 0) {
  const url = `${CONFIG.baseUrl}${endpoint.path}`;
  
  try {
    log('info', `Testing ${endpoint.name}: ${url}`);
    
    const response = await makeRequest(url);
    const expectedStatuses = Array.isArray(endpoint.expectedStatus) 
      ? endpoint.expectedStatus 
      : [endpoint.expectedStatus];
    
    if (expectedStatuses.includes(response.statusCode)) {
      log('success', `${endpoint.name} OK (${response.statusCode})`);
      
      // Para endpoints de health, verificar resposta JSON
      if (endpoint.path.includes('health')) {
        try {
          const healthData = JSON.parse(response.data);
          if (healthData.status === 'healthy') {
            log('success', `Health status: ${healthData.status}, uptime: ${healthData.uptime}s`);
          } else {
            log('warning', `Health status: ${healthData.status}`);
          }
        } catch (e) {
          log('warning', 'Health endpoint did not return valid JSON');
        }
      }
      
      return { success: true, statusCode: response.statusCode };
    } else {
      throw new Error(`Unexpected status code: ${response.statusCode}`);
    }
    
  } catch (error) {
    if (retryCount < CONFIG.retries) {
      log('warning', `${endpoint.name} failed (attempt ${retryCount + 1}/${CONFIG.retries + 1}): ${error.message}`);
      log('info', `Retrying in ${CONFIG.retryDelay/1000}s...`);
      
      await new Promise(resolve => setTimeout(resolve, CONFIG.retryDelay));
      return testEndpoint(endpoint, retryCount + 1);
    } else {
      log('error', `${endpoint.name} failed after ${CONFIG.retries + 1} attempts: ${error.message}`);
      return { success: false, error: error.message };
    }
  }
}

async function validateDeployment() {
  log('info', '🚀 Starting deployment validation...');
  log('info', `Target URL: ${CONFIG.baseUrl}`);
  log('info', `Timeout: ${CONFIG.timeout/1000}s, Retries: ${CONFIG.retries}`);
  
  const results = [];
  let criticalFailures = 0;
  let totalFailures = 0;

  for (const endpoint of ENDPOINTS) {
    const result = await testEndpoint(endpoint);
    results.push({ endpoint, result });
    
    if (!result.success) {
      totalFailures++;
      if (endpoint.critical) {
        criticalFailures++;
      }
    }
  }

  // Resumo dos resultados
  console.log('\n📊 DEPLOYMENT VALIDATION RESULTS');
  console.log('================================');
  
  results.forEach(({ endpoint, result }) => {
    const status = result.success ? '✅ PASS' : '❌ FAIL';
    const critical = endpoint.critical ? '[CRITICAL]' : '[OPTIONAL]';
    console.log(`${status} ${critical} ${endpoint.name}`);
    
    if (!result.success) {
      console.log(`    Error: ${result.error}`);
    }
  });

  console.log('\n📈 SUMMARY');
  console.log('===========');
  console.log(`Total endpoints tested: ${ENDPOINTS.length}`);
  console.log(`Successful: ${ENDPOINTS.length - totalFailures}`);
  console.log(`Failed: ${totalFailures}`);
  console.log(`Critical failures: ${criticalFailures}`);

  if (criticalFailures > 0) {
    console.log('\n❌ DEPLOYMENT VALIDATION FAILED');
    console.log('Critical endpoints are not responding correctly.');
    console.log('Please check the deployment and try again.');
    process.exit(1);
  } else if (totalFailures > 0) {
    console.log('\n⚠️  DEPLOYMENT VALIDATION COMPLETED WITH WARNINGS');
    console.log('Some optional endpoints failed, but critical services are working.');
    process.exit(0);
  } else {
    console.log('\n🎉 DEPLOYMENT VALIDATION SUCCESSFUL');
    console.log('All endpoints are responding correctly!');
    process.exit(0);
  }
}

// Executar validação
if (require.main === module) {
  validateDeployment().catch(error => {
    log('error', 'Validation script failed:', error.message);
    process.exit(1);
  });
}

module.exports = { validateDeployment, testEndpoint }; 
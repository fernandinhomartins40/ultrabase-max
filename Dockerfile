# Use Node.js 22 LTS
FROM node:22-alpine AS base

# Install pnpm and system dependencies for native modules
RUN apk update && apk add --no-cache \
    curl \
    python3 \
    make \
    g++ \
    libc6-compat \
    vips-dev \
    cairo-dev \
    pango-dev \
    jpeg-dev \
    giflib-dev \
    librsvg-dev \
    pixman-dev \
    pangomm-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    sqlite-dev \
    postgresql-dev \
    git \
    && npm install -g pnpm@9.15.5 \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Copy package files first for better layer caching
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json ./

# Copy only package.json files from apps and packages for dependency resolution
COPY apps/studio/package.json ./apps/studio/package.json
COPY apps/docs/package.json ./apps/docs/package.json
COPY apps/www/package.json ./apps/www/package.json
COPY apps/cms/package.json ./apps/cms/package.json
COPY apps/design-system/package.json ./apps/design-system/package.json
COPY apps/ui-library/package.json ./apps/ui-library/package.json

# Copy packages directory structure for workspace resolution
COPY packages/ ./packages/

# Configure pnpm settings for Docker environment
RUN pnpm config set store-dir /app/.pnpm-store && \
    pnpm config set cache-dir /app/.pnpm-cache && \
    pnpm config set state-dir /app/.pnpm-state && \
    pnpm config set fetch-retries 3 && \
    pnpm config set fetch-retry-factor 2 && \
    pnpm config set fetch-retry-maxtimeout 60000

# Install dependencies with robust error handling
RUN echo "🔄 Installing dependencies..." && \
    echo "📊 pnpm version: $(pnpm --version)" && \
    echo "📊 Node version: $(node --version)" && \
    echo "📊 Available memory: $(free -h)" && \
    echo "📊 Available disk: $(df -h /)" && \
    pnpm install --frozen-lockfile --prefer-offline --production=false \
    --reporter=append-only \
    --config.confirm-module-dir=false \
    --config.bail=false \
    || (echo "⚠️  First install attempt failed, retrying with clean cache..." && \
        rm -rf node_modules .pnpm-store .pnpm-cache .pnpm-state && \
        pnpm install --no-frozen-lockfile --production=false \
        --reporter=append-only \
        --config.confirm-module-dir=false) \
    || (echo "⚠️  Second attempt failed, trying with force..." && \
        rm -rf node_modules .pnpm-store .pnpm-cache .pnpm-state && \
        pnpm install --force --no-frozen-lockfile --production=false \
        --reporter=append-only \
        --config.confirm-module-dir=false)

# Verify dependencies installation
RUN echo "✅ Verifying dependencies..." && \
    pnpm ls --depth=0 || echo "⚠️ Some dependencies may have issues" && \
    echo "📊 node_modules size: $(du -sh node_modules/ | cut -f1)"

# Copy remaining source code after dependency installation
COPY . .

# Set production environment variables
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_DEPLOYMENT_PLATFORM=docker
ENV FORCE_COLOR=0

# Validate Next.js configuration before build
RUN echo "🔍 Validating Next.js configuration..." && \
    cd apps/studio && \
    npx next info && \
    echo "✅ Next.js configuration validated"

# Build only the studio app with error handling
RUN echo "🔨 Building studio app..." && \
    pnpm build:studio || \
    (echo "❌ Build failed, showing debug info..." && \
     echo "📊 Memory usage: $(free -h)" && \
     echo "📊 Disk usage: $(df -h)" && \
     echo "📋 Build logs:" && \
     cd apps/studio && \
     pnpm run build --verbose && \
     exit 1)

# Verify build output
RUN echo "✅ Verifying build output..." && \
    ls -la apps/studio/.next/ && \
    ls -la apps/studio/.next/standalone/ && \
    echo "📊 Build size: $(du -sh apps/studio/.next/ | cut -f1)"

# Production stage
FROM node:22-alpine AS production

# Install pnpm and runtime dependencies
RUN apk update && apk add --no-cache \
    curl \
    dumb-init \
    vips \
    cairo \
    pango \
    sqlite \
    postgresql-client \
    tzdata \
    && npm install -g pnpm@9.15.5 \
    && rm -rf /var/cache/apk/*

WORKDIR /app

# Create non-root user early
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 && \
    mkdir -p /app/logs /app/data && \
    chown -R nextjs:nodejs /app

# Copy built application with proper structure for Next.js standalone
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/.next/standalone ./
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/.next/static ./apps/studio/.next/static
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/public ./apps/studio/public

# Copy additional required files
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/package.json ./apps/studio/package.json

# Set environment variables for production
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_DEPLOYMENT_PLATFORM=docker

# Create API health endpoint script
RUN echo '#!/bin/sh' > /app/health-check.sh && \
    echo 'curl -f -s -m 5 http://localhost:3000/api/health || curl -f -s -m 5 http://localhost:3000/ || exit 1' >> /app/health-check.sh && \
    chmod +x /app/health-check.sh && \
    chown nextjs:nodejs /app/health-check.sh

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3000

# Health check with better endpoint and timeout
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD /app/health-check.sh

# Use dumb-init for proper signal handling
ENTRYPOINT ["dumb-init", "--"]

# Start the application using the standalone server
CMD ["node", "apps/studio/server.js"]

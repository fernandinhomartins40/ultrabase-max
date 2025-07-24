# Use Node.js 22 LTS
FROM node:22-alpine AS base

# Install pnpm and system dependencies for native modules
RUN npm install -g pnpm@9.15.5 && \
    apk add --no-cache \
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
    postgresql-dev

# Set working directory
WORKDIR /app

# Copy everything needed for dependencies
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json ./
COPY apps/ ./apps/
COPY packages/ ./packages/

# Install dependencies with fallback options
RUN pnpm install --frozen-lockfile || \
    (echo "❌ Frozen lockfile failed, trying without..." && pnpm install) || \
    (echo "❌ Regular install failed, trying with --force..." && pnpm install --force)

# Copy remaining source code (if any missed)
COPY . .

# Set production environment
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Build only the studio app
RUN pnpm build:studio

# Production stage
FROM node:22-alpine AS production

# Install pnpm and runtime dependencies
RUN npm install -g pnpm@9.15.5 && \
    apk add --no-cache \
    curl \
    dumb-init \
    vips \
    cairo \
    pango \
    sqlite \
    postgresql-client

WORKDIR /app

# Create non-root user early
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Copy built application with proper structure for Next.js standalone
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/.next/standalone ./
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/.next/static ./apps/studio/.next/static
COPY --from=base --chown=nextjs:nodejs /app/apps/studio/public ./apps/studio/public

# Set environment variables for production
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
ENV NEXT_TELEMETRY_DISABLED=1

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3000

# Health check with better endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/api/health || curl -f http://localhost:3000/ || exit 1

# Use dumb-init for proper signal handling
ENTRYPOINT ["dumb-init", "--"]

# Start the application using the standalone server
CMD ["node", "apps/studio/server.js"]

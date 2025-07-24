# Use Node.js 22 LTS
FROM node:22-alpine AS base

# Install pnpm
RUN npm install -g pnpm@9.15.5

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY apps/studio/package.json ./apps/studio/
COPY packages/*/package.json ./packages/*/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the application
RUN pnpm build:studio

# Production stage
FROM node:22-alpine AS production

# Install pnpm
RUN npm install -g pnpm@9.15.5

WORKDIR /app

# Copy built application
COPY --from=base /app/apps/studio/.next ./.next
COPY --from=base /app/apps/studio/package.json ./package.json
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/packages ./packages

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Change ownership
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start the application
CMD ["pnpm", "start"]

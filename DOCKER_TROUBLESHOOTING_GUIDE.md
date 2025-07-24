# Docker Build Troubleshooting Guide

## Issue: pnpm install --frozen-lockfile failing in Docker build

### Root Cause Analysis

The Docker build failure is caused by missing system dependencies required for native Node.js modules. The project uses several packages with native bindings that need additional system libraries:

**Problematic Native Dependencies:**
- **sharp** - Image processing library requiring `vips-dev`
- **canvas** - HTML5 Canvas implementation requiring `cairo-dev`, `pango-dev`, `jpeg-dev`
- **better-sqlite3** - SQLite3 bindings requiring build tools and SQLite dev libraries
- **libpg-query** - PostgreSQL query parsing requiring PostgreSQL dev libraries
- **@swc/core** - Rust-based compiler requiring build tools

### Solution 1: Updated Dockerfile with System Dependencies

Use the provided `Dockerfile.fixed` which includes all necessary system dependencies:

```bash
# Build with the fixed Dockerfile
docker build -f Dockerfile.fixed -t ultrabase-studio .
```

### Solution 2: Multi-stage Build Optimization

The `Dockerfile.fixed` uses a multi-stage build to:
1. **Build stage**: Install all build dependencies and compile native modules
2. **Production stage**: Only include runtime dependencies, reducing final image size

### Solution 3: Alternative Alpine Dependencies

If you prefer to use a minimal approach, install only the essential packages:

```dockerfile
FROM node:22-alpine AS base

# Essential dependencies for native modules
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    libc6-compat \
    vips-dev \
    cairo-dev \
    pango-dev \
    jpeg-dev \
    sqlite-dev
```

### Solution 4: Use Debian-based Image (Alternative)

If Alpine continues to cause issues, switch to a Debian-based image:

```dockerfile
FROM node:22-slim AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libsqlite3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*
```

### Build Verification Steps

1. **Test locally first**:
   ```bash
   pnpm install --frozen-lockfile
   ```

2. **Build with no cache**:
   ```bash
   docker build --no-cache -f Dockerfile.fixed -t ultrabase-studio .
   ```

3. **Check for specific errors**:
   ```bash
   docker build --progress=plain -f Dockerfile.fixed . 2>&1 | tee build.log
   ```

### Common Error Messages and Solutions

| Error Message | Solution |
|---------------|----------|
| `g++: not found` | Install `g++` package |
| `python3: not found` | Install `python3` package |
| `vips/vips8: No such file` | Install `vips-dev` package |
| `cairo/cairo.h: No such file` | Install `cairo-dev` package |
| `pango/pango.h: No such file` | Install `pango-dev` package |
| `sqlite3.h: No such file` | Install `sqlite-dev` package |

### Performance Optimization Tips

1. **Use BuildKit** for better caching:
   ```bash
   DOCKER_BUILDKIT=1 docker build -f Dockerfile.fixed -t ultrabase-studio .
   ```

2. **Leverage layer caching** by ordering Dockerfile commands from least to most frequently changing

3. **Use .dockerignore** to exclude unnecessary files (already configured)

### Testing the Build

After applying the fix, test the build:

```bash
# Build the image
docker build -f Dockerfile.fixed -t ultrabase-studio .

# Run the container
docker run -p 3000:3000 ultrabase-studio

# Check health endpoint
curl http://localhost:3000/health
```

### Environment Variables

Ensure you have the required environment variables set:

```bash
# Create .env file if needed
cp .env.example .env
```

### Troubleshooting Commands

```bash
# Check what's in the image
docker run --rm -it ultrabase-studio sh

# Check installed packages
docker run --rm ultrabase-studio pnpm list

# Check system dependencies
docker run --rm ultrabase-studio apk list --installed

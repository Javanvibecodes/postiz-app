#!/bin/bash
set -o xtrace

echo "Entrypoint: Starting Postiz..."
echo "Render assigned port: $PORT"
echo "Node version: $(node -v)"
echo "PNPM version: $(pnpm -v)"
echo "Environment: $NODE_ENV"
echo "Backend URL: $NEXT_PUBLIC_BACKEND_URL"
echo "Entrypoint: Using Render-provided environment variables. Skipping .env copy."

# Run Prisma migrations
echo "Entrypoint: Running database migrations..."
pnpm run prisma-db-push

# Start frontend/backend
pnpm run --parallel pm2

# Keep container alive and log output
pm2 logs

#!/bin/bash
set -o xtrace

echo "Entrypoint: Starting Postiz..."
echo "Render assigned port: $PORT"
echo "Entrypoint: Using Render-provided environment variables. Skipping .env copy."

# Ensure the database is ready and run Prisma migrations
echo "Entrypoint: Running database migrations..."
pnpm run prisma-db-push

# Start services using PM2
pnpm run --parallel pm2

# Show PM2 logs (this keeps the container running and lets you see logs)
pm2 logs

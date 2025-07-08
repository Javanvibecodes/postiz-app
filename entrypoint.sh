#!/bin/bash

set -o xtrace

echo "Entrypoint: Starting Postiz..."

# Copy env config into the right place
if [[ "$SKIP_CONFIG_CHECK" != "true" ]]; then
  echo "Entrypoint: Copying /config/postiz.env into /app/.env"
  if [ ! -f /config/postiz.env ]; then
    echo "Entrypoint: WARNING: No postiz.env file found in /config/postiz.env"
  fi
  cp -vf /config/postiz.env /app/.env
fi

# Run DB migrations (Prisma)
echo "Entrypoint: Running database migrations"
pnpm run prisma-db-push

# Start all core apps via PM2
echo "Entrypoint: Starting backend, frontend, workers, cron with PM2..."
pnpm run pm2

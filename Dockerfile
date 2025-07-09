FROM node:20-bullseye

# Set working directory
WORKDIR /app

# Install system dependencies (bash, supervisor, netcat)
RUN apt-get update && apt-get install -y \
  bash \
  supervisor \
  netcat \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install pnpm and pm2 globally
RUN npm install -g pnpm@10.6.1 pm2

# Copy app source
COPY . .

# Make sure entrypoint script is executable
RUN chmod +x /app/entrypoint.sh

# Install node dependencies
RUN pnpm install --frozen-lockfile

# Build app
RUN pnpm run build

# Expose frontend and backend ports
EXPOSE $PORT


# Run entrypoint script
ENTRYPOINT ["bash", "/app/entrypoint.sh"]

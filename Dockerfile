# Use Node 20 base image
FROM node:20

# Set the working directory
WORKDIR /app

# Install system dependencies (bash, supervisor, etc.)
RUN apt-get update && apt-get install -y \
    bash \
    supervisor \
    netcat \
 && rm -rf /var/lib/apt/lists/*

# Install pnpm and pm2 globally
RUN npm install -g pnpm pm2

# Copy your app source code into the image
COPY . .

# Make sure entrypoint.sh is executable
RUN chmod +x /app/entrypoint.sh

# Install Node.js dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Build the project (frontend, backend, etc.)
RUN pnpm run build

# Expose necessary ports
EXPOSE 4200
EXPOSE 3000

# Start your app via the entrypoint script
ENTRYPOINT ["bash", "/app/entrypoint.sh"]

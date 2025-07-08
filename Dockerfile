FROM node:20

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y bash supervisor

# Install pnpm globally
RUN npm install -g pnpm pm2

# Copy everything
COPY . .

# Install node deps and build
RUN pnpm install --frozen-lockfile
RUN pnpm run build

# Expose ports (4200 is frontend, 3000 is backend)
EXPOSE 4200
EXPOSE 3000

# Use the main entrypoint script
ENTRYPOINT ["bash", "/app/entrypoint.sh"]

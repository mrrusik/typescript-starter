# Stage 1: Build the application
FROM node:22-alpine AS builder

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the TypeScript application
RUN npm run build

# Stage 2: Run the application
FROM node:22-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install production dependencies
RUN npm install --production

# Copy the built application from the builder stage
COPY --from=builder /usr/src/app/dist ./dist

# Expose port 3000 if your application listens on it
EXPOSE 3000

# Start the application
CMD ["node", "dist/main.js"]

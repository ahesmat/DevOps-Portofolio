# Use an official Node.js runtime as a parent image
# node:lts-alpine is a lightweight option for production
FROM node:22-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first for caching
COPY package*.json ./

# Install production dependencies
# --omit=dev is the modern equivalent for --only=production
RUN npm install --only=production

# Copy the rest of the application source code
COPY . .

# Expose the port the app runs on
EXPOSE 80

# Define the command to run your app
CMD ["npm", "start"]


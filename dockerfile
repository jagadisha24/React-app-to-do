# Step 1: Use an official Node image to build the React app
FROM node:18 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json 
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Use an official Nginx image to serve the built React app
FROM nginx:alpine

# Copy the build folder from the previous step into the Nginx container
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 so the app can be accessed
EXPOSE 80

# Command to run Nginx in the container
CMD ["nginx", "-g", "daemon off;"]

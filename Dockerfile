# Stage 1: Build the React app
# better set a version directly
FROM node:lts as builder
WORKDIR /app
COPY package.json ./
RUN npm install --force
COPY . .
RUN npm run build

# Stage 2: Create the production image
# testing version
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

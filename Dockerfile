# build-stage
FROM node:lts-alpine as build-stage
# RUN npm install -g http-server

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# EXPOSE 8080
# CMD ["http-server", "dist"]

# production-stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
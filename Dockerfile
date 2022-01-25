### Stage 1: build ###
FROM node:12.22.9-alpine as builder
RUN mkdir /app
WORKDIR /app
COPY angular-app/package.json angular-app/package-lock.json /app/angular-app/
RUN npm install --prefix angular-app
COPY . /app
RUN npm run build --prefix angular-app

### Stage 2: delivery ###
FROM nginx:1.15.7-alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/angular-app/dist /usr/share/nginx/html
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
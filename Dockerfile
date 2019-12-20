# Build environment
FROM node:alpine as builder

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/pacakge.json

RUN npm install --silent

COPY . /app

RUN npm run build

# Production environment
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# BUILD STAGE
FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm ci

COPY . .

RUN npm run build
# RUN STAGE

FROM nginx:1.31.3

# COPY nginx.conf /etc/nginx/conf.d/default.conf => if needed

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx","-g","daemon off;" ]


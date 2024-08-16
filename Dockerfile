FROM node:latest AS build
WORKDIR /app
COPY . .
RUN npm run build

FROM nginx:alpine AS final

COPY --from=build /app/.nginx/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

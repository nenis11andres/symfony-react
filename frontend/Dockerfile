# Fase 1: Build de React
FROM node:20 AS build

WORKDIR /app

# Copiamos dependencias
COPY package*.json ./
RUN npm install

# Copiamos todo el código de frontend
COPY . ./

# Construimos la app para producción
RUN npm run build

# Fase 2: Nginx sirve la build
FROM nginx:alpine

# Copiamos build de React
COPY --from=build /app/build /usr/share/nginx/html

# Copiamos default.conf desde la carpeta nginx (fuera de frontend)
COPY ../nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
# frontend/Dockerfile

# Imagen base con Node
FROM node:20

# Directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json primero
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código
COPY . .

# Exponer puerto de desarrollo
EXPOSE 3000

# Comando por defecto
CMD ["npm", "start"]

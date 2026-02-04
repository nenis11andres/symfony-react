#!/bin/bash
set -e

# Actualizar sistema
apt-get update -y
apt-get upgrade -y

# Instalar dependencias
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  git

# Instalar Docker
curl -fsSL https://get.docker.com | sh

# Habilitar Docker
systemctl enable docker
systemctl start docker

# Instalar Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# Añadir usuario admin a docker
usermod -aG docker admin || true

# Crear carpeta proyecto
mkdir -p /opt/symfony-react

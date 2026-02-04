#!/bin/bash
set -e

# -------------------------------
# 1️⃣ Actualizar sistema
# -------------------------------
apt-get update -y
apt-get upgrade -y

# -------------------------------
# 2️⃣ Instalar dependencias básicas
# -------------------------------
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  git \
  unzip

# -------------------------------
# 3️⃣ Instalar Docker
# -------------------------------
curl -fsSL https://get.docker.com | sh

# Habilitar Docker
systemctl enable docker
systemctl start docker

# -------------------------------
# 4️⃣ Instalar Docker Compose
# -------------------------------
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# -------------------------------
# 5️⃣ Añadir usuario admin al grupo docker
# -------------------------------
usermod -aG docker admin || true

# -------------------------------
# 6️⃣ Clonar el proyecto
# -------------------------------
PROJ_DIR="/opt/symfony-react"
GIT_REPO="https://github.com/nenis11andres/symfony-react.git"

# Crear carpeta del proyecto
mkdir -p $PROJ_DIR
cd $PROJ_DIR

# Clonar o actualizar repo
if [ -d ".git" ]; then
    git pull
else
    git clone $GIT_REPO . 
fi

# -------------------------------
# 7️⃣ Levantar Docker Compose
# -------------------------------
docker-compose up -d

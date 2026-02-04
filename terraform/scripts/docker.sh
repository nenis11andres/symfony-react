#!/bin/bash
set -e

LOG_FILE="/tmp/docker-setup.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "=== INICIANDO DOCKER SETUP ==="

# 1️⃣ Actualizar sistema
echo "[1] Actualizando sistema..."
apt-get update -y
apt-get upgrade -y

# 2️⃣ Instalar dependencias
echo "[2] Instalando dependencias..."
apt-get install -y ca-certificates curl gnupg lsb-release git unzip

# 3️⃣ Instalar Docker
echo "[3] Instalando Docker..."
curl -fsSL https://get.docker.com | sh
systemctl enable docker
systemctl start docker

# 4️⃣ Instalar Docker Compose
echo "[4] Instalando Docker Compose..."
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 5️⃣ Añadir admin al grupo docker
echo "[5] Añadiendo usuario admin al grupo docker..."
usermod -aG docker admin || true

# 6️⃣ Clonar proyecto
PROJ_DIR="/opt/symfony-react"
GIT_REPO="https://github.com/nenis11andres/symfony-react.git"

echo "[6] Preparando carpeta del proyecto..."
mkdir -p $PROJ_DIR
cd $PROJ_DIR

if [ -d ".git" ]; then
    echo "[6a] Actualizando repo existente..."
    git pull
else
    echo "[6b] Clonando repo desde GitHub..."
    git clone $GIT_REPO .
fi

# 7️⃣ Ajuste para React
echo "[7] Ajustando React para escuchar 0.0.0.0..."
sed -i 's/"start": "react-scripts start"/"start": "react-scripts start --host 0.0.0.0"/' frontend/package.json || true

# 8️⃣ Levantar Docker Compose
echo "[8] Levantando Docker Compose..."
docker-compose up -d || { echo "ERROR: Docker Compose falló"; exit 1; }

echo "=== DOCKER SETUP COMPLETADO ==="
echo "Revisar logs en $LOG_FILE"

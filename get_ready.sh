#!/bin/bash

# ====================================================
# Script de Preparación Inicial para Proyecto E-commerce
# Ubuntu 25.04 - WordPress + WooCommerce + Docker
# ====================================================

echo "🚀 Iniciando preparación de la máquina..."

# 1. Actualizar el sistema
echo "🔄 Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

# 2. Instalar paquetes básicos
echo "📦 Instalando herramientas necesarias..."
sudo apt install -y ca-certificates curl gnupg lsb-release ufw

# 3. Agregar repositorio oficial de Docker
echo "🐳 Instalando Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Instalar Docker y Docker Compose
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 5. Habilitar y arrancar el servicio Docker
echo "✅ Habilitando servicio Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# 6. Permitir usar Docker sin sudo
echo "👤 Configurando permisos para el usuario actual..."
sudo usermod -aG docker $USER

# 7. Configurar firewall básico
echo "🛡️ Configurando firewall básico con UFW..."
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

echo "✅ Firewall configurado (permitido SSH, HTTP, HTTPS)."

# 8. Crear estructura de carpetas para proyecto
echo "📁 Creando carpetas para el proyecto WordPress + WooCommerce..."
mkdir -p ~/proyectos/wordpress-ecommerce

echo "🚀 Preparación finalizada. Por favor, cierra sesión y vuelve a ingresar para aplicar los cambios de Docker."

# 9. Mensaje final
echo "🎯 Máquina lista para montar el e-commerce. ¡Vamos al siguiente paso!"

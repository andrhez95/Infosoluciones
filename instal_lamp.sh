#!/bin/bash

# Script de instalación de LAMP + VirtualHost + HTTPS + Seguridad para infosoluciones.com

# Paso 1 — Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Paso 2 — Instalar Apache
sudo apt install apache2 -y

# Paso 3 — Instalar MySQL
sudo apt install mysql-server -y
sudo mysql_secure_installation

# Paso 4 — Instalar PHP
sudo apt install php libapache2-mod-php php-mysql -y

# Paso 5 — Crear el directorio del sitio web
sudo mkdir /var/www/infosoluciones.com
sudo chown -R $USER:$USER /var/www/infosoluciones.com
sudo chmod -R 755 /var/www/infosoluciones.com

# Paso 6 — Crear el archivo de configuración del host virtual
sudo bash -c 'cat > /etc/apache2/sites-available/infosoluciones.com.conf <<EOF
<VirtualHost *:80>
    ServerAdmin soporte@infosoluciones.com
    ServerName infosoluciones.com
    ServerAlias www.infosoluciones.com
    DocumentRoot /var/www/infosoluciones.com

    <Directory /var/www/infosoluciones.com>
        Options -Indexes
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

# Paso 7 — Activar el nuevo sitio y desactivar el predeterminado
sudo a2ensite infosoluciones.com.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
sudo systemctl reload apache2

# Paso 8 — Crear archivo de prueba info.php
echo "<?php phpinfo(); ?>" | sudo tee /var/www/infosoluciones.com/info.php

# Paso 9 — Instalar Certbot y obtener certificado SSL
sudo apt install certbot python3-certbot-apache -y
sudo certbot --apache --non-interactive --agree-tos --redirect -m soporte@infosoluciones.com -d infosoluciones.com -d www.infosoluciones.com

# Paso 10 — Verificar renovación automática de Certbot
sudo systemctl list-timers | grep certbot


# Paso 12 — Mejorar configuración de Apache (ocultar versión)
sudo sed -i 's/^ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
sudo sed -i 's/^ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

# Paso 13 — Mejorar configuración de PHP
PHPINI=$(php -i | grep "Loaded Configuration File" | awk '{print $5}')
sudo sed -i 's/^expose_php = On/expose_php = Off/' $PHPINI
sudo sed -i 's/^display_errors = On/display_errors = Off/' $PHPINI
sudo sed -i 's/^;log_errors = On/log_errors = On/' $PHPINI

# Reiniciar Apache para aplicar cambios
sudo systemctl restart apache2

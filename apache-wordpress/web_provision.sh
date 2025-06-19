!/bin/bash

# Update package list
apt-get update

# Install Apache2 and PHP packages
apt-get install -y apache2 php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Enable Apache modules
a2enmod rewrite

# Configure Apache2 virtual host for WordPress
cat > /etc/apache2/sites-available/wordpress.conf <<EOF
<VirtualHost *:80>
    ServerName webserver
    DocumentRoot /var/www/wordpress
    <Directory /var/www/wordpress>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/wordpress_error.log
    CustomLog \${APACHE_LOG_DIR}/wordpress_access.log combined
</VirtualHost>
EOF

# Enable the virtual host
a2ensite wordpress
a2dissite 000-default

# Restart Apache
systemctl restart apache2

# Download and install WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress /var/www/
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Configure WordPress for MySQL connection
cat > /var/www/wordpress/wp-config.php <<EOF
<?php
define( 'DB_NAME', 'devopsdb' );
define( 'DB_USER', 'mydbuser' );
define( 'DB_PASSWORD', 'Demo@123' );
define( 'DB_HOST', '192.168.56.11' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
?>
EOF

# Set proper permissions for wp-config.php
chown www-data:www-data /var/www/wordpress/wp-config.php
chmod 640 /var/www/wordpress/wp-config.php

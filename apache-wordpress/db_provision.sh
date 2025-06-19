!/bin/bash

# Update package list
apt-get update

# Install MySQL server
apt-get install -y mysql-server

# Start MySQL service
systemctl start mysql
systemctl enable mysql

# Create database and user
mysql -u root <<EOF
CREATE DATABASE devopsdb;
CREATE USER 'mydbuser'@'%' IDENTIFIED BY 'Demo@123';
GRANT ALL PRIVILEGES ON devopsdb.* TO 'mydbuser'@'%';
FLUSH PRIVILEGES;
EOF

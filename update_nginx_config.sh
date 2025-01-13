#!/bin/bash

# Update packages
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Replace the default Nginx configuration with a custom one
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

}
EOL

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply the new configuration
sudo systemctl reload nginx

# Optional: Create a custom HTML page
echo "<h1>Welcome to Custom Nginx on $(hostname)</h1>" | sudo tee /var/www/html/index.html

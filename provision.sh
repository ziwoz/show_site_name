#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade -y



# Install necessary packages, including Python and pip
sudo apt-get install -y python3 python3-pip python3-venv nginx dos2unix
sudo unlink /etc/nginx/sites-enabled/default

python3 -m venv /var/www/myflaskappenv
# Activate the virtual environment
source /var/www/myflaskappenv/bin/activate


# Upgrade pip (Python package installer) inside the virtual environment
pip install --upgrade pip

# Install Flask and other necessary packages inside the virtual environment
pip install Flask gunicorn
sudo cp -r /var/www/master_src /var/www/src
pip install -r /var/www/src/requirements.txt

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart ssh


# Move the Gunicorn service file to the systemd service directory
# next move all the scripts to one directory and do this in style
sudo cp /var/www/gunicorn/gunicorn.service /etc/systemd/system/
sudo dos2unix /var/www/gunicorn/postscript.sh
sudo chmod +x /var/www/gunicorn/postscript.sh
sudo dos2unix /var/www/gunicorn/prescript.sh
sudo chmod +x /var/www/gunicorn/prescript.sh

# Start and enable Gunicorn service
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# Set up Nginx to proxy pass to Gunicorn
# Enable the Nginx server block configuration

sudo cp /var/www/nginx/nginx_config /etc/nginx/sites-available/myflaskapp
sudo ln -s /etc/nginx/sites-available/myflaskapp /etc/nginx/sites-enabled

# Test Nginx config
sudo nginx -t
sudo systemctl restart nginx

# Make the Nginx service start on boot
sudo systemctl enable nginx

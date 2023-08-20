#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install necessary packages, including Python and pip
sudo apt-get install -y python3 python3-pip python3-venv nginx

# Create a Python virtual environment
python3 -m venv /home/vagrant/myflaskappenv

# Activate the virtual environment
source /home/vagrant/myflaskappenv/bin/activate

# Upgrade pip (Python package installer) inside the virtual environment
pip install --upgrade pip

# Install Flask and other necessary packages inside the virtual environment
pip install Flask gunicorn

# Create a simple Flask application as an example
cat <<EOL > /home/vagrant/myflaskapp.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOL

# Configure Gunicorn to run the Flask application
cat <<EOL > /home/vagrant/gunicorn.service
[Unit]
Description=Gunicorn instance to serve myflaskapp
After=network.target

[Service]
User=vagrant
Group=vagrant
WorkingDirectory=/home/vagrant
Environment="PATH=/home/vagrant/myflaskappenv/bin"
ExecStart=/home/vagrant/myflaskappenv/bin/gunicorn --workers 3 --bind unix:myflaskapp.sock -m 007 myflaskapp:app

[Install]
WantedBy=multi-user.target
EOL

# Move the Gunicorn service file to the systemd service directory
sudo mv /home/vagrant/gunicorn.service /etc/systemd/system/

# Start and enable Gunicorn service
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

# Set up Nginx to proxy pass to Gunicorn
cat <<EOL | sudo tee /etc/nginx/sites-available/myflaskapp
server {
    listen 80;
    server_name _;

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/vagrant/myflaskapp.sock;
    }
}
EOL

# Enable the Nginx server block configuration
sudo ln -s /etc/nginx/sites-available/myflaskapp /etc/nginx/sites-enabled

# Test Nginx config
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx

# Make the Nginx service start on boot
sudo systemctl enable nginx

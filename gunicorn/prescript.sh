#!/bin/bash
sudo chown $(whoami):$(groups) /var/www/
echo "export FLASK_APP=/var/www/src/run.py" >> ~/.bashrc # move this to the gunicorn
# echo "export FLASK_APP=/var/www/src/myflaskapp.py" >> ~/.bashrc # move this to the gunicorn
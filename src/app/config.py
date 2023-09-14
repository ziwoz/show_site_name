import os
import platform


class Config:
    SECRET_KEY = os.urandom(24)
    SQLALCHEMY_DATABASE_URI = "sqlite:///site.db"
    if platform.system().lower() == 'linux':
        SQLALCHEMY_DATABASE_URI = "sqlite:////var/www/site.db"
        # move from this method to dynamic proper way. of having multiple config files and they load as per requirements based the vagrantfile


from flask import Flask
from .config import Config
from .extensions import db, login_manager
from .main import main as main_blueprint
from .user import user as user_blueprint


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    login_manager.init_app(app)

    app.register_blueprint(main_blueprint)
    app.register_blueprint(user_blueprint, url_prefix="/user")

    return app

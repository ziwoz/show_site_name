from flask import Flask
from .config import Config
from .extensions import db, login_manager
from .main import main_blueprint
from .user import user_blueprint, User


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    with app.app_context():
        db.create_all()  # move this somewhere else

    @login_manager.user_loader
    def load_user(user_id):
        return User.get(user_id)

    @login_manager.request_loader
    def load_user_from_request(request):
        api_key = request.headers.get("Authorization")
        return User.get_by_api_key(api_key)

    login_manager.init_app(app)

    app.register_blueprint(main_blueprint)
    app.register_blueprint(user_blueprint, url_prefix="/user")

    return app

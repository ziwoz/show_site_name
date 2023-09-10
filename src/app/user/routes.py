from flask import Blueprint

user_blueprint = Blueprint("user", __name__)


@user_blueprint.route("/login")
def login():
    return render_template("login.html")

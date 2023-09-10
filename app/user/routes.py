from flask import Blueprint

user = Blueprint("user", __name__)


@user.route("/login")
def login():
    return render_template("login.html")

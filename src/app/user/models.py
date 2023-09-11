from datetime import datetime
from app.extensions import db
from flask_login import UserMixin


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    api_key = db.Column(db.String(128))

    @classmethod
    def get_by_api_key(cls, api_key):
        return cls.query.filter_by(api_key=api_key).first()

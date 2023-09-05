import pytest
from app import create_app, db


@pytest.fixture(scope="module")
def test_app():
    app = create_app("test")
    app.config["TESTING"] = True

    with app.app_context():
        db.create_all()

    yield app

    with app.app_context():
        db.drop_all()

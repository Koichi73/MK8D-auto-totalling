from flask import Flask

def create_app():
    # appの設定
    app = Flask(__name__, instance_relative_config=True)

    return app
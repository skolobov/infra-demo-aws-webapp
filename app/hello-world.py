import logging
import os

from flask import Flask, jsonify

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize Flask app
app = Flask(__name__)

# Configuration
app_host = os.environ.get("APP_HOST", "0.0.0.0")
app_port = int(os.environ.get("APP_PORT", 8080))


@app.route("/")
def hello_world():
    return "Hallo Deutschland!"


@app.route("/health")
def health():
    return jsonify({"status": "healthy"})


if __name__ == "__main__":
    try:
        app.run(host=app_host, port=app_port)
    except Exception as e:
        logger.error(f"Error starting the server: {e}")
        raise

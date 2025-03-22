from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)

@app.route("/")
def home():
    return "✅ Flask agent is running!"

@app.route("/favicon.ico")
def favicon():
    return '', 204

@app.route("/run", methods=["POST"])
def run():
    command = request.json.get("command")
    if not command:
        return jsonify({"error": "No command provided"}), 400
    try:
        result = subprocess.run(
            ["powershell", "-Command", command],
            capture_output=True,
            text=True
        )
        output = result.stdout + result.stderr
        return jsonify({"output": output})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(port=5000)

import config
from flask import render_template
from trails import (read_all, read_one, create, update, delete, my_trails, add_locations)

app = config.connex_app
app.add_api("swagger.yml")

@app.route("/")
def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
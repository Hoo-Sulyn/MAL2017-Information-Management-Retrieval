import requests
from config import db
from models import Users 

AUTH_URL = "https://web.socem.plymouth.ac.uk/COMP2001/auth/api/users"

def authenticate_user(email, password):
    response = requests.post(AUTH_URL, json={"email": email, "password": password})
    if response.status_code != 200:
        return None

    data = response.json()

    if isinstance(data, list) and data[0] == "Verified" and data[1] == "True":
        user = db.session.query(Users).filter_by(user_email=email).first()
        if user:
            return {"id": user.user_id, "email": user.user_email, "name": user.user_name, "role": user.user_role}

    return None

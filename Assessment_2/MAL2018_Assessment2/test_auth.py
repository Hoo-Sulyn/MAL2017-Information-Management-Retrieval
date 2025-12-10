import requests

AUTH_URL = "https://web.socem.plymouth.ac.uk/COMP2001/auth/api/users"

def test_auth():
    response = requests.post(AUTH_URL, json={
        "email": "test@test.com", 
        "password": "test"
    })
    print("Status:", response.status_code)
    print("Response JSON:", response.text)

test_auth()

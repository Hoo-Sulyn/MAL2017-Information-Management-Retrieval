from flask import abort, make_response
from config import db
from models import (Trail, TrailLocation, trail_schema, trails_schema, location_schema, locations_schema)
from auth import authenticate_user
from connexion import request

def read_all():
    owner_email = request.headers.get("owner_email")
    password = request.headers.get("password")

    if not owner_email or not password:
        abort(401, "Missing authentication headers")

    user = authenticate_user(owner_email, password)

    trails = Trail.query.all()
    dumped = trails_schema.dump(trails)

    if user['role'] != 'Admin':
        for t in dumped:
            t.pop('User_ID', None)
            t.pop('Trail_ID', None)
            for loc in t.get('locations', []):
                loc.pop('Sequence', None)
                loc.pop('Location_ID', None)

    return dumped

def read_one(trail_id):
    owner_email = request.headers.get("owner_email")
    password = request.headers.get("password")

    if not owner_email or not password:
        abort(401, "Missing authentication headers")

    user = authenticate_user(owner_email, password)
    if not user:
        abort(401, "Invalid credentials")

    trail = Trail.query.get(trail_id)
    if not trail:
        abort(404, f"Trail {trail_id} not found")

    dumped = trail_schema.dump(trail)

    if user['role'] != 'Admin':
        if user['role'] != 'Admin':
            dumped.pop('User_ID', None)
            dumped.pop('Trail_ID', None)
            for loc in dumped.get('locations', []):
                loc.pop('Sequence', None)
                loc.pop('Location_ID', None)

    return dumped

def create(body):
    trail = body
    email = trail.get("owner_email")
    password = trail.get("password")
    user = authenticate_user(email, password)
    if not user or user['role'] != 'Admin':
        abort(401, "Admin access required")

    new_trail = Trail(
        Trail_Name=trail["Trail_Name"],
        Region=trail.get("Region"),
        Country=trail.get("Country"),
        City=trail.get("City"),
        Difficulty=trail.get("Difficulty"),
        Length_km=trail.get("Length_km"),
        Elevation_Gain_m=trail.get("Elevation_Gain_m"),
        Min_Estimated_Time_hr=trail.get("Min_Estimated_Time_hr"),
        Max_Estimated_Time_hr=trail.get("Max_Estimated_Time_hr"),
        Trail_Type=trail.get("Trail_Type"),
        Description=trail.get("Description"),
        User_ID=user['id']
    )
    db.session.add(new_trail)
    db.session.commit()
    return trail_schema.dump(new_trail), 201


def update(trail_id, body):
    owner_email = request.headers.get("owner_email")
    password = request.headers.get("password")

    if not owner_email or not password:
        abort(400, "Missing authentication headers")

    user = authenticate_user(owner_email, password)
    if not user or user['role'] != 'Admin':
        abort(401, "Admin access required")

    trail = Trail.query.get(trail_id)
    if not trail:
        abort(404, f"Trail {trail_id} not found")

    for key, value in body.items():
        if hasattr(trail, key) and key not in ("owner_email", "password"):
            setattr(trail, key, value)

    db.session.commit()
    return trail_schema.dump(trail), 200


def delete(trail_id):
    owner_email = request.headers.get("owner_email")
    password = request.headers.get("password")

    if not owner_email or not password:
        abort(400, "Missing authentication headers")

    user = authenticate_user(owner_email, password)
    if not user or user['role'] != 'Admin':
        abort(401, "Admin access required")

    trail = Trail.query.get(trail_id)
    if not trail:
        abort(404, f"Trail {trail_id} not found")

    db.session.delete(trail)
    db.session.commit()
    return "", 204

def my_trails():
    """GET /trails/my_trail"""
    owner_email = request.headers.get("owner_email")
    password  = request.headers.get("password")

    if not owner_email or not password:
        abort(400, "Missing authentication headers")

    user = authenticate_user(owner_email, password)
    if not user or user['role'] != 'Admin':
        abort(401, "Admin access required")

    trails = Trail.query.filter_by(User_ID=user['id']).all()
    return trails_schema.dump(trails), 200


def add_locations(trail_id, body):
    owner_email = request.headers.get("owner_email")
    password = request.headers.get("password")

    if not owner_email or not password:
        abort(401, "Missing authentication headers")

    user = authenticate_user(owner_email, password)
    if not user or user['role'] != 'Admin':
        abort(401, "Admin access required")

    trail = Trail.query.get(trail_id)
    if not trail:
        abort(404, f"Trail {trail_id} not found")

    # Add location points
    for loc in body:
        new_point = TrailLocation(
            Trail_ID=trail_id,
            Latitude=loc["Latitude"],
            Longitude=loc["Longitude"],
            Sequence=loc["Sequence"]
        )
        db.session.add(new_point)

    db.session.commit()
    return {"message": "Location points added successfully"}, 200

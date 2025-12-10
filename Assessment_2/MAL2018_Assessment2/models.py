from datetime import datetime
from config import db, ma

class Trail(db.Model):
    __tablename__ = 'Trail'
    __table_args__ = {'schema': 'CW2', 'implicit_returning':False}
    Trail_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Trail_Name = db.Column(db.String(100), nullable=False)
    Region = db.Column(db.String(50))
    Country = db.Column(db.String(50))
    City = db.Column(db.String(50))
    Difficulty = db.Column(db.String(20))
    Length_km = db.Column(db.Numeric(5, 2))
    Elevation_Gain_m = db.Column(db.Integer)
    Min_Estimated_Time_hr = db.Column(db.Numeric(5, 1))
    Max_Estimated_Time_hr = db.Column(db.Numeric(5, 1))
    Trail_Type = db.Column(db.String(20))
    Description = db.Column(db.Text)
    User_ID = db.Column(db.Integer, nullable=False)

    locations = db.relationship(
        "TrailLocation",
        backref="trail",
        cascade="all, delete-orphan",
        passive_deletes=True
    )


class TrailLocation(db.Model):
    __tablename__ = "Trail_Location"
    __table_args__ = {'schema': 'CW2'}

    Location_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Trail_ID = db.Column(db.Integer, db.ForeignKey("CW2.Trail.Trail_ID", ondelete="CASCADE"), nullable=False)
    Latitude = db.Column(db.Float, nullable=False)
    Longitude = db.Column(db.Float, nullable=False)
    Sequence = db.Column(db.Integer, nullable=False)


class TrailLocationSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = TrailLocation
        load_instance = True
        sqla_session = db.session

class TrailSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Trail
        load_instance = True
        sqla_session = db.session

    locations = ma.Nested(TrailLocationSchema, many=True)


class Users(db.Model):
    __tablename__ = 'Users'
    __table_args__ = {'schema': 'CW2'}
    
    user_id = db.Column(db.Integer, primary_key=True)
    user_email = db.Column(db.String(100), unique=True, nullable=False)
    user_name = db.Column(db.String(50))
    user_role = db.Column(db.String(20), nullable=False, server_default='user')


trail_schema     = TrailSchema()
trails_schema    = TrailSchema(many=True)
location_schema  = TrailLocationSchema()
locations_schema = TrailLocationSchema(many=True)
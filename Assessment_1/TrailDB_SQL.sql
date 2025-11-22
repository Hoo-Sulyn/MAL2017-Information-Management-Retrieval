/*CREATE NEW DATABASE */
GO
CREATE DATABASE TrailDB;
GO
USE TrailDB;
GO

/*CREATE SCHEMA*/
CREATE SCHEMA CW1;
GO

/*ADDING TABLES*/
CREATE TABLE CW1.Users(
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    user_password VARCHAR(20) NOT NULL
);

CREATE TABLE CW1.Trail (
    trail_id INT PRIMARY KEY,
    trail_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    difficulty VARCHAR(20) NOT NULL,
    length_km DECIMAL(5,2) NOT NULL,
    elevation_gain_m INT NOT NULL,
    min_estimated_time_hr DECIMAL(5,1) NOT NULL,
    max_estimated_time_hr DECIMAL(5,1) NOT NULL,
    trail_type VARCHAR(20) NOT NULL,
    description NVARCHAR(1000) NULL,
    user_id INT NOT NULL REFERENCES CW1.Users(user_id)
);

CREATE TABLE CW1.Trail_Location(
    location_id INT PRIMARY KEY,
    trail_id INT NOT NULL REFERENCES CW1.Trail(trail_id),
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    sequence INT NOT NULL
);

CREATE TABLE CW1.Info (
    info_id INT PRIMARY KEY,
    info_name VARCHAR(50) NOT NULL
);

CREATE TABLE CW1.Trail_Info (
    trail_id INT NOT NULL,
    info_id INT NOT NULL,

    CONSTRAINT pk_trailInfo PRIMARY KEY (trail_id, info_id),

    CONSTRAINT fk_trailInfo_trail FOREIGN KEY (trail_id) REFERENCES CW1.Trail(trail_id),
    CONSTRAINT fk_trailInfo_info FOREIGN KEY (info_id) REFERENCES CW1.Info(info_id)
);

CREATE TABLE CW1.Features(
    features_id INT PRIMARY KEY,
    features_name VARCHAR(50) NOT NULL
);

CREATE TABLE CW1.Trail_Features(
    trail_id INT NOT NULL,
    features_id INT NOT NULL,

    CONSTRAINT pk_trailFeatures PRIMARY KEY (trail_id, features_id),

    CONSTRAINT fk_trailFeatures_trail FOREIGN KEY (trail_id) REFERENCES CW1.Trail(trail_id),
    CONSTRAINT fk_trailFeatures_features FOREIGN KEY (features_id) REFERENCES CW1.Features(features_id)

);

CREATE TABLE CW1.TopSight(
    topSight_id INT PRIMARY KEY,
    topSight_name VARCHAR(50) NOT NULL
);

CREATE TABLE CW1.Trail_TopSight(
    trail_id INT NOT NULL,
    topSight_id INT NOT NULL,

    CONSTRAINT pk_trailTopSight PRIMARY KEY (trail_id, topSight_id),

    CONSTRAINT fk_trailTopSight_trail FOREIGN KEY (trail_id) REFERENCES CW1.Trail(trail_id),
    CONSTRAINT fk_trailTopSight_topSight FOREIGN KEY (topSight_id) REFERENCES CW1.TopSight(topSight_id)
);


/*ADDING DATA INTO TABLES*/
INSERT INTO CW1.Users (user_id, user_name, user_email, user_password)
VALUES 
    (1, 'Ada Lovelace', 'grace@plymouth.ac.uk', 'ISAD123!'),
    (2, 'Tim Berners-Lee', 'tim@plymouth.ac.uk', 'COMP2001!'),
    (3, 'Ada Lovelace', 'ada@plymouth.ac.uk', 'insecurePassword');

INSERT INTO CW1.Trail (trail_id, trail_name, region, country, city, difficulty, length_km, elevation_gain_m, min_estimated_time_hr, max_estimated_time_hr, trail_type, [description], user_id)
VALUES
    (1, 'Plymbridge Circular', 'Devon', 'England', 'Plymouth', 'Easy', 5.0, 147, 1.5, 2.0, 'Loop', 'This is a gentle circular walk through ancient oak woodlands, beside the beautiful River Plym.', 1),
    (2, 'Plymouth Waterfront', 'Devon', 'England', 'Plymouth', 'Easy', 5.0, 147, 1.5, 2.0, 'Loop', 'Enjoy a fantastic walk along Plymouth’s waterfront, taking in some of the city’s most famous sights.', 2),
    (3, 'Plymouth Hoe Circular', 'Devon', 'England', 'Plymouth', 'Easy', 4.8, 83, 1.0, 1.5, 'Loop', 'Enjoy a fantastic walk along Plymouth’s waterfront, taking in some of the city’s most famous sights.', 3);

INSERT INTO CW1.Trail_Location (location_id, trail_id, latitude, longitude, sequence)
VALUES
    (1, 1, 50.40886, -4.07859, 1),
    (2, 1, 50.40886, -4.07859, 2),
    (3, 1, 50.40886, -4.07859, 3),
    (4, 2, 50.36891, -4.13415, 1),
    (5, 2, 50.36891, -4.13415, 2),
    (6, 2, 50.36891, -4.13415, 3);

INSERT INTO CW1.Info (info_id, info_name)
VALUES
    (1, 'Dog-friendly'),
    (2, 'Kid-friendly'),
    (3, 'Partially paved'),
    (4, 'Paved');

INSERT INTO CW1.Trail_Info (trail_id, info_id)
VALUES
    (1,1),(1,2),(1,3),(2,3),(2,4);
    
INSERT INTO CW1.Features (features_id, features_name)
VALUES 
    (1, 'Caves'),
    (2, 'Forests'),
    (3, 'Rivers'),
    (4, 'Views'),
    (5, 'Wildlife'),
    (6, 'Rail trails'),
    (7, 'Beaches'),
    (8, 'Historic sites'),
    (9, 'City walks'),
    (10, 'Pub walks');

INSERT INTO CW1.Trail_Features (trail_id, features_id)
VALUES 
    (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(2,7),(2,3),(2,4),(2,8),(2,9),(2,10),(3,7),(3,3),(3,4),(3,8),(3,9),(3,10);

INSERT INTO CW1.TopSight (topSight_id, topSight_name)
VALUES
    (1, 'River Plym'),
    (2, 'Offers Quaters & Mess'),
    (3, 'Great Store'),
    (4, 'The Mayflower Steps');

INSERT INTO CW1.Trail_TopSight (trail_id, topSight_id)
VALUES 
    (1,1),(2,2),(2,3),(2,4),(3,2),(3,3),(3,4);


/*SELECT STATEMENTS*/
SELECT * FROM CW1.Users;

SELECT * FROM CW1.Trail;

SELECT * FROM CW1.Trail_Location;

SELECT * FROM CW1.Info;

SELECT * FROM CW1.Trail_Info;

SELECT * FROM CW1.Features;

SELECT * FROM CW1.Trail_Features;

SELECT * FROM CW1.TopSight;

SELECT * FROM CW1.Trail_TopSight;


/*RELATIONSHIP DEMO*/
SELECT t.trail_name, i.info_name
FROM CW1. Trail t
JOIN CW1.Trail_Info ti on t.trail_id = ti.trail_id
JOIN CW1.Info i ON i.info_id = ti.info_id;

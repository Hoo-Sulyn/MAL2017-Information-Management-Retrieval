USE TrailDB;
GO

-- CREATE CW2 SCHEMA
CREATE SCHEMA CW2;
GO

-- CREATE TABLES

CREATE TABLE CW2.Users(
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    user_password VARCHAR(20) NOT NULL,
    user_role VARCHAR(20) NOT NULL
);

CREATE TABLE CW2.Trail (
    trail_id INT IDENTITY(1,1) PRIMARY KEY,
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
    user_id INT NOT NULL REFERENCES CW2.Users(user_id)
);

CREATE TABLE CW2.Trail_Location(
    location_id INT IDENTITY(1,1) PRIMARY KEY,
    trail_id INT NOT NULL REFERENCES CW2.Trail(trail_id),
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    sequence INT NOT NULL

    CONSTRAINT fk_location_trail FOREIGN KEY (trail_id) REFERENCES CW2.Trail(trail_id) ON DELETE CASCADE
);


CREATE TABLE CW2.Trail_Log(
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    trail_id INT NOT NULL,
    user_id INT NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_traillog_user FOREIGN KEY (user_id) REFERENCES CW2.Users(user_id),
    CONSTRAINT fk_traillog_trail FOREIGN KEY (trail_id) REFERENCES CW2.Trail(trail_id) ON DELETE CASCADE
);

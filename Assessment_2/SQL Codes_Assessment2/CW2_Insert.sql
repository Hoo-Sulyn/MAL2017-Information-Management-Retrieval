USE TrailDB;
GO

-- INSERT INTO TABLES

INSERT INTO CW2.Users (user_id, user_name, user_email, user_password, user_role)
VALUES 
    (1, 'Ada Lovelace', 'grace@plymouth.ac.uk', 'ISAD123!', 'Admin'),
    (2, 'Tim Berners-Lee', 'tim@plymouth.ac.uk', 'COMP2001!', 'User'),
    (3, 'Ada Lovelace', 'ada@plymouth.ac.uk', 'insecurePassword', 'User');

SELECT * FROM CW2.Users;


-- INSERT INTO CW2.Trail (trail_name, region, country, city, difficulty, length_km, elevation_gain_m, min_estimated_time_hr, max_estimated_time_hr, trail_type, [description], user_id)
-- VALUES
--     ('Plymbridge Circular', 'Devon', 'England', 'Plymouth', 'Easy', 5.0, 147, 1.5, 2.0, 'Loop', 'This is a gentle circular walk through ancient oak woodlands, beside the beautiful River Plym.', 1),
--     ('Plymouth Waterfront', 'Devon', 'England', 'Plymouth', 'Easy', 5.0, 147, 1.5, 2.0, 'Loop', 'Enjoy a fantastic walk along Plymouth’s waterfront, taking in some of the city’s most famous sights.', 2),
--     ('Plymouth Hoe Circular', 'Devon', 'England', 'Plymouth', 'Easy', 4.8, 83, 1.0, 1.5, 'Loop', 'Enjoy a fantastic walk along Plymouth’s waterfront, taking in some of the city’s most famous sights.', 3);

SELECT * FROM CW2.Trail;

    
SELECT * FROM CW2.Trail_Location;

/*TRIGGER TESTING*/

SELECT * FROM CW1.Trail_Log;

/* INSERT NEW TRAIL*/
INSERT INTO CW1.Trail(trail_id, trail_name, region, country, city, difficulty, length_km, 
                        elevation_gain_m, min_estimated_time_hr, max_estimated_time_hr, 
                        trail_type, [description], user_id)
VALUES
    (99, 'Trigger test', 'Devon', 'England', 'Plymouth', 'Easy', 3.0, 100, 1.0, 1.5, 'Loop', 'Testing trigger...', 1);
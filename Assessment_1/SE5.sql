CREATE VIEW CW1.vTrailDetails
AS
SELECT 
    t.trail_id,
    t.trail_name,
    t.city,
    t.country,
    t.difficulty,
    t.length_km,
    t.trail_type,
    u.user_name AS created_by
FROM CW1.Trail t
JOIN CW1.Users u ON t.user_id = u.user_id;
GO

SELECT * FROM CW1.vTrailDetails;
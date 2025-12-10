USE TrailDB;
GO

-- CREATE TRIGGER

CREATE TRIGGER CW2.Trail_Insert
ON CW2.Trail
AFTER INSERT
AS
BEGIN
    INSERT INTO CW2.Trail_Log (trail_id, user_id, user_name)
    SELECT i.trail_id, i.user_id, u.user_name
    FROM inserted i
    JOIN CW2.Users u ON i.user_id = u.user_id;
END;
GO


-- TESTING
SELECT * FROM CW2.Trail_Log;
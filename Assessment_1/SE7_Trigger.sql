CREATE TRIGGER CW1.Trail_Insert ON CW1.Trail AFTER INSERT
AS BEGIN
    INSERT INTO CW1.Trail_Log(trail_id, user_name)
    SELECT trail_id, user_name
    FROM inserted i
    JOIN CW1.Users u ON i.user_id = u.user_id;
END;
GO
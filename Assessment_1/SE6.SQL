/* SET EXERCISE 6 */

/*INSERT*/
CREATE PROCEDURE CW1.InsertInfo
    @info_id INT, @info_name VARCHAR(50)
AS BEGIN 
    INSERT INTO CW1.Info (info_id, info_name)
    VALUES (@info_id, @info_name);
END;
GO


/*READ*/
CREATE PROCEDURE CW1.GetAllInfo
AS BEGIN   
    SELECT * FROM CW1.Info;
END;
GO


/*UPDATE*/
CREATE PROCEDURE CW1.UpdateInfo
    @info_id INT, @info_name VARCHAR(50)
AS BEGIN
    UPDATE CW1.Info
    SET info_name = @info_name
    WHERE info_id = @info_id;
END;
GO


/*DELETE*/
CREATE PROCEDURE CW1.DeleteInfo
    @info_id INT
AS BEGIN
    DELETE FROM CW1.Info
    WHERE info_id = @info_id;
END;
GO


/*TESTING AREA*/
SELECT * FROM CW1.Info;

EXEC CW1.InsertInfo 5, 'Steep trail'; --INSERT

EXEC CW1.GetAllInfo; --READ

EXEC CW1.UpdateInfo 5, 'Short trail'; --UPDATE

EXEC CW1.DeleteInfo 5; --DELETE
CREATE PROCEDURE spGetContactRole
(
@ContactID INT,
@Rolename NVARCHAR(50),
@RETURN_VALUE INT
)
AS
BEGIN
    If (EXISTS(SELECT Rolename FROM dbo.Contacts WHERE ContactID = @ContactID))	
		SET @RETURN_VALUE = 1
    ELSE
        SET @RETURN_VALUE = 0
END
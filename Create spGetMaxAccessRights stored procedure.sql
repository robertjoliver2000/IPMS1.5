CREATE PROCEDURE spGetMaxAccessRights
(
@ContactID INT,
@MaxPermission NVARCHAR(50),
@RETURN_VALUE INT
)
AS
BEGIN
    If (EXISTS(SELECT MaxPermission FROM dbo.Contacts WHERE ContactID = @ContactID))	
		SET @RETURN_VALUE = 1
    ELSE
        SET @RETURN_VALUE = 0
END
ALTER PROCEDURE spGetMaxAccessRights
(
@ContactID INT,
@MaxPermission NVARCHAR(50) OUTPUT
)
AS
BEGIN
    SELECT @maxPermission=MaxPermission FROM dbo.Contacts WHERE ContactID = @ContactID
END
ALTER PROCEDURE spGetContactRole
(
@ContactID INT,
@Rolename NVARCHAR(50) OUTPUT
)
AS
BEGIN
   SELECT @Rolename=Rolename FROM dbo.Contacts WHERE ContactID=@ContactID
END
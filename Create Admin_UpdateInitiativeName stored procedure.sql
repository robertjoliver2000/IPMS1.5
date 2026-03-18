CREATE PROCEDURE Admin_UpdateInitiativeName
(
@Name NVARCHAR(100),
@InitiativeID INT,
@AllVersions BIT
)
AS
BEGIN
   UPDATE dbo.Initiative
   SET Name=@Name
   WHERE InitiativeID = @InitiativeID
END
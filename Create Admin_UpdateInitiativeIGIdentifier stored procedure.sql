CREATE PROCEDURE Admin_UpdateInitiativeIGIdentifier
(
@IGIdentifier NVARCHAR(50),
@InitiativeID INT
)
AS
BEGIN
   UPDATE dbo.Initiative
   SET IGIdentifier=@IGIdentifier
   WHERE InitiativeID = @InitiativeID
END
CREATE PROCEDURE Admin_UpdateInitiativePrimarySBU
(
@PrimarySBU NVARCHAR(50),
@InitiativeID INT,
@PrimarySBUID INT,
@AllVersions BIT
)
AS
BEGIN
   UPDATE dbo.Initiative
   SET PrimarySBUID=@PrimarySBUID
   WHERE InitiativeID = @InitiativeID
END
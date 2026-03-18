CREATE PROCEDURE Initiative_GetInitiativeValue
(
@InitiativeID INT
)
AS
BEGIN
    SELECT * FROM dbo.Initiative WHERE InitiativeID = @InitiativeID
END
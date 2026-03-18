CREATE PROCEDURE spGetNextVersionInitiativeID
@InitiativeID INT
AS
SELECT IGVersionNumber FROM Initiative WHERE InitiativeID=@InitiativeID AND IGVersionNumber>1

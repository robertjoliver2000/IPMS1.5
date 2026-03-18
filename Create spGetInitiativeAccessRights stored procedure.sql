CREATE PROCEDURE spGetInitiativeAccessRights
@ContactID INT,
@InitiativeID INT,
@MaxPermission NVARCHAR(50) OUTPUT
AS
BEGIN
(
    SELECT MaxPermission FROM dbo.Contacts 
	INNER JOIN Initiative ON dbo.Initiative.ActiveUserID=dbo.Contacts.ContactID AND InitiativeID=@InitiativeID
	WHERE ContactID = @ContactID
)	
END
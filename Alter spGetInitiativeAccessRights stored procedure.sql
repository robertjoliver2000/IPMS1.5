ALTER PROCEDURE spGetInitiativeAccessRights
(
@ContactID INT,
@InitiativeID INT,
@MaxPermission VARCHAR(50) OUTPUT
)
AS
BEGIN
    SELECT @Maxpermission = MaxPermission FROM Contacts
	INNER JOIN Initiative ON Contacts.ContactID=Initiative.ActiveUserID AND Initiative.InitiativeID=@InitiativeID
	WHERE ContactID = @ContactID
END
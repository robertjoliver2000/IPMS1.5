CREATE PROCEDURE spGetReferenceTableChildren
@CategoryID INT,
@ParentReferenceID INT,
@CurrentReferenceID INT
AS
BEGIN
SELECT * FROM Reference WHERE CategoryID=@CategoryID AND ReferenceID=@CurrentReferenceID AND ParentReferenceID=@ParentReferenceID
END
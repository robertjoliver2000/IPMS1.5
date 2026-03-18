CREATE PROCEDURE spGetReferenceTableParents
@CategoryID INT,
@CurrentReferenceID INT
AS
BEGIN
SELECT * FROM Reference WHERE CategoryID=@CategoryID AND ReferenceID=@CurrentReferenceID
END
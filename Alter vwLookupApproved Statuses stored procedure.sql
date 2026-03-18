ALTER PROCEDURE vwLookupApprovedStatuses

AS
BEGIN
	DECLARE @approved Int = 4
    SELECT ReferenceID FROM Reference WHERE CategoryID=3 AND referenceID >= @approved
END
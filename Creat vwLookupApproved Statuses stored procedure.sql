CREATE PROCEDURE vwLookupApprovedStatuses
@approved Int = 4
AS
BEGIN
    SELECT ReferenceID FROM Reference WHERE CategoryID=3 AND referenceID >= @approved
END
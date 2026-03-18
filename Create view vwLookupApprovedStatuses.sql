CREATE VIEW [dbo].[vwLookupApprovedStatuses]
	AS SELECT ReferenceID FROM [Reference] WHERE CategoryID=3 AND ReferenceID>=4

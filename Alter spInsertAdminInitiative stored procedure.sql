ALTER PROCEDURE spInsertAdminInitiative
(
@Name NVARCHAR(100),
@IGBusinessAreaCode NVARCHAR(10),
@IGIdentifierCode NVARCHAR(10),
@IGApprovalCommittee NVARCHAR(50),
@SubmissionDate DATETIME,
@SecurityID INT,
@IGApprovalStatus NVARCHAR(50),
@IGApprovalID INT
)
AS
BEGIN
	DECLARE @ExternalUniqueIdentifier UNIQUEIDENTIFIER
	SET @ExternalUniqueIdentifier = NEWID()
	DECLARE @InitiativeID INT
	SELECT @InitiativeID = COUNT(InitiativeID)+1 FROM dbo.Initiative
	INSERT INTO dbo.Initiative (ExternalUniqueIdentifier,InitiativeID,Name,IGBusinessAreaCode,IGIdentifierCode,IGApprovalCommittee,SubmissionDate,SecurityID,IGApprovalStatus,IGApprovalStatusID)
	VALUES (@ExternalUniqueIdentifier,@InitiativeID,@Name,@IGBusinessAreaCode,@IGIdentifierCode,@IGApprovalCommittee,@SubmissionDate,@SecurityID,@IGApprovalStatus,@IGApprovalID)
END
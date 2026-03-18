CREATE PROCEDURE spInsertAdminInitiative
(
@IGBusinessAreaCode NVARCHAR(10),
@IGIdentifierCode NVARCHAR(10),
@Name NVARCHAR(100),
@IGApprovalCommittee NVARCHAR(50),
@SubmissionDate DATETIME,
@SecurityID INT,
@IGApprovalStatus NVARCHAR(50),
@IGApprovalStatusID INT
)
AS
BEGIN
	INSERT INTO dbo.Initiative (IGBusinessAreaCode,IGIdentifierCode,Name,IGApprovalCommittee,SubmissionDate,SecurityID,IGApprovalStatus,IGApprovalStatusID)
	VALUES (@IGBusinessAreaCode,@IGIdentifierCode,@Name,@IGApprovalCommittee,@SubmissionDate,@SecurityID,@IGApprovalStatus,@IGApprovalStatusID)
END
ALTER PROCEDURE GetAdminInitiatives
(
@InitiativeID INT,
@SubmissionYear NVARCHAR(4),
@SelectTop INT
)
AS
BEGIN
    SELECT * FROM dbo.Initiative
END
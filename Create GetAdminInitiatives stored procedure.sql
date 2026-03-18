CREATE PROCEDURE GetAdminInitiatives
(
@InitiativeID INT,
@SubmissionYear NVARCHAR(4),
@SelectTop NVARCHAR(50),
@RETURN_VALUE INT
)
AS
BEGIN
    SELECT * FROM dbo.Initiative WHERE InitiativeID = @InitiativeID
END
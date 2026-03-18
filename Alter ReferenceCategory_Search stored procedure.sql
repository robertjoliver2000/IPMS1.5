ALTER PROCEDURE ReferenceCategory_Search
(
@CategoryID INT OUTPUT,
@Description NVARCHAR(75) OUTPUT,
@IsEditable BIT OUTPUT
)
AS
BEGIN
    SELECT CategoryID,Description,IsEditable FROM dbo.ReferenceCategory WHERE IsEditable=1
END
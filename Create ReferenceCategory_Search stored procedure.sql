CREATE PROCEDURE ReferenceCategory_Search
(
@CategoryID INT OUTPUT,
@Description NVARCHAR(75) OUTPUT,
@IsEditable BIT OUTPUT
)
AS
BEGIN
    SELECT CategoryID=@CategoryID,Description=@Description,IsEditable=@IsEditable FROM dbo.ReferenceCategory WHERE IsEditable=1
END
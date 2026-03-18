CREATE PROCEDURE Initiative_GetInitiativePeriods
@InitiativeID INT
AS
BEGIN
 SELECT Period.* FROM Period WHERE PeriodID IN (SELECT Period.PeriodID FROM Period
 INNER JOIN InitiativeValue ON Period.PeriodID = InitiativeValue.PeriodID
 INNER JOIN InitiativeFinancial ON InitiativeValue.ReferenceID = InitiativeFinancial.InitiativeFinancialID
 WHERE InitiativeFinancial.InitiativeID = @InitiativeID
 GROUP BY Period.PeriodID)
 ORDER BY Right(Period.Name,4)
END
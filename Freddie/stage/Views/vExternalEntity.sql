CREATE VIEW [stage].[vExternalEntity]
AS 
SELECT DISTINCT SellerName as EntityName
FROM stage.LoanOrigination
UNION
SELECT DISTINCT ServicerName
FROM stage.LoanOrigination

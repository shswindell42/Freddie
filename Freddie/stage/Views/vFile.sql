CREATE VIEW [stage].[vFile]
AS
SELECT DISTINCT s.[FileName]
FROM stage.LoanOrigination s
UNION 
SELECT DISTINCT FileName
FROM stage.LoanService
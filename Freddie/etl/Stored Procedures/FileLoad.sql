CREATE PROCEDURE [etl].[FileLoad]
AS


INSERT INTO dim.[File]
(
	FileName
	,CreatedDate
)
SELECT DISTINCT s.[FileName], GETDATE()
FROM stage.LoanOrigination s
	LEFT OUTER JOIN dim.[File] d
		on s.FileName = d.filename
WHERE d.FileKey is null
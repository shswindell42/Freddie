CREATE PROCEDURE [etl].[FileLoad]
AS


INSERT INTO dim.[File]
(
	FileName
	,CreatedDate
)
SELECT s.[FileName], GETDATE()
FROM stage.vFile s
	LEFT OUTER JOIN dim.[File] d
		on s.FileName = d.filename
WHERE d.FileKey is null
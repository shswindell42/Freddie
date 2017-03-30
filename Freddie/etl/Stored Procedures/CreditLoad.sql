CREATE PROCEDURE [etl].[CreditLoad]
AS

IF NOT EXISTS (SELECT CreditKey FROM dim.Credit WHERE CreditKey < 0)
BEGIN

	SET IDENTITY_INSERT dim.Credit ON;

	INSERT INTO dim.Credit
	(
		CreditKey
		,CreditScore
		,CreditCategory
		,CreatedDate
	)
	VALUES
	(-1, -1, 'Unknown', GETDATE())

	SET IDENTITY_INSERT dim.Credit OFF;

END


INSERT INTO dim.Credit
(
	CreditScore
	,CreditCategory
	,CreatedDate
)
SELECT s.CreditScore	
	,s.CreditCategory
	,GETDATE()
FROM stage.vCredit s
	LEFT OUTER JOIN dim.Credit d
		ON s.CreditScore = d.CreditScore
WHERE d.CreditKey is null
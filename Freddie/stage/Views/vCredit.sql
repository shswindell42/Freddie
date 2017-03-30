CREATE VIEW [stage].[vCredit]
AS
SELECT DISTINCT CreditScore = ISNULL(CreditScore, 0)
	,CreditCategory = CASE WHEN CreditScore >= 750 THEN 'Excellent'
						WHEN CreditScore BETWEEN 700 AND 749 THEN 'Good'
						WHEN CreditScore BETWEEN 650 AND 699 THEN 'Fair'
						WHEN CreditScore BETWEEN 550 AND 649 THEN 'Poor'
						WHEN CreditScore = 0 THEN 'No Credit'
						WHEN CreditScore < 550 THEN 'Bad'
						ELSE 'Unknown'
					END
FROM stage.LoanOrigination

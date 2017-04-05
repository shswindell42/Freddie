CREATE VIEW [stage].[vLoanServiceStatus]
AS
SELECT DISTINCT DelinquencyStatus
	,DelinquencyStatusDesc = CASE DelinquencyStatus
								WHEN 'XX' THEN 'Unknown'
								WHEN '0' THEN 'Current'
								WHEN '1' THEN '30-59 days delinquent'
								WHEN '2' THEN '60-89 days delinquent'
								WHEN '3' THEN '90-119 days delinquent'
								WHEN 'R' THEN 'REO Acquistion'
								WHEN '   ' THEN 'Unavailable'
								ELSE IIF(TRY_CAST(DelinquencyStatus as int) is not null, 
											CONCAT(CAST(DelinquencyStatus as int) * 30,
												 '-', 
												 ((CAST(DelinquencyStatus as int) + 1) * 30) - 1, 
												 ' days delinquent'),
											'Unknown')
							END
	,DelinquentLoan = CASE WHEN ZeroBalanceCode IN ('03', '09') THEN 'Delinquent'
						ELSE 'Not Delinquent'
					END
	,RepurchaseFlag
	,RepurchaseDesc = CASE RepurchaseFlag 
							WHEN 'N' THEN 'Not Repurchased'
							WHEN 'Y' THEN 'Repurchased'
							WHEN ' ' THEN 'Not Applicable'
							ELSE 'Unknown'
						END
	,ModificationFlag
	,ModificationDesc = CASE ModificationFlag
							WHEN 'Y' THEN 'Modified'
							WHEN ' ' THEN 'Not Modified'
							ELSE 'Unknown'
						END
	,ZeroBalanceCode
	,ZeroBalanceCodeDesc = CASE ZeroBalanceCode
							WHEN '01' THEN 'Prepaid or Matured (Voluntary Payoff)'
							WHEN '03' THEN 'Foreclosure Alternative Group'
							WHEN '06' THEN 'Repurchase prior to Property Disposition'
							WHEN '09' THEN 'REO Disposition'
							WHEN '  ' THEN 'Not Applicable'
							ELSE 'Unknown'
						END
	,PayoffLoan = CASE WHEN ZeroBalanceCode IN ('01', '06') THEN 'Paid Off'
					ELSE 'Not Paid Off' END
FROM stage.LoanService

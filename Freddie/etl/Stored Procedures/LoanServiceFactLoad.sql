CREATE PROCEDURE [etl].[LoanServiceFactLoad]
AS

BEGIN TRY
	
	BEGIN TRANSACTION

	DELETE FROM f
	FROM fact.LoanService f
		INNER JOIN dim.[File] d
			on d.filekey = f.FileKey
	WHERE d.FileName IN (SELECT DISTINCT FileName
							FROM stage.vLoanService)


	INSERT INTO fact.LoanService
	(
		[LoanSequenceNumber]
		,[ReportingMonthKey]
		,[LoanServiceStatusKey]
		,[FileKey]
		,[ZeroBalanceEffectiveMonth]
		,[DDLPIKey]
		,[ActualUPB]
		,[LoanAge]
		,[MonthsToMaturity]
		,[InterestRate]
		,[DeferredUPB]
		,[MIRecoveries]
		,[NetSalesProceeds]
		,[NonMIRecoveries]
		,[Expenses]
		,[LegalCosts]
		,[MaintenanceCosts]
		,[TaxesInsurance]
		,[MiscExpenses]
		,[ActualCost]
		,[ModificationCost]
		,MonthlyPayment
	)
	SELECT s.LoanSequenceNumber
		,s.ReportingMonth
		,lss.LoanServiceStatusKey
		,f.FileKey
		,s.ZeroBalanceEffectiveMonth
		,s.DDLPI
		,s.ActualUPB
		,s.LoanAge
		,s.MonthsToMaturity
		,s.InterestRate
		,s.DeferredUPB
		,s.MIRecoveries
		,s.NetSalesProceeds
		,s.NonMIRecoveries
		,s.Expenses
		,s.LegalCosts
		,s.MaintenanceCosts
		,s.TaxesInsurance
		,s.MiscExpenses
		,s.ActualCost
		,s.ModificationCost
		,s.MonthlyPayment
	from stage.vLoanService s
		inner join dim.LoanServiceStatus lss
			on lss.DelinquencyStatus = s.DelinquencyStatus
			and lss.ModificationFlag = s.ModificationFlag
			and lss.RepurchaseFlag = s.RepurchaseFlag
			and lss.ZeroBalanceCode = s.ZeroBalanceCode
		inner join dim.[File] f
			on f.FileName = s.FileName


	COMMIT

END TRY
BEGIN CATCH
	IF (@@TRANCOUNT > 0)
		ROLLBACK;

END CATCH

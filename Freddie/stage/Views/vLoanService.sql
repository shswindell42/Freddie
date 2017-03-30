CREATE VIEW [stage].[vLoanService]
AS 
SELECT [LoanSequenceNumber]
	,[ReportingMonth]
	,[ActualUPB]
	,[DelinquencyStatus]
	,[LoanAge]
	,[MonthsToMaturity]
	,[RepurchaseFlag]
	,[ModificationFlag]
	,[ZeroBalanceCode]
	,[ZeroBalanceEffectiveMonth]
	,[InterestRate]
	,[DeferredUPB]
	,[DDLPI]
	,[MIRecoveries]
	,[NetSalesProceeds]
	,[NonMIRecoveries]
	,[Expenses]
	,[LegalCosts]
	,[MaintenanceCosts]
	,[TaxesInsurance]
	,[MiscExpenses]
	,ActualCost = LAG(ActualUPB) OVER (PARTITION BY LoanSequenceNumber ORDER BY ReportingMonth) 
					- NetSalesProceeds - Expenses - MIRecoveries - NonMIRecoveries 
					+ ((ZeroBalanceEffectiveMonth - DDLPI) 
						* LAG(ActualUPB) OVER (PARTITION BY LoanSequenceNumber ORDER BY ReportingMonth) * (30.0/360.0) * (InterestRate - 0.35) / 100)
	,[ModificationCost]
FROM stage.LoanService

CREATE TABLE [fact].[LoanService]
(
	LoanSequenceNumber varchar(20) NOT NULL
	,ReportingMonthKey int
	,LoanServiceStatusKey int
	,FileKey int
	,ZeroBalanceEffectiveMonth int
	,DDLPIKey int -- due date of last paid installment
	,ActualUPB MONEY
	,LoanAge smallint
	,MonthsToMaturity smallint
	,InterestRate decimal(4,2)
	,DeferredUPB money
	,MIRecoveries money
	,NetSalesProceeds money
	,NonMIRecoveries money
	,Expenses money
	,LegalCosts money
	,MaintenanceCosts money
	,TaxesInsurance money
	,MiscExpenses money
	,ActualCost money
	,ModificationCost money
	,MonthlyPayment money
)
GO

CREATE CLUSTERED COLUMNSTORE INDEX CCSI_LoanService ON fact.LoanService;
CREATE PROCEDURE [etl].[LoanServiceStatusLoad]
AS
BEGIN TRY

	BEGIN TRANSACTION

	UPDATE d
	SET DelinquencyStatusDesc = s.DelinquencyStatusDesc
		,ModificationDesc = s.ModificationDesc
		,RepurchaseDesc = s.RepurchaseDesc
		,ZeroBalanceCodeDesc = s.ZeroBalanceCodeDesc
		,ModifiedDate = GETDATE()
	FROM dim.LoanServiceStatus d
		inner join stage.vLoanServiceStatus s
			on d.DelinquencyStatus = s.DelinquencyStatus
			and d.ModificationFlag = s.ModificationFlag
			and d.RepurchaseFlag = s.RepurchaseFlag
			and d.ZeroBalanceCode = s.ZeroBalanceCode


	INSERT INTO dim.LoanServiceStatus
	(
		 [DelinquencyStatus]
		,[DelinquencyStatusDesc]
		,[RepurchaseFlag]
		,[RepurchaseDesc]
		,[ModificationFlag]
		,[ModificationDesc]
		,[ZeroBalanceCode]
		,[ZeroBalanceCodeDesc]
		,CreatedDate
	)
	SELECT s.[DelinquencyStatus]
		,s.[DelinquencyStatusDesc]
		,s.[RepurchaseFlag]
		,s.[RepurchaseDesc]
		,s.[ModificationFlag]
		,s.[ModificationDesc]
		,s.[ZeroBalanceCode]
		,s.[ZeroBalanceCodeDesc]
		,GETDATE()
	FROM stage.vLoanServiceStatus s
		left outer join dim.LoanServiceStatus d
			on d.DelinquencyStatus = s.DelinquencyStatus
			and d.ModificationFlag = s.ModificationFlag
			and d.RepurchaseFlag = s.RepurchaseFlag
			and d.ZeroBalanceCode = s.ZeroBalanceCode
	where d.LoanServiceStatusKey is null

	COMMIT

END TRY
BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;

END CATCH
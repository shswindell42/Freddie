CREATE PROCEDURE [etl].[LoanAttributesLoad]

AS
BEGIN TRY

	BEGIN TRANSACTION

	-- update any descriptions
	UPDATE d
	SET [FirstTimeHomeBuyerDesc] = s.[FirstTimeHomeBuyerDesc]
		,[MortgageInsurancePercentageDesc] = s.[MortgageInsurancePercentageDesc]
		,[OccupancyStatusDesc] = s.[OccupancyStatusDesc]
		,[ChannelDesc] = s.[ChannelDesc]
		,[PPMDesc] = s.[PPMDesc]
		,[ProductTypeDesc] = s.[ProductTypeDesc]
		,[LoanPurposeDesc] = s.[LoanPurposeDesc]
		,[SuperConformingDesc] = s.[SuperConformingDesc]
		,ModifiedDate = GETDATE()
	FROM dim.LoanAttributes d
		inner join stage.vLoanAttributes s
			on d.[FirstTimeHomeBuyerFlag] = s.[FirstTimeHomeBuyerFlag]
				and d.[MortgageInsurancePercentage] = s.[MortgageInsurancePercentage]
				and d.[Units] = s.[Units]
				and d.[OccupancyStatus] = s.[OccupancyStatus]
				and d.[Channel] = s.[Channel]
				and d.[PPMFlag] = s.[PPMFlag]
				and d.[ProductType] = s.[ProductType]
				and d.[LoanPurpose] = s.[LoanPurpose]
				and d.[OriginalLoanTerm] = s.[OriginalLoanTerm]
				and d.[NumberOfBorrowers] = s.[NumberOfBorrowers]
				and d.[SuperConformingFlag] = s.[SuperConformingFlag]

	INSERT INTO dim.LoanAttributes
	(
		[FirstTimeHomeBuyerFlag]
		,[FirstTimeHomeBuyerDesc]
		,[MortgageInsurancePercentage]
		,[MortgageInsurancePercentageDesc]
		,[Units]
		,[OccupancyStatus]
		,[OccupancyStatusDesc]
		,[Channel]
		,[ChannelDesc]
		,[PPMFlag]
		,[PPMDesc]
		,[ProductType]
		,[ProductTypeDesc]
		,[LoanPurpose]
		,[LoanPurposeDesc]
		,[OriginalLoanTerm]
		,[NumberOfBorrowers]
		,[SuperConformingFlag]
		,[SuperConformingDesc]
		,CreatedDate
	)
	SELECT [s].[FirstTimeHomeBuyerFlag]
		,[s].[FirstTimeHomeBuyerDesc]
		,[s].[MortgageInsurancePercentage]
		,[s].[MortgageInsurancePercentageDesc]
		,[s].[Units]
		,[s].[OccupancyStatus]
		,[s].[OccupancyStatusDesc]
		,[s].[Channel]
		,[s].[ChannelDesc]
		,[s].[PPMFlag]
		,[s].[PPMDesc]
		,[s].[ProductType]
		,[s].[ProductTypeDesc]
		,[s].[LoanPurpose]
		,[s].[LoanPurposeDesc]
		,[s].[OriginalLoanTerm]
		,[s].[NumberOfBorrowers]
		,[s].[SuperConformingFlag]
		,[s].[SuperConformingDesc]
		,GETDATE()
	FROM stage.vLoanAttributes s
		left outer join dim.LoanAttributes d
			on d.[FirstTimeHomeBuyerFlag] = s.[FirstTimeHomeBuyerFlag]
				and d.[MortgageInsurancePercentage] = s.[MortgageInsurancePercentage]
				and d.[Units] = s.[Units]
				and d.[OccupancyStatus] = s.[OccupancyStatus]
				and d.[Channel] = s.[Channel]
				and d.[PPMFlag] = s.[PPMFlag]
				and d.[ProductType] = s.[ProductType]
				and d.[LoanPurpose] = s.[LoanPurpose]
				and d.[OriginalLoanTerm] = s.[OriginalLoanTerm]
				and d.[NumberOfBorrowers] = s.[NumberOfBorrowers]
				and d.[SuperConformingFlag] = s.[SuperConformingFlag]
	WHERE d.LoanAttributeKey is null

	COMMIT


END TRY
BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;

END CATCH
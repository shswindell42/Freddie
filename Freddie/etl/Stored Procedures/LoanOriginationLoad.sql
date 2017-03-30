-- loads a quarters worth of data into the fact table
-- assumption is that the data files do not contain overlapping data
CREATE PROCEDURE etl.LoanOriginationLoad
AS

BEGIN TRY

	BEGIN TRANSACTION

	-- remove current version of the file
	DELETE FROM lo
	FROM fact.LoanOrigination lo
	inner join dim.[File] f
		on lo.FileKey = f.FileKey
	WHERE f.[FileName] IN (SELECT DISTINCT [FileName]
						FROM stage.LoanOrigination)

	INSERT INTO fact.LoanOrigination
	(
		LoanSequenceNumber
		,CreditKey
		,FirstPaymentMonthKey
		,LoanAttributesKey
		,MaturityMonthKey
		,MetropolitanAreaKey
		,GeographyKey
		,PropertyKey
		,SellerEntityKey
		,ServicerKey
		,FileKey
		,OriginalCTLV
		,OriginalDTIRatio
		,OriginalUPB
		,OriginalLTV
		,InterestRate
	)
	select s.LoanSequenceNumber
		,ISNULL(CreditKey, -1)
		,FirstPaymentMonthKey = fpm.CalendarKey
		,LoanAttributesKey = la.LoanAttributeKey
		,MaturityMonthKey = mm.CalendarKey
		,MetropolitanAreaKey = ma.MetropolitanAreaKey
		,GeographyKey = g.GeographyKey
		,PropertyKey
		,SellerEntityKey = seller.ExternalEntityKey
		,ServicerKey = servicer.ExternalEntityKey
		,FileKey
		,OriginalCLTV
		,OriginalDTIRatio
		,OriginalUPB
		,OriginalLTV
		,InterestRate
	from stage.LoanOrigination s
		left outer join dim.Credit c
			on s.CreditScore = c.CreditScore
		left outer join dim.Calendar fpm
			on s.FirstPaymentMonth = fpm.CalendarKey
		left outer join dim.LoanAttributes la
			on la.[FirstTimeHomeBuyerFlag] = s.[FirstTimeHomeBuyerFlag]
					and la.[MortgageInsurancePercentage] = s.[MortgageInsurancePercentage]
					and la.[Units] = s.[Units]
					and la.[OccupancyStatus] = s.[OccupancyStatus]
					and la.[Channel] = s.[Channel]
					and la.[PPMFlag] = s.[PPMFlag]
					and la.[ProductType] = s.[ProductType]
					and la.[LoanPurpose] = s.[LoanPurpose]
					and la.[OriginalLoanTerm] = s.[OriginalLoanTerm]
					and la.[NumberOfBorrowers] = s.[NumberOfBorrowers]
					and la.[SuperConformingFlag] = s.[SuperConformingFlag]
		left outer join dim.Calendar mm
			on s.MaturityMonth = mm.CalendarKey
		left outer join dim.MetropolitanArea ma
			on s.MSACode = ma.MSACode
		left outer join dim.Geography g
			on s.PostalCode = g.PostalCode
		left outer join dim.Property p
			on s.PropertyType = p.PropertyType
		left outer join dim.ExternalEntity seller
			on s.SellerName = seller.EntityName
		left outer join dim.ExternalEntity servicer
			on s.ServicerName = servicer.EntityName
		left outer join dim.[File] f
			on s.FileName = f.FileName

	COMMIT
END TRY
BEGIN CATCH
	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;
END CATCH
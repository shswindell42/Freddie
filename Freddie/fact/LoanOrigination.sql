CREATE TABLE [fact].[LoanOrigination]
(
	LoanSequenceNumber varchar(20) not null
	,CreditKey int not null
	,FirstPaymentMonthKey int not null
	,LoanAttributesKey int not null
	,MaturityMonthKey int not null
	,MetropolitanAreaKey int not null
	,GeographyKey int not null
	,PropertyKey int not null
	,SellerEntityKey int not null
	,ServicerKey int not null
	,FileKey int not null
	,OriginalCTLV int
	,OriginalDTIRatio int
	,OriginalUPB int
	,OriginalLTV int
	,InterestRate decimal(5, 2)
)
GO

CREATE CLUSTERED COLUMNSTORE INDEX CCCI_LoanOrigination ON fact.LoanOrigination;
CREATE TABLE [dim].[LoanAttributes]
(
	LoanAttributeKey INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,[FirstTimeHomeBuyerFlag] CHAR(1)
    ,[FirstTimeHomeBuyerDesc] VARCHAR(50)
    ,[MortgageInsurancePercentage] VARCHAR(3)
    ,[MortgageInsurancePercentageDesc] VARCHAR(10)
    ,[Units] SMALLINT
    ,[OccupancyStatus] CHAR(1)
    ,[OccupancyStatusDesc] VARCHAR(25)
    ,[Channel] CHAR(1)
    ,[ChannelDesc] VARCHAR(25)
    ,[PPMFlag] CHAR(1)
    ,[PPMDesc] VARCHAR(25)
    ,[ProductType] CHAR(3)
    ,[ProductTypeDesc] VARCHAR(20)
    ,[LoanPurpose] CHAR(1)
    ,[LoanPurposeDesc] VARCHAR(50)
    ,[OriginalLoanTerm] VARCHAR(3)
    ,[NumberOfBorrowers] VARCHAR(2)
    ,[SuperConformingFlag] VARCHAR(1)
    ,[SuperConformingDesc] VARCHAR(50)
	,CreatedDate datetime
	,ModifiedDate datetime
)

CREATE TABLE [dim].[Credit]
(
	CreditKey INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	,CreditScore INT NOT NULL
	,CreditCategory VARCHAR(10) NOT NULL
	,CreatedDate DATETIME
	,ModifiedDate DATETIME
)

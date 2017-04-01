CREATE TABLE dim.LoanServiceStatus
(
	LoanServiceStatusKey INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DelinquencyStatus varchar(3) NULL,
	DelinquencyStatusDesc varchar(41) NOT NULL,
	RepurchaseFlag varchar(1) NULL,
	RepurchaseDesc varchar(15) NOT NULL,
	ModificationFlag varchar(1) NULL,
	ModificationDesc varchar(12) NOT NULL,
	ZeroBalanceCode varchar(2) NULL,
	ZeroBalanceCodeDesc varchar(40) NOT NULL,
	CreatedDate datetime,
	ModifiedDate datetime
)
GO

CREATE NONCLUSTERED INDEX NCI_LoanServiceStatus ON dim.LoanServiceStatus (DelinquencyStatus, RepurchaseFlag, ModificationFlag, ZeroBalanceCode)
INCLUDE (LoanServiceStatusKey)
GO

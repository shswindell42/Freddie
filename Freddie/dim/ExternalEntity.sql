CREATE TABLE [dim].[ExternalEntity]
(
	ExternalEntityKey INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,EntityName VARCHAR(20)
	,CreatedDate datetime
	,ModifiedDate datetime
)

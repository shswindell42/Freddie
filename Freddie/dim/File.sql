CREATE TABLE [dim].[File]
(
	FileKey INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,[FileName] VARCHAR(100) NOT NULL UNIQUE
	,CreatedDate datetime NOT null
)

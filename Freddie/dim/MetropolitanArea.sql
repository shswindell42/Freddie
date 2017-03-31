CREATE TABLE [dim].[MetropolitanArea]
(
	MetropolitanAreaKey INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,MSACode INT NOT NULL UNIQUE
	,AreaDescription VARCHAR(500) NOT NULL
	,DivisionIndicator VARCHAR(10) NOT NULL
	,CreatedDate datetime
	,ModifiedDate datetime	
)

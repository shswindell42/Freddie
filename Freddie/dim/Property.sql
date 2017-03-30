CREATE TABLE [dim].[Property]
(
	PropertyKey INT NOT NULL PRIMARY KEY IDENTITY(1,1)
	,PropertyType CHAR(2)
	,PropertyTypeDesc VARCHAR(30)
	,CreatedDate datetime
	,ModifiedDate datetime
)

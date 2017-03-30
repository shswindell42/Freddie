CREATE TABLE [dim].[Geography]
(
	GeographyKey INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[PostalCode]         VARCHAR (5)   NULL,
    [PlaceName]          VARCHAR (200) NULL,
    [State]              VARCHAR (20)  NULL,
    [StateAbbreviation]  VARCHAR (5)   NULL,
    [County]             VARCHAR (100)  NULL,
    [Latitude]           REAL          NULL,
    [Longitude]          REAL          NULL,
	CreatedDate			 DATETIME,
	ModifiedDate		 DATETIME
)

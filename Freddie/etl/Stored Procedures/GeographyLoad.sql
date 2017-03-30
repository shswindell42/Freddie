CREATE PROCEDURE [etl].[GeographyLoad]
AS

BEGIN TRY

	-- TYPE I Dimension
	BEGIN TRANSACTION

	-- Update any existing dimension records
	UPDATE d
	SET d.PlaceName = s.[Place Name]
		,d.State = s.State
		,d.StateAbbreviation = s.[State Abbreviation]
		,d.County = s.County
		,d.Latitude	 = s.Latitude
		,d.Longitude = s.Longitude
		,d.ModifiedDate = GETDATE()
	FROM dim.Geography d
		inner join stage.ZipCode s
			on d.PostalCode = s.[Postal Code]
	

	-- insert any new records not in the dimension
	INSERT INTO	dim.Geography
	(
		[PostalCode]
		,[PlaceName]
		,[State]
		,[StateAbbreviation]
		,[County]
		,[Latitude]
		,[Longitude]
		,CreatedDate
	)
	SELECT [s].[Postal Code]
		,[s].[Place Name]
		,[s].[State]
		,[s].[State Abbreviation]
		,[s].[County]
		,[s].[Latitude]
		,[s].[Longitude]
		,GETDATE()
	FROM stage.ZipCode s
		LEFT OUTER JOIN dim.Geography d
			on s.[Postal Code] = d.PostalCode
	WHERE d.GeographyKey is null


	-- load any 'inferred' members 
	INSERT INTO	dim.Geography
	(
		[PostalCode]
		,[PlaceName]
		,[State]
		,[StateAbbreviation]
		,[County]
		,[Latitude]
		,[Longitude]
		,CreatedDate
	)
	SELECT DISTINCT L.PostalCode
		,'Unknown'
		,'Unknown'
		,'UN'
		,'Unknown'
		,0.0
		,0.0
		,GETDATE()
	FROM stage.LoanOrigination l
		LEFT OUTER JOIN dim.Geography g
			on l.PostalCode = g.PostalCode
	WHERE g.GeographyKey is null



	COMMIT

END TRY
BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;

END CATCH
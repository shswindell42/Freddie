CREATE PROCEDURE [etl].[MetropolitanAreaLoad]
AS


BEGIN TRY

	IF NOT EXISTS (SELECT MetropolitanAreaKey FROM dim.MetropolitanArea WHERE MetropolitanAreaKey < 0)
	BEGIN 
		SET IDENTITY_INSERT dim.MetropolitanArea ON;

		INSERT INTO dim.MetropolitanArea
		(
			MetropolitanAreaKey
			,MSACode 
			,AreaDescription 
			,DivisionIndicator 
			,CreatedDate 
		)
		VALUES
		(-1, '0', 'Unknown', 'Unknown', GETDATE())

		SET IDENTITY_INSERT dim.MetropolitanArea OFF;
	END
	
	-- TYPE 1 DIMENSION
	BEGIN TRANSACTION
	
	-- Update any existing records with new information
	UPDATE d
	SET AreaDescription = Description
		,DivisionIndicator = s.DivisionIndicator
		,ModifiedDate = GETDATE()
	FROM dim.MetropolitanArea d
		inner join stage.vMSACodes s
			on d.MSACode = s.Code
	WHERE AreaDescription <> s.Description
		OR d.DivisionIndicator <> s.DivisionIndicator
	
	INSERT INTO dim.MetropolitanArea
	(
		MSACode 
		,AreaDescription 
		,DivisionIndicator 
		,CreatedDate 
	)
	SELECT Code
		,Description
		,s.DivisionIndicator
		,GETDATE()
	FROM stage.vMSACodes s
		LEFT OUTER JOIN dim.MetropolitanArea d
			ON s.Code = d.MSACode
	WHERE d.MetropolitanAreaKey IS NULL

	-- load any inferred members
	INSERT INTO dim.MetropolitanArea
	(
		MSACode 
		,AreaDescription 
		,DivisionIndicator 
		,CreatedDate 
	)
	select distinct s.MSACode
		,'Inferred'
		,'Inferred'
		,GETDATE()
	from stage.LoanOrigination s
		left outer join dim.MetropolitanArea m
			on s.MSACode = m.MSACode
	where m.MetropolitanAreaKey is null



	COMMIT

END TRY
BEGIN CATCH
	
	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW; -- throw the error back to calling code
	
END CATCH

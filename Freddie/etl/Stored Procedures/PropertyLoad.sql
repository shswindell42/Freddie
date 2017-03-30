CREATE PROCEDURE [etl].[PropertyLoad]
	AS

BEGIN TRY

	-- TYPE I Dimension
	BEGIN TRANSACTION

	-- Update any existing dimension records
	UPDATE d
	SET d.PropertyTypeDesc = s.PropertyTypeDesc
		,d.ModifiedDate = GETDATE()
	FROM dim.Property d
		inner join stage.vProperty s
			on d.PropertyType = s.PropertyType
	

	-- insert any new records not in the dimension
	INSERT INTO	dim.Property
	(
		PropertyType
		,PropertyTypeDesc
		,CreatedDate
	)
	SELECT s.PropertyType
		,s.PropertyTypeDesc
		,GETDATE()
	FROM stage.vProperty s
		LEFT OUTER JOIN dim.Property d
			on s.PropertyType = d.PropertyType
	WHERE d.PropertyKey is null


	COMMIT

END TRY
BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;

END CATCH
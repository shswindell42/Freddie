CREATE PROCEDURE [etl].[ExternalEntityLoad]
AS
BEGIN TRY

	-- TYPE I Dimension
	BEGIN TRANSACTION

	-- insert any new records not in the dimension
	INSERT INTO	dim.ExternalEntity
	(
		EntityName
		,CreatedDate
	)
	SELECT s.EntityName
		,GETDATE()
	FROM stage.vExternalEntity s
		LEFT OUTER JOIN dim.ExternalEntity d
			on s.EntityName = d.EntityName
	WHERE d.ExternalEntityKey is null


	COMMIT

END TRY
BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK;

	THROW;

END CATCH
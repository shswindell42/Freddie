CREATE VIEW [stage].[vProperty]
AS
SELECT PropertyType
	,PropertyTypeDesc = CASE PropertyType
				WHEN 'CO' THEN 'Condo'
				WHEN 'LH' THEN 'Leasehold'
				WHEN 'PU' THEN 'PUD'
				WHEN 'MH' THEN 'Manufactured Housing'
				WHEN 'SF' THEN '1-4 Fee Simple'
				WHEN 'CP' THEN 'Co-op'
				WHEN '  ' THEN 'Unknown'
				ELSE 'Unknown'
			END
FROM stage.LoanOrigination

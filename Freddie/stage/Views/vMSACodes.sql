﻿CREATE VIEW [stage].[vMSACodes]
AS
SELECT DISTINCT Code = COALESCE([Metro Division Code], [CBSA Code])
	,Description = CASE WHEN [Metro Division Code] is not null THEN [Metropolitan Division Title] 
					ELSE [CBSA Title]
				END	
	,DivisionIndicator =  CASE WHEN [Metro Division Code] is not null THEN 'Division' 
					ELSE 'Area'
				END	
FROM stage.MSACodeListing
WHERE ISNUMERIC([CBSA Code]) = 1
UNION
SELECT [Code], [Description], 'Area' as DivisionIndicator
FROM stage.MSACodes
UNION  
SELECT [Code], [Division], 'Division'
FROM stage.MSADivision
UNION 
SELECT DISTINCT Code = IIF(CBSADivisionCode = -1, CBSACode, CBSADivisionCode)
	,Description = IIF(CBSADivisionTitle = '', CBSATitle, CBSADivisionTitle)
	,DivisionIndicator = IIF(CBSADivisionTitle = '', 'Area', 'Division')
FROM stage.MSACodeFile
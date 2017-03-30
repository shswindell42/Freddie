CREATE VIEW [stage].[vLoanAttributes]
AS 
SELECT DISTINCT FirstTimeHomeBuyerFlag
	,FirstTimeHomeBuyerDesc = CASE FirstTimeHomeBuyerFlag 
								WHEN 'Y' THEN 'First Time Home Buyer'
								WHEN 'N' THEN 'Not First Time Home Buyer'
								ELSE 'Unkown' 
							END
	,MortgageInsurancePercentage
	,MortgageInsurancePercentageDesc = CASE MortgageInsurancePercentage
								WHEN '000' THEN 'No MI'
								WHEN '   ' THEN 'Unknown'
								ELSE CONCAT(MortgageInsurancePercentage, '%')
							END
	,Units
	,OccupancyStatus 
	,OccupancyStatusDesc = CASE OccupancyStatus 
						WHEN 'O' THEN 'Owner Occupied'
						WHEN 'I' THEN 'Investment'
						WHEN 'S' THEN 'Second Home'
						WHEN ' ' THEN 'Unknown'
						ELSE 'Unknown'
					END
	,Channel
	,ChannelDesc = CASE Channel
				WHEN 'R' THEN 'Retail'
				WHEN 'B' THEN 'Broker'
				WHEN 'C' THEN 'Correspondent'
				WHEN 'T' THEN 'TPO Not Specified'
				WHEN ' ' THEN 'Unknown'
				ELSE 'Unknown'
			END
	,PPMFlag
	,PPMDesc = CASE PPMFlag
				WHEN 'Y' THEN 'Prepayment Penalty'
				WHEN 'N' THEN 'No Prepayment Penalty'
				ELSE 'Unknown'
			END 
	,ProductType
	,ProductTypeDesc = CASE ProductType
				WHEN 'FRM' THEN 'Fixed Rate Mortgage'
				ELSE 'Not Specified'
			END
	,LoanPurpose
	,LoanPurposeDesc = CASE LoanPurpose
				WHEN 'P' THEN 'Purpose'
				WHEN 'C' THEN 'Cash-Out Refinance'
				WHEN 'N' THEN 'No Cash-Out Refinance'
				ELSE 'Unknown'
			END
	,OriginalLoanTerm
	,NumberOfBorrowers
	,SuperConformingFlag
	,SuperConformingDesc = CASE SuperConformingFlag
						WHEN 'Y' THEN 'Super Conforming'
						ELSE 'Not Super Conforming'
					END
FROM stage.LoanOrigination 

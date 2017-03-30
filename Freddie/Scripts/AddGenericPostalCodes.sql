
/*

Codes in the dataset have the last two digits masked. so we create a generic postal code set. 
Some codes cross state lines so we eliminate those from the set
*/
insert into dim.Geography
(PostalCode, PlaceName, State, StateAbbreviation,County, Latitude, Longitude, CreatedDate)
select distinct concat(left(PostalCode, 3), '00') PostalCode, '' as PlaceName, State, StateAbbreviation, '' as County, 0.0 as Latitude, 0.0 as Longitude, GETDATE()
from Freddie.dim.Geography 
where GeographyKey not in (2200, 37209, 42058, 42059, 42064, 42065, 42066, 42067, 42068)




CREATE PROCEDURE [etl].[CalendarLoad]
AS
 declare @curDate as Date
  set @curDate = '1900-01-01'


  while (DATEDIFF(day, @curDate, '2099-12-01') <> 0)
  begin

  insert into dim.Calendar
  (CalendarKey, MonthNumber, MonthName, Quarter, Year)
  SELECT YEAR(@curDate) * 100 + MONTH(@curDate) as CalendarKey
	,MONTH(@curDate) as MonthNumber
	,DATENAME(month, @curDate) as MonthName
	,CONCAT(YEAR(@curDate), ' Q', DATEPART(quarter, @curDate)) as Quarter
	,YEAR(@curDate) as Year

  set @curDate = DATEADD(month, 1, @curDate)

  end 


  -- add unknown member
  insert into dim.Calendar
  (CalendarKey, MonthNumber, MonthName, Quarter, Year)
  VALUES
  (0, 0, 'Unknown', 'Unknown', 1900)
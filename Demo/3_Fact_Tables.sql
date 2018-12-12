------------------------------------------
--- Fact examples
--------------------------------------------
use Freddie
go

-- one row per loan
select top 100 *
from fact.LoanOrigination

-- one row per loan payment
select top 100 *
from fact.LoanService


-- these tables can get big over time
select count(*)
from fact.LoanOriginationFull

select count(*)
from fact.LoanServiceFull



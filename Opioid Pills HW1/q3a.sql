select year(transaction_date) || 
case 
when (cast (month(transaction_date) as int) < 10)
then '0' || cast(month(transaction_date) as int)
else cast (month(transaction_date) as char(2))
end as year_month,
BUYER_COUNTY AS county, 
decimal(sum(dosage_unit),31,2) as monthly_counts,
decimal(avg(sum(dosage_unit)) 
	over (order by year(transaction_date), month(transaction_date) rows between 1 PRECEDING and 1 following ),31,2) as smooth_counts
from cse532.dea_ny 
WHERE BUYER_COUNTY = 'SUFFOLK'
group by BUYER_COUNTY, year(transaction_date), month(transaction_date);
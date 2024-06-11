--1. Sales representative and responsible accounts

select a.id as sales_rep_id, a.name as sales_rep_name, a.region_id as sales_rep_region, 
b.name as acccount_name,
row_number() over(partition by a.name) as acc_num
from sales_rep a join accounts b
on a.id=sales_rep_id
order by sales_rep_name



--2.Yearly Revenue Percentage and Rank by Sales Representative

with yearly_rev as (
	select extract(year from occured_at) as yearly,
	sum(total_amt_usd) as yearly_rev
	from orders
	group by yearly
)

select extract(year from occured_at) as year, c.name as sales_rep_name,
round(sum(total_amt_usd)::numeric/d.yearly_rev::numeric,10) as perc_sales_rep,
row_number() over(partition by extract(year from occured_at) order by sum(total_amt_usd)::numeric/d.yearly_rev::numeric desc) as rank_sales_rep
from orders a join accounts b on account_id=b.id
join sales_rep c on sales_rep_id=c.id
join yearly_rev d on yearly=extract(year from occured_at)
group by year, c.name, d.yearly_rev
order by year, rank_sales_rep



--3.Yearly Revenue Percentage and Rank by Region

with yearly_rev as (
	select extract(year from occured_at) as yearly,
	sum(total_amt_usd) as yearly_rev
	from orders
	group by yearly
)

select extract(year from occured_at) as year, e.name as sales_rep_name,
round(sum(total_amt_usd)::numeric/d.yearly_rev::numeric,5) as perc_region_rep,
row_number() over(partition by extract(year from occured_at) order by sum(total_amt_usd)::numeric/d.yearly_rev::numeric desc) as rank_sales_rep
from orders a join accounts b on account_id=b.id
join sales_rep c on sales_rep_id=c.id
join yearly_rev d on yearly=extract(year from occured_at)
join region e on e.id=region_id
group by year, e.name, d.yearly_rev
order by year, rank_sales_rep



--4.Yearly Revenue by Account

with yearly_rev as (
	select extract(year from occured_at) as yearly,round(sum(total_amt_usd)::numeric,2) as total_rev
	from orders
	group by yearly
)

select extract(year from a.occured_at) as year,
b.name as acc_name, round(sum(a.total_amt_usd)::numeric,2) as rev,
round(sum(total_amt_usd)::numeric/c.total_rev,10) as pct_yearly_rev,
row_number() over(partition by extract(year from a.occured_at) order by sum(total_amt_usd) desc) as rev_rank
from orders a join accounts b on account_id=b.id
join yearly_rev c on extract(year from occured_at)=c.yearly
group by year, b.name, c.total_rev
order by year, rev_rank
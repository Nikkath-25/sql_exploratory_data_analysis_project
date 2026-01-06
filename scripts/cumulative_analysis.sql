/*
==============================================================================
Cumulative Analysis
==============================================================================
- aggregating the data progressively over time.
- its a technique inorder to understand wether our business is growing or declining.
- Formula: Ʃ[Cumulative Measure] By [Date Dimension]

================================================================================
The Total Sales per Month and The Running Total of Sales Over Time
================================================================================
*/

select
order_month,
total_sales,
sum(total_sales) over(order by order_month) as running_total_sales, -- Default Window Frame-between unbounded preceding and current row
sum(total_sales) over(partition by order_month order by order_month) as running_total_sales_for_wholeyear
from
(
select
date_format(order_date, '%Y-%m-01') as order_month,
sum(sales_amount) as total_sales
from gold_layer.fact_sales
where order_date is not null
group by date_format(order_date, '%Y-%m-01')
)t ;

/*
=============================================================================
Running Total Sales Over The Years
=============================================================================
*/

select
order_year,
total_sales,
sum(total_sales) over(order by order_year) as running_total_sales -- Default Window Frame-between unbounded preceding and current row
from
(
select
date_format(order_date, '%Y-01-01') as order_year,
sum(sales_amount) as total_sales
from gold_layer.fact_sales
where order_date is not null
group by date_format(order_date, '%Y-01-01')
)t ;

/*
=============================================================================
Moving Average of the Price Over The Years
=============================================================================
*/

select
order_year,
total_sales,
avg_price,
sum(total_sales) over(order by order_year) as running_total_sales, -- Default Window Frame-between unbounded preceding and current row
avg(avg_price) over(order by order_year) as moving_average_price
from
(
select
date_format(order_date, '%Y-01-01') as order_year,
sum(sales_amount) as total_sales,
avg(price) as avg_price
from gold_layer.fact_sales
where order_date is not null
group by date_format(order_date, '%Y-01-01')
)t ;
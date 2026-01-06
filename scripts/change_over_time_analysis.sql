/*
==============================================================================
Change-Over-Time Analysis(Trends)
==============================================================================
- its a technique inorder to analyze how a measure evolves over time
- helps track trends and identify seasonality in your data.
- Formula: Ʃ[Measure] By [Date Dimension]

================================================================================
Analyze Sales Performance Over Time
================================================================================
*/

select 
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold_layer.fact_sales
where order_date is not null
group by year(order_date),month(order_date)
order by year(order_date),month(order_date);

select 
date_format(order_date, '%Y-%m-01') as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold_layer.fact_sales
where order_date is not null
group by date_format(order_date, '%Y-%m-01')
order by date_format(order_date, '%Y-%m-01');

-- How many new customers were added each year
select 
date_format(order_date, '%Y-01-01') as order_year,
count(distinct customer_key) as total_customers
from gold_layer.fact_sales
where order_date is not null
group by date_format(order_date, '%Y-01-01')
order by date_format(order_date, '%Y-01-01');
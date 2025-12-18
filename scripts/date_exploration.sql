/*
Date Exploration:
- Identify the earliest and latest dates(boundaries).
- Understand the scope of data and the timespan.
For that we need:
The functions MIN/MAX applied on the '[Date Dimension]'.
*/

-- Find date of the first and last order
select order_date from gold_layer.fact_sales;

select 
MIN(order_date) as first_order_date,
MAX(order_date) as last_order_date,
year(max(order_date)) - year(min(order_date)) as order_range_years
from gold_layer.fact_sales;

-- FInd the youngest and oldest customer
select 
min(birthdate) as oldest_customer,
max(birthdate) as youngest_customer,
timestampdiff(year, min(birthdate) , curdate()) as oldest_customer_age,
timestampdiff(year, max(birthdate), curdate()) as youngest_customer_age
from gold_layer.dim_customers;
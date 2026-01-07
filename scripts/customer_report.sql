/*
==========================================================================================
Customer Report
==========================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gathers essential fields such as names,ages, and transaction details. 
    2. Segments customers into categories (VIP, Regular, New) and age groups. 
    3. Aggregates customer-level metrics:
		- total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan(in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
        - average order value
        - average monthly spend
===========================================================================================
*/

CREATE VIEW gold_layer.report_customers AS
WITH base_query AS(
/*-----------------------------------------------------------------------------------------
1) Base Query: Retrives core columns from fact_sales and dim_customers
-----------------------------------------------------------------------------------------*/

select
c.customer_key,
c.customer_number,
concat(c.first_name,' ',c.last_name) as customer_name,
timestampdiff(year,c.birthdate,curdate()) as age,
f.product_key,
f.order_number,
f.order_date,
f.quantity,
f.sales_amount
from gold_layer.fact_sales f
LEFT JOIN gold_layer.dim_customers c
ON f.customer_key = c.customer_key
where order_date is not null -- only consider valid sales dates
),

customer_aggregations as(
/*-----------------------------------------------------------------------------------------
2) Customer Aggregations: Summarizes Key Metrics at the Customer Level
-----------------------------------------------------------------------------------------*/
SELECT 
customer_key,
customer_number,
customer_name,
age,
count(distinct product_key) as total_products,
count(distinct order_number) as total_orders,
sum(quantity) as total_quantity,
sum(sales_amount) as total_sales,
max(order_date) as last_order_date,
timestampdiff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by customer_key,
customer_number,
customer_name,
age)

/*--------------------------------------------------------------------------------------
3) Final Query: Combines all customer results into one output
--------------------------------------------------------------------------------------*/
select 
customer_key,
customer_number,
customer_name,
age,
case when age < 20 then 'under 20'
	when age between 20 and 29 then '20-29'
	when age between 30 and 39 then '30-39'
	when age between 40 and 29 then '40-49'
    else '50 and Above'
end as age_group,
case when lifespan >=12 and total_sales > 5000 then 'VIP'
	when lifespan >=12 and total_sales <=5000 then 'Regular'
	else 'New'
end as customer_segment,
last_order_date,
timestampdiff(month,last_order_date,curdate()) as recency,
total_products,
total_orders,
total_quantity,
total_sales,
lifespan,
-- Compute Average Order Value(AOV)
case when total_sales = 0 then 0
	else total_sales/total_orders 
end as avg_order_value,
-- Compute Average Monthly Spend
case when lifespan = 0 then total_sales
	else total_sales/lifespan
end as avg_monthly_spend 
from customer_aggregations

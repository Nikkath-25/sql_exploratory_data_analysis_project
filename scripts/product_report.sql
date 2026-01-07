/*
==========================================================================================
Product Report
==========================================================================================
Purpose:
	- This report consolidates key product metrics and behaviors

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost. 
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers. 
    3. Aggregates product-level metrics:
		- total orders
        - total sales
        - total quantity sold
        - total customers(unique)
        - lifespan(in months)
	4. Calculates valuable KPIs:
		- recency (months since last sale)
        - average order revenue
        - average monthly revenue
===========================================================================================
*/

WITH base_query AS(
/*-----------------------------------------------------------------------------------------
1) Base Query: Retrives core columns from fact_sales and dim_products
-----------------------------------------------------------------------------------------*/
select 
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost,
f.customer_key,
f.order_number,
f.order_date,
f.quantity,
f.sales_amount
from gold_layer.fact_sales f
LEFT JOIN gold_layer.dim_products p
ON f.product_key = p.product_key
where order_date is not null -- only consider valid sales dates
),

product_aggregations as(
/*-----------------------------------------------------------------------------------------
2) Product Aggregations: Summarizes Key Metrics at the Product Level
-----------------------------------------------------------------------------------------*/
select
product_key,
product_name,
category,
subcategory,
cost,
count(distinct customer_key) as total_customers,
count(distinct order_number) as total_orders,
MAX(order_date) as last_sale_date,
timestampdiff(month, min(order_date), max(order_date)) as lifespan,
sum(quantity) as total_quantity,
sum(sales_amount) as total_sales,
round(avg(sales_amount/nullif(quantity,0)),1) as avg_selling_price
from base_query
group by product_key,
product_name,
category,
subcategory,
cost)

/*--------------------------------------------------------------------------------------
3) Final Query: Combines all product results into one output
--------------------------------------------------------------------------------------*/
select
product_key,
product_name,
category,
subcategory,
cost,
last_sale_date,
timestampdiff(month,last_sale_date,curdate()) as recency,
case when total_sales > 50000 then 'High-Performer'
	when total_sales >= 10000 then 'Mid-Range'
    else 'Low-Performer'
end as product_segment,
lifespan,
total_orders,
total_sales,
total_quantity,
total_customers,
avg_selling_price,
-- Average Order Revenue(AOR)
case when total_orders = 0 then 0
	else total_sales/total_orders
end as avg_order_revenue,

-- Average Monthly Revenue
case when lifespan = 0 then total_sales
	else total_sales/lifespan
end as avg_monthly_revenue
from product_aggregations
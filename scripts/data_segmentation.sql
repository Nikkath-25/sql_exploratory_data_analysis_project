/*
========================================================================================
Data Segmentation
========================================================================================
- group the data based on a specific range
- helps understand the correlation between two measures
- we create new categories and then go and aggregate the data based on the new category
- Formula: [Measure] By [Measure]

========================================================================================
Segment products into cost ranges and count how many products fall into each segment
========================================================================================
*/

WITH product_segment as(
select
product_key,
product_name,
cost,
CASE WHEN cost < 100 then 'Below 100'
WHEN cost between 100 and 500 then '100-500'
WHEN cost between 500 and 1000 then '500-1000'
ELSE 'Above 1000'
END AS cost_range
from gold_layer.dim_products
)
select
cost_range,
count(product_key) as total_products
from product_segment
group by cost_range
order by total_products desc

/*
========================================================================================
Group Customers into three segments based on their spending behavior
- VIP: Customers with atleast 12 months of history and spending more than $5000
- Regular: Customers with atleast 12 months of history but spending $5000 or less
- New: Customers with a lifespan less than 12 months
And find the total number of customers by each group
========================================================================================
*/

WITH customer_spending as(
select
c.customer_key,
sum(f.sales_amount) as total_spending,
MIN(f.order_date) AS first_order,
MAX(f.order_date) AS last_order,
timestampdiff(month, MIN(f.order_date), MAX(f.order_date)) as lifespan
from gold_layer.fact_sales f
LEFT JOIN gold_layer.dim_customers c
ON f.customer_key = c.customer_key
group by c.customer_key
)
select
count(customer_key) as total_customers,
customer_segment
from
(
select
customer_key,
total_spending,
lifespan,
case when lifespan >=12 and total_spending > 5000 then 'VIP'
when lifespan >=12 and total_spending <=5000 then 'Regular'
else 'New'
end as customer_segment
from customer_spending
)t
group by customer_segment
order by count(customer_key) desc;


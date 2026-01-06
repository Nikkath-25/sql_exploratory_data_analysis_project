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
- VIP: atleast 12 months of history and spending more than $5000
- Regular: atleast 12 months of history but spending $5000 or less
- New: lifespan less than 12 months
And find the total number of customers by each group
========================================================================================
*/




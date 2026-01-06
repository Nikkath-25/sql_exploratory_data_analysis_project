/*
==============================================================================
Performance Analysis
==============================================================================
- it is the process of comparing the current value with a traget value
- helps measure the success to compare the performance
- Formula: [Current Measure] - [Target Measure]

================================================================================
Analyze the Yearly Performance of Products by Comparing each Product's Sales to 
both its Average Sales Performance and the Previous Year's Sales.
================================================================================
*/

WITH yearly_product_sales as(
select
year(f.order_date) as order_year,
p.product_name,
sum(f.sales_amount) as current_sales
from gold_layer.fact_sales f
LEFT JOIN gold_layer.dim_products p
ON f.product_key=p.product_key
where order_date is not null
group by year(f.order_date),p.product_name
)
select
order_year,
product_name,
current_sales,
avg(current_sales) over(partition by product_name) as average_sales,
current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
CASE WHEN current_sales - avg(current_sales) over(partition by product_name) > 0 THEN 'Above Avg'
 WHEN current_sales - avg(current_sales) over(partition by product_name) < 0 THEN 'Below Avg'
ELSE 'Avg'
END AS avg_change,
-- Year-Over-Year Analysis
LAG(current_sales) over(partition by product_name order by order_year) as py_sales,
current_sales - LAG(current_sales) over(partition by product_name order by order_year) diff_py,
CASE WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year)  > 0 THEN 'Increase'
 WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year)  < 0 THEN 'Decrease'
ELSE 'No Change'
END AS py_change
from yearly_product_sales
order by product_name,order_year;

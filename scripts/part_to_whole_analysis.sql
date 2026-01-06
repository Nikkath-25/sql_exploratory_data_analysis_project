/*
==============================================================================
Part-to-Whole Analysis
==============================================================================
- we use inorder to find out the proportion of a part relative to the whole.
- Analyze how an individual part is performing compared to the overall,
  allowing us to understand which category has the greatest impact on the business.
- Formula: ([Measure]/Total[Measure])*100 By [Dimension]

================================================================================
Which categories contribute the most to overall sales
================================================================================
*/
WITH category_sales as(
select 
category,
sum(sales_amount) as total_sales
from gold_layer.fact_sales f 
LEFT JOIN gold_layer.dim_products p 
ON f.product_key=p.product_key
group by category
)
select
category,
total_sales,
sum(total_sales) over() as overall_sales,
concat(round((total_sales/sum(total_sales) over()) * 100, 2), '%') as percentage_of_total
from category_sales
order by total_sales desc;
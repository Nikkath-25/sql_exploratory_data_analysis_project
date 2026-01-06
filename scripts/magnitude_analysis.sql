/*
Magnitude Analysis:
- Compare the measure values by categories.
- It helps us understand the importance of different categories.
For that we need:
to first aggregate particular measure by dimension, we need here dimension to split the measure.
*/

-- Find total customers by countries
select 
country,
count(customer_key) as total_customers
from gold_layer.dim_customers
group by country
order by total_customers DESC;

-- Find total customers by gender

select 
gender,
count(customer_key) as total_customers
from gold_layer.dim_customers
group by gender
order by total_customers DESC;

-- Find total products by category

select 
category,
count(product_key) as total_products
from gold_layer.dim_products
group by category
order by total_products DESC;

-- What is the average cost in each category?

select 
category,
avg(cost) as average_cost
from gold_layer.dim_products
group by category
order by average_cost DESC;

-- What is the total revenue generated for each category?

select
p.category,
sum(f.sales_amount) as total_revenue
from gold_layer.fact_sales f
left join gold_layer.dim_products p
on p.product_key = f.product_key
group by p.category
order by total_revenue desc;


-- Find total revenue is genearted by each customer

select 
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount) as total_revenue
from gold_layer.fact_sales f
left join gold_layer.dim_customers c
on c.customer_key = f.customer_key
group by
c.customer_key,
c.first_name,
c.last_name 
order by total_revenue desc;

-- What is the distribution of sold items across countries?
select 
c.country,
sum(f.quantity) as total_sold_items
from gold_layer.fact_sales f
left join gold_layer.dim_customers c
on c.customer_key = f.customer_key
group by c.country
order by total_sold_items desc;

-- Find total orders by each country
select
c.country,
count(distinct f.order_number) as total_orders
from gold_layer.fact_sales f
left join gold_layer.dim_customers c
on c.customer_key = f.customer_key
group by c.country
order by total_orders desc;

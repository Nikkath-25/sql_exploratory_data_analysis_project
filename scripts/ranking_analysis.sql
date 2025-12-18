/*
Ranking Analysis:
- Order the value of our dimensions by measure inorder to identify
  Top N Performers | Bottom N Performers
- For that we need:
 to Rank our 'Dimension' by an 'Aggregated Measure'
 */
 
 -- Which 5 products genearte the highest revenue?
 
 select
 p.product_name,
 sum(f.sales_amount)  as total_revenue 
 from gold_layer.fact_sales f
 left join gold_layer.dim_products p
 on p.product_key = f.product_key
 group by p.product_name
 order by total_revenue desc
 LIMIT 5;
 
 # Using Window Function
 
 select
 *
 from
 (
  select
 p.product_name,
 sum(f.sales_amount)  as total_revenue,
 ROW_NUMBER() OVER(ORDER BY sum(f.sales_amount) desc) as rank_products 
 from gold_layer.fact_sales f
 left join gold_layer.dim_products p
 on p.product_key = f.product_key
 group by p.product_name
 )t where rank_products <= 5;
 
 
 -- What are the 5 worst-performing products in terms of sales?

 select
 p.product_name,
 sum(f.sales_amount)  as total_revenue 
 from gold_layer.fact_sales f
 left join gold_layer.dim_products p
 on p.product_key = f.product_key
 group by p.product_name
 order by total_revenue ASC
 LIMIT 5;
 
 -- Find the Top-10 customers who have generated the highest revenue 
 
 select
 c.customer_key,
 c.first_name,
 c.last_name,
 sum(f.sales_amount) as total_revenue
 from gold_layer.fact_sales f
 left join gold_layer.dim_customers c
 on c.customer_key = f.customer_key
 group by c.customer_key, c.first_name, c.last_name
 order by total_revenue desc
 LIMIT 10;
 
 -- The 3 customers with the fewest orders placed.
 
 select
 c.customer_key,
 c.first_name,
 c.last_name,
 count(distinct f.order_number) as total_orders
 from gold_layer.fact_sales f
 left join gold_layer.dim_customers c
 on c.customer_key = f.customer_key
 group by c.customer_key, c.first_name, c.last_name
 order by total_orders
 LIMIT 3;
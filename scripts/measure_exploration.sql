/*
Measure Exploration:
- Calculate the key metric of the business(Big Numbers)
- Highest Level of Aggreagtion | Lowest Level of Details
For that we need:
Aggregate Function together with Measure. eg., SUM(sales), AVG(price), SUM(quantity)
*/

-- Find the Total Sales
select sum(sales_amount) as total_sales from gold_layer.fact_sales;

-- Find how many items are sold
select sum(quantity) as total_quantity from gold_layer.fact_sales;

-- Find the average selling price
select round(avg(price), 0) as avg_price from gold_layer.fact_sales;

-- Find the total number of orders
select count(order_number) as total_orders from gold_layer.fact_sales;
select count(distinct order_number) as total_orders from gold_layer.fact_sales;
select * from gold_layer.fact_sales;

-- Find the total number of products
select count(product_key) as total_products from gold_layer.dim_products;
select count(distinct product_key) as total_products from gold_layer.dim_products;

select count(product_name) as total_products from gold_layer.dim_products;
select count(distinct product_name) as total_products from gold_layer.dim_products;

-- Find the total number of customers
select count(customer_key) as total_customers from gold_layer.dim_customers;

-- Find the total number of customers that has placed an order
select count(distinct customer_key) from gold_layer.fact_sales;

-- Generte a report that shows all key metrics of the business

select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from gold_layer.fact_sales
UNION ALL
select 'Total Quantiy' as measure_name,sum(quantity) as measure_value from gold_layer.fact_sales
UNION ALL
select 'Average Price' as measure_name, round(avg(price), 0) as measure_value from gold_layer.fact_sales
UNION ALL
select 'Total Nr. Orders' as measure_name, count(distinct order_number) as measure_value from gold_layer.fact_sales
UNION ALL
select 'Total Nr. Products' as measure_name, count(product_name) as measure_value from gold_layer.dim_products
UNION ALL
select 'Total Nr. Customers' as measure_name, count(customer_key) as measure_value from gold_layer.dim_customers;

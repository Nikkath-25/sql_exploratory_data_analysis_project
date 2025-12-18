/*
Dimensions Exploration:
- Identify the unique values(or categories) in each dimension.
- Recognizing how data might be grouped or segmented, which is useful for later analysis.
For that we have:
SQL Keyword 'DISTINCT' with any '[Dimension]'.
*/

-- Explore all Countries our customers come from

select distinct country from gold_layer.dim_customers; 

-- Explore all Categories "The Major Divisions"

select distinct category, subcategory, product_name from gold_layer.dim_products;
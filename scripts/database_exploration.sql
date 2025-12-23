/*
Explore the structure of database using 'INFORMATION_SCHEMA'
*/

-- Explore all Objects in Database.
select * from information_schema.tables;

-- Explore all Tables in One Database
SELECT *
FROM information_schema.tables
WHERE table_schema = 'gold_layer';

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'gold_layer';

-- Explore all Columns in Database
SELECT *
FROM information_schema.columns
WHERE table_schema = 'gold_layer';

-- Explore all Columns in Table
select * from information_schema.columns
where table_schema = 'gold_layer'
and table_name = 'dim_customers'; 

-- For Quick Checks
show databases;
show tables from gold_layer;
describe gold_layer.dim_customers;

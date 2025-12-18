/*
Explore the structure of database 
*/

-- Explore all Objects in Database.
select * from information_schema.tables;

-- Explore all Columns in Database.
select * from information_schema.columns
where table_name = 'dim_customers'; 
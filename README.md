# SQL Exploratory Data Analysis Project

Welcome to the **SQL Exploratory Data Analysis Project** repository! 🚀  

This project showcases structured **exploratory data analysis (EDA) using SQL** on a sales dataset, focusing on understanding data distributions, key business metrics, and performance rankings.  
It is designed as a **portfolio project** to demonstrate practical SQL analytics skills.

---

## 📖 Project Overview

This project involves:

1. **Database Exploration** – Understanding tables, columns, and schema structure.
2. **Dimension Exploration** – Exploring customer and product attributes.
3. **Date Exploration** – Identifying data boundaries and customer age distribution.
4. **Measure Exploration** – Calculating key business metrics.
5. **Magnitude Analysis** – Comparing metrics across dimensions.
6. **Ranking Analysis** – Identifying top and bottom performers.
7. **Change-Over-Time Analysis** – Analyzing trends and seasonality in sales
8. **Cumulative Analysis** – Evaluating business growth using running totals
9. **Performance Analysis** – Comparing current performance against averages and prior periods
10. **Part-to-Whole Analysis** – Measuring category contribution to overall sales
11. **Data Segmentation** – Segmenting customers and products based on behavior and value

---

## 🏛️ Data Model

The analysis is built on a **star schema** consisting of:

- **dim_customers** – Customer demographics and attributes  
- **dim_products** – Product and category details  
- **fact_sales** – Transaction-level sales data  

- ![Gold Layer Sales Star Schema Model](docs/Gold_Layer_Sales_Star_Schema_Model.png)

---

## 📂 Repository Structure

- **datasets**
  - [dim_customers.csv](datasets/dim_customers.csv)
  - [dim_products.csv](datasets/dim_products.csv)
  - [fact_sales.csv](datasets/fact_sales.csv)

- **scripts**
  - [database_exploration.sql](scripts/database_exploration.sql)
  - [dimension_exploration.sql](scripts/dimension_exploration.sql)
  - [date_exploration.sql](scripts/date_exploration.sql)
  - [measure_exploration.sql](scripts/measure_exploration.sql)
  - [magnitude_analysis.sql](scripts/magnitude_analysis.sql)
  - [ranking_analysis.sql](scripts/ranking_analysis.sql)
  - [change_over_time_analysis.sql](scripts/change_over_time_analysis.sql)
  - [cumulative_analysis.sql](scripts/cumulative_analysis.sql)
  - [performance_analysis.sql](scripts/pereformance_analysis.sql)
  - [part_to_whole_analysis.sql](scripts/part_to_whole_analysis.sql)
  - [data_segmentation.sql](scripts/data_segmentation.sql)
  - [customer_report.sql](scripts/customer_report.sql)
  - [product_report.sql](scripts/product_report.sql)


- **docs**
  - [Gold Layer Sales Star Schema Model](docs/Gold_Layer_Sales_Star_Schema_Model.png)

- [README.md](README.md)

---

## 🔍 Analysis Focus

- Understanding database structure and schema
- Exploring dimensions and categorical distributions
- Identifying data time span and customer age boundaries
- Computing core business KPIs
- Comparing metrics across categories and regions
- Ranking products and customers by performance
- Tracking trends and seasonality (Change-Over-Time Analysis)
- Calculating cumulative totals over time (Cumulative Analysis)
- Comparing current metrics against benchmarks or previous periods (Performance Analysis)
- Determining contribution of parts to whole (Part-to-Whole Analysis)
- Grouping data into segments based on behavior or ranges (Data Segmentation)

---

# 🧑‍🤝‍🧑 Customer Report

## Purpose
- This report consolidates key customer metrics and behaviors.

## Highlights
1. Gathers essential fields such as names, ages, and transaction details.
2. Segments customers into categories (**VIP, Regular, New**) and age groups.
3. Aggregates customer-level metrics:
   - Total orders
   - Total sales
   - Total quantity purchased
   - Total products
   - Lifespan (in months)
4. Calculates key KPIs:
   - Recency (months since last order)
   - Average order value
   - Average monthly spend

---

# 📦 Product Report

## Purpose
- This report consolidates key customer metrics and behaviors.

## Highlights
1. Gathers essential fields such as product name, category, subcategory, and cost.
2. Segments products by revenue to identify **High-Performers, Mid-Range, or Low-Performers**. 
3. Aggregates product-level metrics:
   - Total orders
   - Total sales
   - Total quantity sold
   - Total customers(unique)
   - Lifespan (in months)
4. Calculates key KPIs:
   - Recency (months since last order)
   - Average order revenue
   - Average monthly revenue

---

## 🛠️ Technologies Used

- **MySQL**
- **SQL** (aggregations, joins, window functions, CTEs)
- **Git & GitHub**
- **VS Code**
- **CSV datasets**

---

## 🎯 Purpose of the Project

This project was created to:

- Strengthen SQL exploratory analysis skills  
- Practice analytical thinking using real-world datasets  
- Build a clean, recruiter-friendly SQL portfolio project  

---

## 🛡️ License

This project is licensed under the **MIT License**.  
You are free to use, modify, and share this project with proper attribution.

---

## ⭐ About Me

Hi, I’m **Syed Naveen Nikkath**, an aspiring Data Analyst with hands-on experience in SQL, Excel, Power BI, and Python fundamentals. I enjoy analyzing data and translating it into meaningful business insights.

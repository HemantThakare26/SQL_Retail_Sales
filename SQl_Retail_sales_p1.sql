-- SQL RETAIL SALES ANALYSIS --

create database sql_project_1 ;
use sql_project_1 ;

-- CREATE TABLE --

create table Retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

select * from Retail_sales 
limit 10 ;

select count(*) from Retail_sales ; 

-- checking every columns for null values --

Select * from Retail_sales
where 
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     age is null
     or
     category is null
     or
     quantiy is null
     or
     price_per_unit is null
     or
     cogs is null
     or
     total_sale is null
 ;
 
 -- Deleting data with null values -- 

Delete from Retail_sales
where 
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     age is null
     or
     category is null
     or
     quantiy is null
     or
     price_per_unit is null
     or
     cogs is null
     or
     total_sale is null
 ;

-- Data Exploration --

-- How many sales we have? --

Select count(*) as Total_Sales from Retail_sales ;

-- How many customers we have ? --

select count(Distinct customer_id) as Total_Customer from Retail_sales ; 

-- How many Categories we have ? --

select distinct category as Types_of_category from Retail_sales ; 

-- Data Analysis & Business key problems and Answers --

-- Q1. Write a SQl query to retrieve all columns for sales made on " 2022-11-5" --

select * from Retail_sales
where sale_date = "2022-11-05";

-- Q2. Write a SQL Query to retrieve all transactions where the category is " Clothing " and the Quantity sold 
-- is more than 10 in the month of " Nov-2022 " --
    
select * from Retail_sales
where category = 'Clothing'
     and date_format(sale_date,'%Y-%m')='2022-11'
     and quantiy >= 4 ;
     
-- Q3.write a SQL query to calculate the total sales for each category --

select category,
     sum(total_sale) as net_sale,
     count(*) as Total_orders
from Retail_sales
group by category ; 

-- Q4. write a SQL query to find the average age of customers who purchased items from ' Beauty' Category --

select category, avg(age) from Retail_sales 
where category = 'Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000 --

select * from Retail_sales
where total_sale > '1000'
order by total_sale  ; 

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,
     gender,
     count(transactions_id)
from Retail_sales
group by gender,category
order by category ; 

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sale_rank
    FROM Retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM monthly_sales
WHERE sale_rank = 1;

-- *Write a SQL query to find the top 5 customers based on the highest total sales ** --

select customer_id,
      sum(total_sale)as total_sales from Retail_sales
group by customer_id
order by total_sales desc
limit 5 ;

-- Write a SQL query to find the number of unique customers who purchased items from each category.: --

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as Unique_cust
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17): --

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- End of Project --
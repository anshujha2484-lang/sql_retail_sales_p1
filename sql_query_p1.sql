-- Retail Sales SQL Project P1
create Database SQL_Project_P1;

-- create Table
Create table Retail_Sales(
transactions_id int primary key	,
sale_date date,
sale_time time,
customer_id	int,
gender Varchar(15),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float ,
total_sale float);
select * from retail_sales;

select * from retail_sales
limit 10;

Select
 Count(*)
 from Retail_sales;

select * from retail_sales
 where transactions_id is null;
 
select * from retail_sales
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or
cogs is null
or 
total_sale is null;

delete from retail_sales
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
quantiy is null
or
cogs is null
or 
total_sale is null;

-- Data  Exploration
-- How Many  Sales we have ?
Select count(*) as total_sale from retail_sales;

-- How many customer we have?
select count(*) as Total_customers from retail_sales;

-- How many unique customers we have?
select count(distinct customer_id) as total_unique_customer from retail_sales;


select count(distinct category) as total_unique_category from retail_sales;

select distinct category from retail_sales;

-- Data Analysis & Business key problems & Answers 
-- My Analysis & Findings 
-- Q.1 Write a SQL query to retrieve all columns for sales made on ' 2022-11-14'
-- Ans. 
       select * from retail_sales 
           where sale_date= '2022-11-14';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the qauantity sold  is more than 4 in the month of NOV-2022.
-- Ans.
     
     select *
       from retail_sales 
     where category = 'Clothing'
       And
       To_Char(sale_date,'yyyy-mm')='2022-11'
       And
       quantiy >= 4
       ;
       
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. 
-- Ans.
       select
       category,
       sum(total_sale)as net_sale,
       count(*) as total_orders
       from retail_sales
       group by 1;
       
-- Q.4 Write a SQL query to find the average age of customers who purchase items from the 'Beauty' category.
-- Ans.
       select
       avg(age) as Avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. 
-- Ans.
       select* from retail_sales
       where total_sale > 1000;
       
-- Q.6 Write a SQL query to find the total number of transactios (transaction_id) made by each gender in each category. 
-- Ans.
      select category, gender,
      count(*) as total_trans
      from retail_sales
      group by 
      category,
      gender
      order by 1
      ;

-- Q.7 write a SQL query to calculate the average sale for each month. Find out best selling month in each year 
-- Ans.
     select 
           year,
            month,
            avg_sale
		from
        (
        select
           extract(year from sale_date) as year,
		   extract(month from sale_date) as month,
           avg(total_sale) as avg_sale,
           rank() over(partition by extract(year from sale_date) order by Avg(total_sale) desc)as rank_no
		   from retail_sales
           group by 1,2) as t1
           where rank_no = 1;
           -- order by 1,2,3 desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total salle
-- Ans.
       select
	     customer_id,
         sum(total_sale) as total_sales
       from retail_sales 
       group by 1
       order by 2 desc
       limit 5;
       
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category. 
select
  category,
  count( distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 & 17, Evening > 17)
-- Ans.
with hourly_sale
As
(
select *, 
       case 
          when extract(hour from sale_time)< 12 then 'Morning'
          when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
          else 'Evening'
		end as shift
from retail_sales
)
select 
     shift,
    count(*) as total_orders
from hourly_sale
group by shift
;

-- End of Project 



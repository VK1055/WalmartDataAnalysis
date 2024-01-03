create database walmart;
use walmart;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
select* from sales;


-- -------- --------- -------- Feature Engineering ----------------- ------------ ---------------------
----- Adding time_of_day column -----------
 Alter table sales add column time_of_day varchar (20);
 Update sales set time_of_day =
 (case when time between "00:00:00" and "12:00:00" then "Morning"
 when time between "12:01:00" and "16:00:00" then "Afternoon"
 else "Evening" end);
 alter table sales modify time_of_day varchar(20) after time;

----------------- day_name----------
alter table sales add column day_name varchar(20);
update sales set day_name = dayname(date);

-- ------- month_name --- --
alter table sales add column month_name varchar(20);
update sales set month_name = monthname(date);

alter table sales modify day_name varchar(20) after date;
alter table sales modify month_name varchar(20) after date;




-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------

-- How many unique cities does the data have?
select distinct city from sales;

-- In which city is each branch?
select distinct city,branch from sales;

-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?

select distinct product_line from sales;

-- What is the most selling product line

select sum(quantity), product_line from sales 
group by product_line order by product_line limit 1;

-- Which month generated the highest revenue?
SELECT
	month_name AS month,round(SUM(total),0) AS total_revenue
FROM sales GROUP BY month_name ORDER BY total_revenue limit 1;


-- What month had the largest COGS?
SELECT month_name AS month,round(SUM(cogs),0) AS cogs
FROM sales GROUP BY month_name ORDER BY cogs limit 1;


-- What product line had the largest revenue?
SELECT
	product_line,round(SUM(total),0) as total_revenue
FROM sales GROUP BY product_line ORDER BY total_revenue DESC limit 1;

-- What is the city with the largest revenue?
SELECT city,round(SUM(total),0) AS total_revenue
FROM sales GROUP BY city ORDER BY total_revenue limit 1;


-- What product line had the largest VAT?
SELECT product_line,concat(round(AVG(tax),0),"%") as avg_tax
FROM sales GROUP BY product_line ORDER BY avg_tax DESC limit 1;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

select round(avg(quantity),0) as average from sales;

select product_line,case when avg(quantity) > 5 then "Good" else "Bad" end as Remark
from sales group by product_line;

-- -- Which branch sold more products than average product sold?-- ----- 
select branch, sum(quantity) as quantity from sales group by branch 
having sum(quantity) >(select avg(quantity) from sales);

-- What is the most common product line by gender
(SELECT gender,product_line,COUNT(gender) AS total_cnt from sales where gender="female"
group by gender, product_line order by total_cnt DESC limit 2)
union
(SELECT gender,product_line,COUNT(gender) AS total_cnt from sales where gender="male"
group by gender, product_line order by total_cnt DESC limit 2);

-- What is the average rating of each product line
SELECT ROUND(AVG(rating), 1) as avg_rating,product_line FROM sales
GROUP BY product_line ORDER BY avg_rating DESC;

-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM sales;

-- How many unique payment methods does the data have?
SELECT DISTINCT payment_method FROM sales;


-- What is the most common customer type?
SELECT customer_type,count(*) as count FROM sales
GROUP BY customer_type ORDER BY count DESC limit 1;

-- Which customer type buys the most?
SELECT customer_type, COUNT(*)FROM sales GROUP BY customer_type;


-- What is the gender of most of the customers?
SELECT gender,COUNT(*) as gender_cnt FROM sales
GROUP BY gender ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT branch,COUNT(*) as gender_cnt FROM sales
GROUP BY branch ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT time_of_day, AVG(rating) as Avg_Rating FROM sales 
GROUP BY time_of_day ORDER BY Avg_Rating;

-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
(SELECT
	time_of_day, branch,
	AVG(rating) AS avg_rating
FROM sales
where branch="A"
GROUP BY time_of_day,branch
ORDER BY avg_rating DESC limit 1)
union
(SELECT
	time_of_day, branch,
	AVG(rating) AS avg_rating
FROM sales
where branch="B"
GROUP BY time_of_day,branch
ORDER BY avg_rating DESC limit 1)
union
(SELECT
	time_of_day, branch,
	AVG(rating) AS avg_rating
FROM sales
where branch="C"
GROUP BY time_of_day,branch
ORDER BY avg_rating DESC limit 1);



-- Which days fo the week has the best avg ratings?
SELECT day_name,AVG(rating) AS avg_rating FROM sales
GROUP BY day_name ORDER BY avg_rating DESC limit 3;

-- Mon, Tue and Friday are the top best days for good ratings

-- Which day of the week has the most sales per branch?

(SELECT 
	day_name, Branch,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "A"
GROUP BY day_name,branch
ORDER BY total_sales DESC LIMIT 1)
union
(SELECT 
	day_name, Branch,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "B"
GROUP BY day_name,branch
ORDER BY total_sales DESC LIMIT 1)
union 
(SELECT 
	day_name, Branch,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "c"
GROUP BY day_name,branch
ORDER BY total_sales DESC LIMIT 1);

-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- What is the highest number of sales made during each time of the day through out the week?
(SELECT
	day_name,time_of_day,
	COUNT(*) AS total_sales
FROM sales
where time_of_day ="Morning"
GROUP BY day_name,time_of_day
ORDER BY total_sales DESC limit 1)
union
(SELECT
	day_name,time_of_day,
	COUNT(*) AS total_sales
FROM sales
where time_of_day ="Afternoon"
GROUP BY day_name,time_of_day
ORDER BY total_sales DESC limit 1)
union
(SELECT
	day_name,time_of_day,
	COUNT(*) AS total_sales
FROM sales
where time_of_day ="Evening"
GROUP BY day_name,time_of_day
ORDER BY total_sales DESC limit 1);

-- Evenings experience most sales, the stores are filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT customer_type,round(SUM(total),0) AS total_revenue FROM sales
GROUP BY customer_type ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT city,concat(ROUND(AVG(tax), 0),"%") AS avg_tax FROM sales
GROUP BY city ORDER BY avg_tax DESC;

-- Which customer type pays the most in VAT?
SELECT customer_type, concat(round(AVG(tax),0),"%") AS total_tax
FROM sales GROUP BY customer_type ORDER BY total_tax;





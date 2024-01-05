# WalmartDataAnalysis

## Aim of the Project
This project aims to analyze Walmart's sales data to gain insights into the top-performing branches and products, track sales trends across different products, and understand customer behavior. The objective is to identify opportunities to enhance and optimize sales strategies.

## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                     | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method          | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

### Analysis List

1. Product Analysis

> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.


### Methodology

1. **Data Cleaning:** This is the first step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This will help use generate some new columns from existing ones.

> 1. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

> 2. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

> 3. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

3.**Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.

### Tools Used

Sql - Employed SQL queries and scripts to perform exploratory data analysis 

**SQL Code**
For the rest of the code, check the [Walmart.Sql](https://github.com/VK1055/WalmartDataAnalysis/blob/main/Walmart.sql) file

```` sql
-- Create database

create database walmart;
use walmart;

-- Create table

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
````

## Business Questions To Answer

### Generic Question
1.How many unique cities does the data have?
> The data consists of three unique cities: Yangon, Naypyitaw, and Mandalay.

2.In which city is each branch?
> Branch A is situated in Yangon, while Branch B is in Mandalay, and Branch C is positioned in Naypyitaw.

### Products

1. How many unique product lines does the data have?
> There are six exclusive product lines, namely Food and Beverages, Health and Beauty, Sports and Travel, Fashion Accessories, Home and Lifestyle, and Electronic Accessories.

2. What is the most selling product line?
> The top-selling product line was Electronics and Accessories, which recorded sales of 961 units, making it the most popular among the various product lines available.

3.Which month generated the highest revenue?
> The month of February recorded the highest revenue among all the months, accumulating a total revenue of 95,727 MMK.

4.What product line had the largest revenue?
> Food and Beverages product line had the highest revenue compared to other product lines, amounting to a total revenue of 56,145 MMK.

5.What is the city with the largest revenue?
> The city with the largest revenue is Mandalay, which generated a total revenue of 104,535 MMK.

6.What product line had the largest VAT?
> The product line "Sports and Travel" had the highest Value-Added Tax (VAT), averaging at 16%.

7.Which branch sold more products than average product sold?
> Branch A sold more products than the average quantity sold across all branches, with a total quantity of 1849 units.

8. What is the most common product line by gender?
> The leading product lines for females are fashion accessories and food and beverages, while for males, the predominant product lines are health and beauty followed by electronics accessories. These are the top two most frequent product line preferences categorized by gender.

9. What is the average rating of each product line?
>The average ratings for different product lines are as follows: Food and beverages received an average rating of 7.1, Health and beauty and Fashion accessories both attained an average rating of 7, while Sports and travel and Electronic accessories garnered an average rating of 6.9 each. Home and lifestyle received an average rating of 6.8.

### Customers
1. How many unique customer types does the data have?
> There are two customer types: normal and member

2. How many unique payment methods does the data have?
> There are three types of payment method:- credit card, e-wallet, cash

3. What is the gender of most of the customers?
> The number of male customers is 498, and the number of female customers is 497.

4.Which customer type buys the most?
> The customer type "member" appears to make the most purchases, with a count of 499, whereas the "normal" customer type has made 496 purchases.

5.Which days fo the week has the best avg ratings?
> The highest average ratings throughout the week are observed on Monday, followed closely by Friday, and then on Tuesday.

6.Which day of the week has the best average ratings per branch?
> The data indicates that, per branch, the following days of the week have the highest average ratings: Sunday for Branch A with a total sales of 52 units, Saturday for Branch B with a sale of 60, and Tuesday for Branch C with a sale of 54 units.

### Sales

1.What is the highest number of sales made during each time of the day through out the week?
> Throughout the week, the highest number of sales occurred at specific times of the day: On Tuesday mornings, there were 36 sales; Wednesday afternoons recorded 61 sales, and Saturday evenings reached a peak of 81 sales.

2. Which of the customer types brings the most revenue?
> The customers who are members of Walmart bring in the most revenue, totaling 163,625 MMK, compared to the 'Normal' customer type, which generated a total revenue of 157,261 MMK.

3.Which city has the largest tax/VAT percent
> Naypyitaw has the highest VAT rate at 16% among all cities.

4.Which customer type pays the most in VAT?
> The 'member' customer type contributes the highest VAT payment at 16% compared to other customer types.


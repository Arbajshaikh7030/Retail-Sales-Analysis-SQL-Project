CREATE DATABASE RETAIL_SALES;


USE RETAIL_SALES;

-- 1. Total Revenue Generated
SELECT 
    SUM(total_sale) AS total_revenue
FROM retail_sales;


-- 2. Top Selling Product Categories
SELECT 
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;


-- 3. Monthly Sales Performance
SELECT 
    MONTH(sale_date) AS month_no,
    MONTHNAME(sale_date) AS month_name,
    SUM(total_sale) AS monthly_sales
FROM retail_sales
GROUP BY month_no, month_name
ORDER BY month_no;


-- 4. Best Customers by Revenue
SELECT 
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- 5. Sales by Gender
SELECT 
    gender,
    SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY gender;


-- 6. Average Customer Age by Category
SELECT 
    category,
    ROUND(AVG(age),2) AS avg_age
FROM retail_sales
GROUP BY category;


-- 7. Highest Single Transaction
SELECT *
FROM retail_sales
ORDER BY total_sale DESC
LIMIT 1;


-- 8. Peak Sales Hours Analysis
SELECT 
    HOUR(sale_time) AS sales_hour,
    COUNT(*) AS total_orders,
    SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY sales_hour
ORDER BY revenue DESC;


-- 9. Running Total Sales (Window Function)
SELECT 
    sale_date,
    SUM(total_sale) AS daily_sales,
    SUM(SUM(total_sale)) OVER (ORDER BY sale_date) AS running_total
FROM retail_sales
GROUP BY sale_date;


-- 10. Rank Categories by Revenue
SELECT 
    category,
    SUM(total_sale) AS revenue,
    RANK() OVER (ORDER BY SUM(total_sale) DESC) AS category_rank
FROM retail_sales
GROUP BY category;


-- 11. Profit Analysis
SELECT 
    category,
    SUM(total_sale - cogs) AS profit
FROM retail_sales
GROUP BY category
ORDER BY profit DESC;


-- 12. Customer Segmentation
SELECT 
    CASE
        WHEN age < 25 THEN 'Young'
        WHEN age BETWEEN 25 AND 45 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY age_group;

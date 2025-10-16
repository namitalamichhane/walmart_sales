CREATE DATABASE walmart_db;
USE walmart_db;

SELECT COUNT(*) FROM walmart;
SELECT * FROM walmart LIMIT 10
SELECT
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

SELECT
    branch,
    category,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 2 DESC;

#identifying the busiest day

SELECT
    branch,
    DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
    COUNT(*) AS total_transactions
FROM walmart
GROUP BY branch, day_name
ORDER BY branch, total_transactions DESC;

# Finding different payment method and number of transactions, number of qty sold

SELECT
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

#Avg, min, max rating of category for each city listing the city,
# average_rating, min_rating, and max_rating

SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY 1, 2; 

# Total profit for each category by considering total_profit as 
#(unit_price * quantity * profit_margin)

SELECT
    category,
    SUM(total * profit_margin) AS profit
FROM walmart
GROUP BY 1;

#Most common payment method of each branch

SELECT
  branch,
  payment_method,
  COUNT(*) AS total_trans,
  RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank_
FROM walmart
GROUP BY branch, payment_method;
    
# Categorizing sales into groups ( morning, afternoon, evening)

SELECT
    branch,
    date,
    `time`,
    CASE
        WHEN HOUR(`time`) < 12 THEN 'Morning'
        WHEN HOUR(`time`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM walmart;


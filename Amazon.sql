
SELECT * FROM AmazonCS

-- Q.1 How does the discount percentage affect the rating of a product?
SELECT rating, COUNT(*) as count
FROM AmazonCS
GROUP BY rating
ORDER BY COUNT DESC;



-- Q.2 Which category has the highest average rating?
SELECT Primary_category, ROUND(AVG(rating),1) as Mean_rating
FROM AmazonCS
GROUP BY Primary_category
ORDER BY Mean_rating DESC;



-- Q.3 Is there a correlation between the product's price and its rating?
-- The Price_group column was initially created during the Python data processing stage. 
--This column was then imported into the current SQL script for further analysis. 
--In this instance, an attempt was made to create a new Price_group column within the SQL environment to test functionality; however, 
--it was determined that the column already existed due to the prior import
SELECT 
  CASE
    WHEN actual_price BETWEEN 39 AND 10038 THEN '39-10038'
    WHEN actual_price BETWEEN 10039 AND 20038 THEN '10039-20038'
    WHEN actual_price BETWEEN 20039 AND 30038 THEN '20039-30038'
    WHEN actual_price BETWEEN 30039 AND 40038 THEN '30039-40038	'
    WHEN actual_price BETWEEN 40039 AND 50038 THEN '40039-50038'
	WHEN actual_price BETWEEN 50039 AND 60038 THEN '50039-60038'
	WHEN actual_price BETWEEN 60039 AND 70038 THEN '60039-70038'
	WHEN actual_price BETWEEN 70039 AND 80038 THEN '70039-80038'
	WHEN actual_price BETWEEN 80039 AND 90038 THEN '80039-90038	'
	WHEN actual_price BETWEEN 130039 AND 140038 THEN '130039-140038	'
  END AS Price_groupp,
  COUNT(*) AS counts
FROM AmazonCS
GROUP BY actual_price
ORDER BY Price_groupp;

SELECT Price_group, COUNT(*) as Count
FROM AmazonCS 
WHERE Price_group IS NOT NULL
GROUP BY Price_group
ORDER BY Count DESC;




-- Q.4 What is the distribution of ratings across all products?
SELECT rating, COUNT(*) as Rating_counts
FROM AmazonCS
GROUP BY rating
ORDER BY Rating_counts DESC;




-- Q.5 Which product has the highest number of reviews and what is its rating?
SELECT product_name, ROUND(AVG(rating),1) as Avg_product_rating
FROM AmazonCS
GROUP BY product_name
ORDER BY Avg_product_rating DESC;




-- Q.6 Identify the top 5 users who have given the most reviews?
SELECT TOP (5) user_id, COUNT(review_id) as review_counts
FROM AmazonCS
GROUP BY user_id
ORDER BY review_counts DESC;




-- Q.7 Is there a correlation between the length of a review and the rating given?

-- Step 1: Calculate the averages
WITH AvgValues AS (
    SELECT 
        AVG(CAST(review_length AS FLOAT)) AS avg_length,
        AVG(CAST(rating AS FLOAT)) AS avg_rating
    FROM AmazonCS
),

-- Step 2: Calculate the components needed for correlation
Covariance AS (
    SELECT 
        SUM((CAST(review_length AS FLOAT) - avg_length) * (CAST(rating AS FLOAT) - avg_rating)) AS covariance,
        SUM(POWER(CAST(review_length AS FLOAT) - avg_length, 2)) AS variance_length,
        SUM(POWER(CAST(rating AS FLOAT) - avg_rating, 2)) AS variance_rating
    FROM AmazonCS, AvgValues
)

-- Step 3: Calculate the Correlation
SELECT 
    covariance / SQRT(variance_length * variance_rating) AS correlation
FROM Covariance;




-- Q.8 Can the length of the product description be correlated to the product's rating?

WITH AvgValues AS (
    SELECT 
        AVG(CAST(product_description_len AS FLOAT)) AS avg_product_len,
        AVG(CAST(rating AS FLOAT)) AS avg_rating
    FROM AmazonCS
),

Covariance AS (
    SELECT 
        SUM((CAST(product_description_len AS FLOAT) - avg_product_len) * (CAST(rating AS FLOAT) - avg_rating)) AS covariance,
        SUM(POWER(CAST(product_description_len AS FLOAT) - avg_product_len, 2)) AS variance_length,
        SUM(POWER(CAST(rating AS FLOAT) - avg_rating, 2)) AS variance_rating
    FROM AmazonCS, AvgValues
)

SELECT 
    covariance / SQRT(variance_length * variance_rating) AS correlation
FROM Covariance;



select * from AmazonCS

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



-- Q.4 What is the most common word in the positive and negative reviews?
-- Assuming your table is called 'Reviews' and has 'ReviewText' and 'Sentiment' columns


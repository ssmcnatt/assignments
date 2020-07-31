-- In the final checkpoint in this module, you'll complete a challenge. You'll use the ksprojects table from the kickstarterprojects database in the shared Thinkful server and write SQL queries to answer the following questions.
SELECT * FROM ksprojects;

-- 2) How many distinct values are there in the "country" field?
SELECT COUNT(DISTINCT country)
FROM ksprojects;

-- 3) Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted from high to low. What is the numerical value of the first row in the returned dataset?
SELECT main_category,
	   ROUND(AVG(backers), 0) AS avg_backers
FROM ksprojects
GROUP BY main_category
ORDER BY avg_backers DESC;

-- 4) Write a query that shows, for each category, how many campaigns were successful and the average difference per project between dollars pledged and the goal for successful campaigns in that category. Which category raised the most (pledged) above and beyond its goal amount?
SELECT main_category
	   ,COUNT(*) AS num_campaigns
	   ,SUM(pledged - goal)::NUMERIC AS sum_goal
FROM ksprojects
WHERE state = 'successful'
GROUP BY main_category
ORDER BY sum_goal DESC;

-- 5) Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers. How many "Publishing" projects meet this criteria? 
SELECT main_category
	   ,COUNT(*) AS num_projects
FROM ksprojects
WHERE state = 'successful' AND backers BETWEEN 5 AND 10
GROUP BY main_category;

-- 6) Excluding Games and Technology records in the main_category field, return the total of all backers for successful projects by main_category where the total number of backers was over 100,000.  Sort by main_category from A-Z. How many backers does the first record have?
SELECT main_category
	   ,SUM(backers) AS sum_backers
FROM ksprojects
WHERE main_category NOT IN ('Games', 'Technology')
	  AND state = 'successful'
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category;
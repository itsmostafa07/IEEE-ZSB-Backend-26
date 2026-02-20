-- 1 Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

-- 2 Fix Names in a Table
SELECT user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;

-- 3 Calculate Special Bonus
SELECT employee_id, IF(employee_id % 2 != 0 AND name NOT LIKE 'M%', salary ,0) AS bonus
FROM Employees
ORDER BY employee_id;
    
-- 4 Patients With a Condition
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%';

-- 5 Find Total Time Spent by Each Employee
SELECT event_day AS day, emp_id, SUM(out_time - in_time) AS total_time
FROM Employees
GROUP BY event_day, emp_id;

-- 6 Find Followers Count
SELECT user_id, COUNT(follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

-- 7 Daily Leads and Partners
SELECT date_id, make_name, COUNT(DISTINCT lead_id) as unique_leads, COUNT(DISTINCT partner_id) as unique_partners
FROM DailySales
GROUP BY date_id, make_name;

-- 8 Actors and Directors Who Cooperated At Least Three Times
SELECT DISTINCT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(director_id) >= 3;

-- 9 Classes With at Least 5 Students
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

-- 10 Game Play Analysis I
SELECT player_id, MIN(event_date) as first_login
FROM Activity
GROUP BY player_id;

-- 11 Capital Gain/Loss
SELECT stock_name, SUM(
    CASE
        WHEN operation = 'Buy' THEN -price
        ELSE price
    END
) AS capital_gain_loss FROM Stocks
GROUP BY stock_name;

-- 12 Second Highest Salary
SELECT MAX(salary) as SecondHighestSalary
FROM Employee
WHERE Employee.salary < (SELECT MAX(salary) FROM Employee);
-- Duplicate Emails
SELECT DISTINCT email AS Email
FROM Person
GROUP BY email
HAVING count(email) > 1;

-- Delete Duplicate Emails
DELETE p1 FROM Person p1
JOIN Person p2 ON p1.email = p2.email AND p1.id > p2.id;

-- Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
        );
END

-- Rank Scores
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores
ORDER BY score DESC;

-- Department Highest Salary
SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
JOIN (
    SELECT departmentId, MAX(salary) AS max_salary 
    FROM Employee 
    GROUP BY departmentId
) t ON e.departmentId = t.departmentId AND e.salary = t.max_salary;
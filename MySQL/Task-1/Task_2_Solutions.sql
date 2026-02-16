-- Recyclable and low fat products
SELECT product_id
FROM Products 
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Big countries
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

-- Find customer referee
SELECT name
FROM Customer
WHERE  referee_id != 2 OR referee_id IS NULL;
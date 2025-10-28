USE world;

SELECT * FROM country;

SELECT * FROM country ORDER BY Population DESC;

SELECT * FROM country ORDER BY Name DESC;

SELECT * FROM country  
ORDER BY Continent, Population DESC;

SELECT * FROM country country
WHERE Continent = 'Asia'
ORDER BY GNP;

SELECT * FROm country
ORDER BY Population DESC
LIMIT 5;

SELECT * FROM country
ORDER BY Population DESC
LIMIT 5 OFFSET 10;

SELECT * FROM country
ORDER BY Population DESC
LIMIT 5, 10;
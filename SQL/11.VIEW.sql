USE world;

CREATE VIEW large_county AS 
SELECT * FROM country WHERE population >= 50000000;

SELECT * FROM large_county;

CREATE VIEW country_view AS
SELECT co.Name AS co_name, ci.Name AS ci_name
FROM country co INNER JOIN city ci
ON co.Code = ci.CountryCode;

SELECT * FROM country_view;

SHOW FULL TABLES;
SHOW FULL TABLES WHERE TABLE_type = "VIEW";

DROP VIEW large_county;
DROP VIEW country_view;
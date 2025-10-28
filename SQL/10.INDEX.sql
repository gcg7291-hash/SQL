USE world;

SHOW INDEX FROM city;

DESCRIBE city;

CREATE INDEX idx_city_name ON city(Name);
EXPLAIN SELECT * FROM city WHERE Name= 'SEOUL';

SHOW INDEX FROM city;

DROP INDEX idx_city_name ON city;


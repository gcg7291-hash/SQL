USE world;

-- 서울 인구
SELECT Population FROM city WHERE Name = 'SEOUL';

-- 서울 인구보다 많은 도시
SELECT
*
FROM city
WHERE Population > (SELECT Population FROM city WHERE Name = 'SEOUL');

SELECT
	Name, Population
FROM country
WHERE Population > (SELECT AVG(population) From country)
ORDER BY Population DESC;

SELECT Code FROM country WHERE Continent = 'ASia';

SELECT
	Name, CountryCode, Population
FROM city
WHERE CountryCode IN (SELECT Code FROM country WHERE Continent = 'ASia');


-- distinct 중복된 값을 제거하고 고유한 값만 조회할때 사용
SELECT 
distinct CountryCode
FROM city;

SELECT
*
FROM country
WHERE Code NOT IN (SELECT 
distinct CountryCode
FROM city);

SELECT
*
FROM (
	SELECT Continent, COUNT(*) AS co_count FROM country GROUP BY Continent
) AS Continent_talble
WHERE co_count > 40;



-- 평균 대여료(`rental_rate`)보다 비싼 영화를 조회하세요.
-- - 영화 제목, 대여료. 대여료 내림차순 정렬
-- - 상위 10개
USE sakila;

SELECT 
 AVG(rental_rate)
 FROM film;

SELECT
	title,
    rental_rate
FROM film
WHERE rental_rate > (SELECT 
 AVG(rental_rate)
 FROM film)
ORDER BY rental_rate DESC
LIMIT 10; 

-- 'Action' 카테고리에 속한 영화를 조회하세요.
-- - 영화 제목
SELECT
category_id
FROM category
WHERE Name = 'Action';

SELECT
film_id
FROM film_category
WHERE category_id = (SELECT
category_id
FROM category
WHERE Name = 'Action');


SELECT
title
FROM film
WHERE film_id IN (SELECT
film_id
FROM film_category
WHERE category_id = (SELECT
category_id
FROM category
WHERE Name = 'Action'));

-- 대여 기록이 있는 고객만 조회하세요.
-- - 고객 이름 (first_name, last_name), 이메일
SELECT * FROM rental;

SELECT 
 first_name, last_name, email
FROM customer
WHERE 
	EXISTS (SELECT * FROM rental WHERE customer.customer_id = rental.customer_id);


-- 고객별 대여 횟수를 구한 뒤, 대여 횟수가 30회 이상인 고객만 조회하세요.
-- - 고객 이름, 대여 횟수, 대여 횟수 내림차순
SELECT
	customer.customer_id,
    customer.last_name,
    COUNT(*)
FROM customer LEFT JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
HAVING COUNT(*) >= 30
ORDER BY COUNT(*) DESC;

SELECT
c.last_name,
 c.customer_id,
 COUNT(*)
FROM customer c INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

SELECT
 c_name, c_id, c_count
FROM (
SELECT
c.last_name AS c_name,
 c.customer_id AS c_id,
 COUNT(*) AS c_count
FROM customer c INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
) AS customer_rental
WHERE c_count >= 30
ORDER BY c_count DESC;

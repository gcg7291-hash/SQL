USE world;

SELECT * FROM city WHERE countrycode = 'KOR';
SELECT * FROM country WHERE Code = 'KOR';

SELECT
	ci.Name AS 도시명,
    co.Name AS 나라이름,
    co.Continent AS 대륙,
    ci.Population AS 도시인구,
    Co.Population AS 국가인구,
    ci.Population / co.Population AS 도시인구비율
FROM city ci INNER JOIN country co 
ON ci.CountryCode = co.Code
WHERE co.Name = 'South Korea';


SELECT
	co.Name,
    COUNT(*)
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY COUNT(*) DESC;

SELECT
	co.Continent,
    COUNT(*),
    AVG(ci.Population)
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Continent;

SELECT
 COUNT(DISTINCT co.Code) AS '전체국가수_join',
 (SELECT COUNT(*) FROM country) AS '전체국가수_country'
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code;

SELECT
	*
FROM country co LEFT JOIN city ci
ON co.Code =  ci.CountryCode
ORDER BY co.Population;


SELECT * FROM city;
SELECT 
	c1.Name,
    c2.Name
FROM city c1 INNER JOIN city c2
ON c1.CountryCode = c2.CountryCode AND c1.ID < c2.ID
WHERE c1.CountryCode = "KOR";

SELECT
	*
FROM country co INNER JOIN city ci ON co.Code = ci.CountryCode
				INNER JOIN countrylanguage cl ON ci.CountryCode = cl.CountryCode;
                
                
-- 영화(`film`)와 언어(`language`) 테이블을 조인하여 다음을 조회하세요:
USE sakila;
SELECT * FROM film;
-- - 영화 제목 (`film.title`), 언어 이름 (`language.name`)

SELECT 
	fi.title,
    la.Name
FROM film fi INNER JOIN language la
ON fi.language_id = la.language_id;

-- 영화와 카테고리를 조인하여 다음을 조회하세요:
-- - 영화 제목, 카테고리 이름, 대여료
SELECT
	fi.title,
    ca.Name,
    fi.rental_rate
FROM film fi INNER JOIN film_category fc
ON fi.film_id = fc.category_id
INNER JOIN category ca ON ca.category_id = fc.film_id;

-- 모든 고객(`customer`)과 그들의 대여 내역(`rental`)을 조회하세요.
-- - 고객 이름 (first_name, last_name), 대여 ID (rental_id), 대여 날짜 (rental_date)
SELECT 
	cs.first_name,
    re.rental_id,
    re.rental_date
FROM customer cs LEFT JOIN rental re
ON cs.customer_id = re.customer_id; 

-- 고객별 대여 횟수를 조회하세요. (대여 횟수 0인 고객도 포함)
-- - 고객 이름, 대여 횟수, 대여 횟수가 많은 순서
SELECT	
	cs.customer_id,
    cs.last_name,
    COUNT(*)
FROM customer cs LEFT JOIN rental re
ON cs.customer_id = re.customer_id
GROUP BY cs.customer_id
ORDER BY COUNT(*);
-- 같은 상영 시간(`length`)을 가진 영화 쌍을 찾으세요.
-- - 영화1 제목, 영화2 제목, 상영 시간, 상위 10개
SELECT * FROM rental;
SELECT
	f1.title, f2.title, f1.length
FROM film f1 INNER JOIN film f2
ON f1.length = f2.length
ORDER BY f1.length DESC
LIMIT 10;
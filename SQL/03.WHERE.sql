USE world;

SELECT * FROM country WHERE Code = 'AFG';
SELECT * FROM country WHERE Name = 'South Korea';
SELECT * FROM country WHERE Continent = 'Asia';

SELECT * FROM country WHERE LifeExpectancy >= 80;
SELECT * FROM country WHERE GNP < 10000;

SELECT * FROM country WHERE Continent = 'Asia' And Population >= 100000000;
SELECT * FROM country WHERE Continent = 'Europe' OR Continent = 'North America';

SELECT * FROM country WHERE Continent != 'Asia';
SELECT * FROM country WHERE NOT continent = 'Asia';

SELECT Name, Continent, Population
FROM country
WHERE (Continent = 'Asia' AND Population >= 50000000)
   OR (Continent = 'Europe' AND Population >= 10000000)
ORDER BY Population DESC;

SELECT * FROM country WHERE LifeExpectancy >= 70 AND LifeExpectancy <= 80;
-- between 이상 이하 위 코드랑 같음
SELECT * FROM country WHERE LifeExpectancy BETWEEN 70 AND 80;

-- 문자에서 사용 가능 
SELECT * FROM country WHERE Continent In ('Asia', 'Europe');

SELECT * FROM country WHERE Name LIKE 'South%';
SELECT * FROM country WHERE Name LIKE '%states%';
SELECT * FROM country WHERE Name LIKE '_____';
SELECT * FROM country WHERE Name LIKE '___land';

SELECT * FROM country;

-- SELECT * FROM country WHERE GNPOld = NULL;  X
SELECT * FROM country WHERE GNPOld IS NULL;
SELECT * FROM country WHERE IndepYear IS NOT NULL;

-- 대여료(`rental_rate`)가 4달러 이상인 영화의 제목과 대여료 조회
-- 상영시간(`length`)이 120분 미만인 영화 조회
-- 등급(`rating`)이 'PG-13'인 영화 조회
-- 등급이 'PG'이고 대여료가 3달러 이상인 영화
-- 등급이 'G' 또는 'PG'인 영화
-- 상영시간이 60분 미만이거나 180분 이상인 영화
-- 제목에 'LOVE'가 포함된 영화 조회
-- 제목이 'THE'로 시작하는 영화 조회
-- 배우 성(`last_name`)이 'SON'으로 끝나는 배우 조회
-- 등급이 'PG-13'인 영화 중에서 대여료가 2.99달러 이상 4.99달러 이하이고, 상영시간이 90분 이상인 영화




USE sakila;
SELECT * FROM film;
SELECT title, rental_rate FROM film WHERE rental_rate >= 4;
SELECT * FROM film WHERE length < 120;
SELECT * FROM film WHERE rating = 'PG-13';
SELECT * FROM film WHERE rating = 'PG' AND rental_rate >= 3;
SELECT * FROM film WHERE rating = 'G' OR rating = 'PG';
SELECT * FROM film WHERE length < 60 OR length >= 180;
SELECT * FROM film WHERE title LIKE '%LOVE%';
SELECT * FROM film WHERE title LIKE 'THE%';
SELECT * FROM film 
WHERE rating = 'PG-13' 
AND rental_rate BETWEEN 2.99 And 4.99 And length >= 90;

SELECT * FROM actor WHERE last_name LIKE '%SON';
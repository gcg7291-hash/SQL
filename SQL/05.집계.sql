USE world;

SELECT * FROM country;

SELECT COUNT(*) AS 총국가수 FROM country;

SELECT COUNT(LifeExpectancy) FROM country;

SELECT COUNT(DISTINCT Region) From country;

SELECT SUM(Population) FROM country;

SELECT SUM(Population) FROM country 
WHERE Continent = 'Asia';

SELECT SUM(Population) FROM country
WHERE Population >= 100000000;


SELECT ROUND(SUM(SurfaceArea) / 10000, 2) FROM country;

SELECT AVG(Population) FROM country;
SELECT AVG(Population) FROM country
WHERE Continent = 'Asia';

SELECT * FROM country
WHERE Population = (SELECT MAX(Population) From country);

(SELECT MAX(Population) From country);

SELECT
	COUNT(*),
    SUM(Population),
    AVG(Population),
    Max(Population),
    MIN(Population)
FROM country;

SELECT LifeExpectancy From country;

SELECT AVG(LifeExpectancy) FROM country;
SELECT AVG(COALESCE(LifeExpectancy, 50)) FROM country;


-- film 데이터 집계 연습
USE sakila;
SELECT * FROM film;
-- 전체 영화 개수
SELECT COUNT(*) FROM film;
-- 등급(rating)이 'PG'인 영화 개수
SELECT COUNT(rating) FROM film WHERE rating = 'PG'; 
-- 서로 다른 등급(rating)의 개수
SELECT COUNT(DISTINCT rating) FROM film;
-- 모든 영화의 대여료(rental_rate) 합계
SELECT SUM(rental_rate) FROM film;
-- 모든 영화의 평균 대여료 (소수점 둘째 자리)
SELECT ROUND(AVG(rental_rate), 2) FROM film;
-- 등급이 'R'인 영화의 평균 대여료
SELECT AVG(rental_rate) FROM film WHERE rating= 'R';
-- 가장 비싼 대여료와 해당 영화 제목
SELECT title FROM film
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);
-- 가장 긴 상영 시간(length)과 해당 영화 제목
SELECT length, title FROM film
WHERE length = (SELECT MAX(length) FROM film);
-- 가장 짧은 상영 시간과 해당 영화 제목
SELECT length, title FROM film
WHERE length = (SELECT MIN(length) FROM film);
-- film 테이블의 다음 통계를 한 번에 조회하세요 
-- 		전체 영화 수, 총 대여료 합계, 평균 대여료, 최고 대여료, 최저 대여료, 평균 상영 시간
SELECT 
	COUNT(*),
    SUM(rental_rate),
    AVG(rental_rate),
    MAX(rental_rate),
    MIN(rental_rate),
    AVG(length)
FROM film;
USE world;

SELECT 
	Name, Continent, 
	CASE Continent
		WHEN 'Asia' THEN '아시아'
        WHEN 'Europe' THEN '유럽'
		ELSE 'etc'
	END
FROM country;

SELECT 
	Name, 
	Population,
    CASE
		WHEN Population >= 100000000 THEN '큰 국가' 
        WHEN Population >= 50000000 THEN '중간국가'
        ELSE '소국'
	END
FROM country;

SELECT 
	Name, Population, GNP,
	CASE
    WHEN (GNP * Population) >= 10000  THEN '선진국'
    ELSE '후진국'
    END
FROM country;

SELECT 
	Name, Population, Continent

FROM country
WHERE Population >=
CASE Continent
	WHEN 'Asia' THEN 50000000
    WHEN 'Europe' THEN 30000000
    ELSE 10000000
END;


SELECT 
	Name, Continent, Population, GNP
    FROM country
    ORDER BY 
    CASE Continent
    WHEN 'Asia' THEN Population
    WHEn 'Europe' THEN GNP
    ELSE Population
    ENd;
    
SELECT
	Continent, COUNT(*),
    SUM(CASE WHEN Population > 50000000 THEN 1 ELSE 0 END)
FROM country
GROUP BY Continent
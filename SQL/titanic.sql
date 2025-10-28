USE temp;
-- 타이타닉 테이블에서 모든 컬럼의 상위 5개 행을 조회하세요.
SELECT * FROM titanic LIMIT 5;

-- 타이타닉 테이블의 전체 승객 수를 조회하세요. (결과 컬럼명: row_count)
SELECT COUNT(*) FROM titanic;

-- cabin 컬럼의 결측치(빈 문자열) 개수를 조회하세요.
SELECT 
    SUM(CASE WHEN Cabin = "" THEN 1 ELSE 0 END)
FROM titanic;


-- 요금(fare)의 최솟값, 최댓값, 평균값을 조회하세요.
SELECT 
	MAX(fare),
    MIN(fare),
	ROUND(AVG(fare), 2)
FROM titanic;

-- 1등석(pclass = 1) 승객의 이름(name), 티켓(ticket), 요금(fare)을 조회하세요.
SELECT
 Name, Ticket, Fare, Pclass
 FROM titanic WHERE Pclass = 1;
 
 -- 셰르부르 항구(embarked = 'C')에서 탑승한 승객의 모든 정보를 조회하세요.
 SELECT * FROM titanic WHERE Embarked = 'C';
	
-- 30세 미만이면서 생존한 승객의 이름(name), 나이(age), 성별(sex)을 조회하세요.
SELECT
	Name, Age, Sex 
    FROM titanic
    WHERE Age <= 30 AND Survived= 1;
    
 -- 모든 승객을 요금이 비싼 순서로 정렬하여 조회하세요.
 SELECT
	Name, Pclass, Fare
FROM titanic
ORDER BY Fare DESC;

-- 1등석 여성 승객의 이름(name), 나이(age), 요금(fare)을 조회하세요.
SELECT
	Name, Age, fare, Pclass
FROM titanic
where Pclass = 1 AND sex = 'female'
order by age;

-- 전체 생존율 (소수점 둘째 자리까지 백분율로 표시)
SELECT ROUND(AVG(Survived) * 100, 2) FROM titanic;

-- 생존 여부별 승객 수
SELECT COUNT(Survived), survived FROM titanic group by Survived;

-- 성별로 다음 정보를 조회하세요: 총 승객 수, 생존자 수 , 생존율 (소수 둘째) , 생존율이 높은 순서로 정렬
SELECT 
sex,
	COUNT(*),
    SUM(Survived),
    ROUND(AVG(Survived) * 100 ,2) as percent
 FROM titanic
 group by Sex
 order by percent desc;
 
-- 등급별 생존율
SELECT
	Pclass, 
ROUND(AVG(Survived)*100,2)    
FROM titanic
GROUP By Pclass;

-- 등급별 평균 요금, 최소 요금, 최대 요금
SELECT
	Pclass,
	AVG(Fare),
    Min(Fare),
    Max(Fare)
FROm titanic
GROUP BY Pclass;

-- 탑승 항구와 등급별로 승객 수를 조회하세요.
SELECT 
	Embarked, 
    SUM(Pclass),
    pclass,
    COUNt(*)
FROM titanic
WHERE Embarked != ''
group by pclass, embarked
order by embarked, pclass;

-- 등급과 성별로 다음 정보를 조회하세요: 총 승객 수 , 생존자 수,  생존율 (백분율) / 등급 성별 순서로 정렬
SELECT
	COUNT(sibsp),
    SUm(Survived),
    ROUND(AVG(SUrvived)*100,2),
    Pclass,
    Sex
FROM titanic
GROUP BY Pclass, SEx
ORDER BY Pclass ASC , SEX desc;

-- 혼자 vs 가족동반 생존율 비교
SELECT
	CASE
		WHEN (sibsp + parch) = 0 THEN '혼자'
        ELSE '가족'
        END AS family_status,
        COUNT(*),
        AVG(survived)
FROM titanic
GROUP BY family_status;

SELECT 
	count(*),
    AVG(survived)
FROM titanic
WHERE sibsp > 0 OR parch > 0;
-- 가족 1명이라도 있는 승객의 평균 생존율
SELECT
	(1 + sibsp + parch) AS family_size,
    COUNT(*),
    AVG(survived)
FROM titanic
GROUP BY family_size
ORDER BY family_size;

-- 연령대를 구분하여 생존율 조회 18세 미만 - child , 18~ 60 - adult - 60> senior
SELECT 
    CASE
    WHEN age < 18 THEN 'Child'
    WHEN age <= 60 THEN 'Adult'
    WHEN age > 60 THEN 'Senior'
    ELSE '귀신'
    END AS addAge,
    SUM(Survived),
    COUNT(*)
FROM titanic
GROUP BY addAge
ORDER BY (SUM(Survived / 100) / COUNT(*)) DESC;

-- 요금을 다음 구간으로 분류하고 생존율을 조회하세요:
-- 10달러 미만 → '저가(<10)'
-- 10-30달러 → '중저가(10-29)'
-- 30-100달러 → '중고가(30-99)'
-- 100달러 이상 → '고가(100+)'
-- 요금 구간 순서로 정렬
SELECT
	CASE
		WHEN fare <10 THEN '저가'
        WHEN fare <30 THEN '중저가' 
        WHEN fare < 100 THEN '중고가'
        ELSE '고가'
	END AS fare_band,
    COUNT(*),
    ROUND(AVG(survived)*100, 2)
FROM titanic
GROUP BY fare_band
ORDER BY 
	CASE fare_band
		WHEN '저가' THEN 1
        WHEN '중저가' THEN 2
        WHEN '중고가' THEN 3
        ELSE 4
	END;

-- 평균 요금이 50달러가 넘는 등급 (HAVING)
SELECT
	pclass,
    count(*),
    Avg(fare)
FROM titanic
GROUP BY pclass
Having Avg(fare) > 50;
	
    
-- 전체 평균 요금보다 많이 낸 승객 (서브쿼리)
SELECT
	name, pclass, fare
FROM titanic
WHERE fare > (SELECT AVG(fare)  FROM titanic)
ORDER BY fare DESC
LIMIT 20;

-- 3등석 평균 나이보다 많은 1등석 승객 (서브쿼리)
SELECT AVG(age)
FROM titanic
WHERE pclass = 3;

SELECT
	name, pclass, fare
FROM titanic
WHERE pclass = 1 AND age >  (SELECT AVG(age)
FROM titanic
WHERE pclass = 3)
ORDER BY age DESC
LIMIT 20;
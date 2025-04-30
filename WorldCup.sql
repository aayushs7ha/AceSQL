-- CREATE DATABASE ASdb_1
USE ASdb_1

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

SELECT * FROM icc_world_cup

-- output should be TEAM_NAME, NUMBER_OF_MATCHES_PLAYED, WINS, LOSSES 

SELECT 
	TEAM_NAME,
	COUNT(*) NUMBER_OF_MATCHES_PLAYED,
	SUM(WIN_FLAG) WINS,
	COUNT(*) - SUM(WIN_FLAG) LOSSES
FROM (
SELECT 
	Team_1 as TEAM_NAME,
	CASE WHEN Team_1 = Winner THEN 1 ELSE 0 END AS WIN_FLAG 
FROM icc_world_cup
UNION ALL 
SELECT Team_2 as TEAM_NAME,
	CASE WHEN Team_2 = Winner THEN 1 ELSE 0 END AS WIN_FLAG
FROM icc_world_cup
	) M
GROUP BY TEAM_NAME 
ORDER BY WINS DESC

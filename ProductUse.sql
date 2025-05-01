WITH floor_visit as (
SELECT
	name,
	floor,
	count(*) Total_Visits,
	RANK() OVER (PARTITION BY NAME ORDER BY COUNT(*)DESC)rn
FROM entries
group by name, floor 
),
total_visits AS (
SELECT
	name,
	count(1) Total_Visits,
	STRING_AGG(resources, ',')RESOUCRCES_USED
FROM entries
GROUP BY name
)
SELECT 
	fv.name,
	tv.Total_Visits,
	fv.floor AS MOST_VISISTED_FLOOR,
	tv.RESOUCRCES_USED
FROM floor_visit fv 
INNER JOIN  total_visits tv

    ON fv.name = tv.name
WHERE rn = 1

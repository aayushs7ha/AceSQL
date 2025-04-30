-- Find Repeat Customers 
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
)

select
	*
from
	customer_orders
insert
	into
	customer_orders
values(1, 100, cast('2022-01-01' as date), 2000),
(2,
200,
cast('2022-01-01' as date),
2500),
(3,
300,
cast('2022-01-01' as date),
2100)
,
(4,
100,
cast('2022-01-02' as date),
2000),
(5,
400,
cast('2022-01-02' as date),
2200),
(6,
500,
cast('2022-01-02' as date),
2700)
,
(7,
100,
cast('2022-01-03' as date),
3000),
(8,
400,
cast('2022-01-03' as date),
1000),
(9,
600,
cast('2022-01-03' as date),
3000)


SELECT * FROM customer_orders


-- Fetch New and Repeat Customers for the given dates


SELECT
	order_date,
	SUM(CASE
		WHEN order_date = FIRST_ORDER 
		THEN 1 ELSE 0
	END) AS NewCustomer,
	SUM(CASE
		WHEN order_date != FIRST_ORDER 
		THEN 1 ELSE 0
	END) AS RepeatCustomer
FROM
	(
	SELECT
		customer_id,
		order_date,
		min(order_date) OVER (PARTITION BY customer_id) FIRST_ORDER
	FROM
		customer_orders
)Ord
GROUP BY
	order_date


-- CTE 

WITH FirstOrderDate AS(
SELECT customer_id, min(order_date)as FirstOrder
FROM customer_orders
GROUP BY customer_id
)
SELECT 
	order_date,
	SUM(CASE WHEN co.order_date=fo.FirstOrder THEN 1 ELSE 0 END)NewCustomer,
	SUM(CASE WHEN co.order_date!=fo.FirstOrder THEN 1 ELSE 0 END)RepeatCustomer
FROM customer_orders co 
INNER JOIN FirstOrderDate fo on co.customer_id  = fo.customer_id
GROUP BY co.order_date
ORDER BY co.order_date

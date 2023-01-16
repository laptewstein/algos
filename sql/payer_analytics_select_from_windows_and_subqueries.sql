/*

|-------------|-----------|
| Field       | Type      |
|-------------+-----------|
| user_id     | int       |
| purchase_ts | timestamp |
| revenue     | float     |
|-------------|-----------|

We have a table titled `purchases` which tracks user purchases
and how much money they've spent. This table is unique on (user_id & purchase_ts)

SELECT
  COUNT(*)
  ,COUNT(DISTINCT(user_id))
FROM purchases;
+----------+--------------------------+
| count(*) | count(distinct(user_id)) |
+----------+--------------------------+
|     1492 |                      476 |
+----------+--------------------------+
*/


-- Calculate how many new payers (users who made their FIRST ever purchase) we see per day?
SELECT
  DATE(first_user_purchase) AS purchase_date
  ,COUNT(*) as users /* ALT: SUM(1): hardcoded +1 for each row */
FROM (
  -- first purchase for each user id
  SELECT
    user_id
    ,MIN(purchase_ts) AS first_user_purchase
  FROM purchases
  GROUP BY user_id
  ) T
GROUP BY purchase_date
ORDER BY purchase_date ASC;

/*
|---------------|--------|
| purchase_date | users  |
|---------------|--------|
| 2018-10-21    |    127 |
| 2018-10-22    |     99 |
| 2018-10-23    |     74 |
| 2018-10-24    |     45 |
| 2018-10-25    |     44 |
| 2018-10-26    |     40 |
| 2018-10-27    |     25 |
| 2018-10-28    |     14 |
| 2018-10-29    |      8 |
|---------------|--------|
*/


/*
  D1 revenue - revenue on the conversion day (when player became paying user).
  D3 revenue - revenue within the first 3 days of conversion: D1 + D2 + D3
*/

-- Calculate D1 and D3 revenue for each new customer, lets limit output to 15 rows.
SELECT
  -- for nicer looks
  ROW_NUMBER() OVER (ORDER BY P.user_id) AS id
  ,P.user_id
  ,ROUND(SUM(
    case when
      DATE(P.purchase_ts) = FIRST_PURCHASES.first_purchase_date
      then revenue
      else 0
    end), 2) AS 'Revenue D1'
  ,ROUND(SUM(
    case when
      -- add if purchase was made within the first 3 days
      DATE(P.purchase_ts) <= FIRST_PURCHASES.first_purchase_date + 3
      then revenue
      else 0
    end), 2) AS 'Revenue D3'
FROM purchases P
JOIN (
  SELECT
    user_id
    ,MIN(DATE(purchase_ts)) AS first_purchase_date
  FROM purchases
  GROUP BY user_id
) FIRST_PURCHASES
ON P.user_id = FIRST_PURCHASES.user_id
GROUP BY user_id
LIMIT 15;

-- alternative
WITH
  first_purchase AS (
    SELECT
      user_id
      ,MIN(DATE(purchase_ts)) AS first_purchase_date
    FROM purchases
    GROUP BY 1
  ),
  D1_revenue AS (
    SELECT
      p.user_id,
      first_purchase.first_purchase_date,
      SUM(p.revenue) AS revenue
    FROM purchases p
    JOIN first_purchase ON p.user_id = first_purchase.user_id
    AND DATE(p.purchase_ts) = first_purchase.first_purchase_date
    GROUP BY 1, 2
  ),
  D3_revenue AS (
    SELECT
      p.user_id
      ,SUM(p.revenue) AS revenue
    FROM first_purchase
    JOIN purchases p ON first_purchase.user_id = p.user_id
    AND DATEDIFF(p.purchase_ts, first_purchase.first_purchase_date) <= 2
    GROUP BY 1
  )
SELECT
  ROW_NUMBER() OVER (ORDER BY D1_revenue.user_id) AS id
  ,D1_revenue.user_id
  ,ROUND(D1_revenue.revenue, 2) AS 'Revenue D1'
  ,ROUND(D3_revenue.revenue, 2) AS 'Revenue D3'
FROM D1_revenue
JOIN D3_revenue ON D1_revenue.user_id = D3_revenue.user_id
ORDER BY D1_revenue.user_id
LIMIT 15;

/*
+----+---------+------------+------------+
| id | user_id | Revenue D1 | Revenue D3 |
+----+---------+------------+------------+
|  1 |       2 |      31.98 |      31.98 |
|  2 |       3 |      41.98 |      42.97 |
|  3 |       4 |      20.99 |      41.98 |
|  4 |       5 |      21.98 |      32.97 |
|  5 |       6 |      10.99 |      43.96 |
|  6 |       7 |      20.99 |      41.98 |
|  7 |       8 |      20.99 |      20.99 |
|  8 |       9 |      10.99 |      42.97 |
|  9 |      10 |      11.98 |      11.98 |
| 10 |      11 |      10.99 |      10.99 |
| 11 |      12 |      31.98 |      31.98 |
| 12 |      13 |      20.99 |      31.98 |
| 13 |      14 |      10.99 |      10.99 |
| 14 |      15 |      20.99 |      21.98 |
| 15 |      17 |      20.99 |      20.99 |
+----+---------+------------+------------+
*/



-- understand the following query before answering the next question
/*
SELECT
  ROW_NUMBER()  OVER (ORDER BY user_id)           AS id          -- whole data set
  ,ROW_NUMBER() OVER (PARTITION BY user_id)       AS window_id   -- window per user (rank?)
  ,user_id
  ,DATE(purchase_ts)                                  AS purchase_date
  ,MIN(DATE(purchase_ts)) OVER (PARTITION BY user_id) AS first_purchase_date
  ,MIN(DATE(purchase_ts)) OVER (ORDER BY user_id)     AS incorrect_first_purchase_date
FROM purchases limit 20;

+----+-----------+---------+---------------+---------------------+-------------------------------+
| id | window_id | user_id | purchase_date | first_purchase_date | incorrect_first_purchase_date |
+----+-----------+---------+---------------+---------------------+-------------------------------+
|  1 |         1 |       2 | 2018-10-22    | 2018-10-22          | 2018-10-22                    |
|  2 |         2 |       2 | 2018-10-22    | 2018-10-22          | 2018-10-22                    |
|  3 |         3 |       2 | 2018-10-26    | 2018-10-22          | 2018-10-22                    |
|  4 |         4 |       2 | 2018-10-26    | 2018-10-22          | 2018-10-22                    |
|  5 |         5 |       2 | 2018-10-29    | 2018-10-22          | 2018-10-22                    |

|  6 |         1 |       3 | 2018-10-21    | 2018-10-21          | 2018-10-21                    |
|  7 |         2 |       3 | 2018-10-21    | 2018-10-21          | 2018-10-21                    |
|  8 |         3 |       3 | 2018-10-22    | 2018-10-21          | 2018-10-21                    |

|  9 |         1 |       4 | 2018-10-22    | 2018-10-22          | 2018-10-21                    |
| 10 |         2 |       4 | 2018-10-24    | 2018-10-22          | 2018-10-21                    |
| 11 |         3 |       4 | 2018-10-26    | 2018-10-22          | 2018-10-21                    |
| 12 |         4 |       4 | 2018-10-29    | 2018-10-22          | 2018-10-21                    |

| 13 |         1 |       5 | 2018-10-21    | 2018-10-21          | 2018-10-21                    |
| 14 |         2 |       5 | 2018-10-21    | 2018-10-21          | 2018-10-21                    |
| 15 |         3 |       5 | 2018-10-24    | 2018-10-21          | 2018-10-21                    |

| 16 |         1 |       6 | 2018-10-22    | 2018-10-22          | 2018-10-21                    |
| 17 |         2 |       6 | 2018-10-23    | 2018-10-22          | 2018-10-21                    |
| 18 |         3 |       6 | 2018-10-23    | 2018-10-22          | 2018-10-21                    |
| 19 |         4 |       6 | 2018-10-25    | 2018-10-22          | 2018-10-21                    |

| 20 |         1 |       7 | 2018-10-26    | 2018-10-26          | 2018-10-21                    |
+----+-----------+---------+---------------+---------------------+-------------------------------+
*/


-- Calculate how many existing payers keep purchasing stuff, each day?
/*
  If new payer made multiple purchases during their first day as a payer,
  they are still considered *new payer* and should not be in the list
*/

-- a) fetch user id, purchase dates, and first purchase date in subquery
-- b) reject entries completed on first date
-- c) group cleansed records into dates and count paying users for that day
SELECT
  purchase_date,
  COUNT(DISTINCT user_id) AS users
FROM (
  SELECT
    user_id
    ,DATE(purchase_ts) AS purchase_date
    ,MIN(DATE(purchase_ts)) OVER (PARTITION BY user_id) AS first_purchase_date
  FROM purchases
  ) T
WHERE first_purchase_date != purchase_date
GROUP BY purchase_date
ORDER BY purchase_date;

/*
|---------------|-------|
| purchase_date | users |
|---------------|-------|
| 2018-10-22    |    43 |
| 2018-10-23    |    77 |
| 2018-10-24    |    77 |
| 2018-10-25    |    93 |
| 2018-10-26    |   115 |
| 2018-10-27    |   132 |
| 2018-10-28    |   141 |
| 2018-10-29    |   125 |
|---------------|-------|
*/

-- alternative
-- a) fetch user purchase history,
-- b) squeeze multiple same-day purchases into one entry and assign daily purchase sequence id (per user)
-- c) reject first day purchases,
-- d) group into dates and count number of paying users for that day
SELECT
  purchase_date
  ,COUNT(DISTINCT user_id) AS users
FROM (
  SELECT
    user_id
    ,purchase_date
    ,ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY purchase_date) AS purchase_seq
  FROM (
    SELECT
      user_id
      ,DATE(purchase_ts) AS purchase_date
    FROM purchases
    GROUP BY user_id, purchase_date -- squeeze multiple same day purchases into single row
  ) T
) T
WHERE purchase_seq != 1
GROUP BY purchase_date ORDER BY purchase_date;

-- alternative (2)
WITH
  /* find out user first purchase date */
  first_purchase AS (
    SELECT
      user_id
      ,MIN(DATE(purchase_ts))   AS first_purchase_date
    FROM purchases
    GROUP BY 1
  ),
  /* get count of new payers per date */
  new_payer AS (
    SELECT
      first_purchase_date       AS purchase_date
      ,COUNT(DISTINCT user_id)  AS new_users
    FROM first_purchase
    GROUP BY 1
  ),
  /* get count of ALL payers per date */
  all_payer AS (
    SELECT
      DATE(purchase_ts)         AS purchase_date
      ,COUNT(DISTINCT user_id)  AS total_users
    FROM purchases
    GROUP BY 1
  )
SELECT
  /* for all purchase dates */
  ROW_NUMBER() OVER (ORDER BY all_payer.purchase_date) AS id
  ,all_payer.purchase_date
  ,all_payer.total_users - new_payer.new_users AS users
FROM all_payer
JOIN new_payer ON new_payer.purchase_date = all_payer.purchase_date
ORDER BY id;

/*
+----+---------------+-------+
| id | purchase_date | users |
+----+---------------+-------+
|  1 | 2018-10-21    |     0 | (!) if desired, remediate with WHERE clause
|  2 | 2018-10-22    |    43 |
|  3 | 2018-10-23    |    77 |
|  4 | 2018-10-24    |    77 |
|  5 | 2018-10-25    |    93 |
|  6 | 2018-10-26    |   115 |
|  7 | 2018-10-27    |   132 |
|  8 | 2018-10-28    |   141 |
|  9 | 2018-10-29    |   125 |
+----+---------------+-------+
*/

-- WRONG ANSWER: 2nd+ purchase on the first day will be included
-- see first solution of this problem (we select from another subquery rather than the database/table directly)
SELECT
  purchase_date
  ,count(DISTINCT user_id) AS users
FROM (
  SELECT
    user_id
    ,DATE(purchase_ts) AS purchase_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY DATE(purchase_ts)) AS purchase_seq
  FROM purchases
) T
WHERE purchase_seq != 1
GROUP BY purchase_date
ORDER BY purchase_date;

/*
+---------------+-------+
| purchase_date | users |
+---------------+-------+
| 2018-10-21    |    16 | <<
| 2018-10-22    |    60 |
| 2018-10-23    |    87 |
| 2018-10-24    |    88 |
| 2018-10-25    |   102 |
| 2018-10-26    |   119 |
| 2018-10-27    |   134 |
| 2018-10-28    |   142 |
| 2018-10-29    |   125 |
+---------------+-------+
 */
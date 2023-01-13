/*
Write a query that returns the name of the salesperson
who had the highest sales total in any single month,
the year and the month when the record occurred,
and the total in sales that person landed for that month.
*/

DROP TABLE IF EXISTS Salesperson, Sale;

CREATE TABLE Salesperson (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE Sale (
  id INT PRIMARY KEY,
  salesperson_id INT,
  amount DECIMAL(20,4),
  created_at DATE
);

INSERT INTO Salesperson VALUES
  (1, 'Becca'),
  (2, 'Jade'),
  (3, 'Shawna'),
  (4, 'Priya');

INSERT INTO Sale VALUES
(1, 1, 55.72, '2021-01-22'),
(2, 2, 133.48, '2021-01-12'),
(3, 3, 533.63, '2021-12-12'),
(4, 1, 33.78, '2021-01-12'),
(5, 1, 31.58, '2021-02-02'),
(6, 3, 43.58, '2021-05-13'),
(7, 2, 43.58, '2021-07-11'),
(8, 3, 43.58, '2021-12-13'),
(9, 1, 43.58, '2022-09-17'),
(10, 3, 43.58, '2021-05-13'),
(11, 3, 436.52, '2022-02-13'),
(12, 4, 533.64, '2021-12-12'),
(13, 3, 500.00, '2019-12-13');

/* =================================================== */

WITH MonthlyStats AS (
  SELECT
    salesperson_id
    ,ROW_NUMBER() OVER (
      PARTITION BY MONTH(created_at), YEAR(created_at)
      ORDER BY SUM(amount) DESC
    ) AS position
    ,ROUND(SUM(amount),2) AS sales
    ,MONTH(created_at)    AS month
    ,YEAR(created_at)     AS year
  FROM Sale
  GROUP BY salesperson_id, year, month
)
SELECT
  Salesperson.name    AS 'Sales Assistant'
  ,MonthlyStats.sales AS Sales
  ,MonthlyStats.month AS Month
  ,MonthlyStats.year  AS Year
FROM MonthlyStats, Salesperson
WHERE
  MonthlyStats.position = 1
  AND Salesperson.id = MonthlyStats.salesperson_id
ORDER BY MonthlyStats.year, MonthlyStats.month

/* ===================================================

+-----------------+--------+-------+------+
| Sales Assistant | Sales  | Month | Year |
+-----------------+--------+-------+------+
| Shawna          | 500.00 |    12 | 2019 |
| Jade            | 133.48 |     1 | 2021 |
| Becca           |  31.58 |     2 | 2021 |
| Shawna          |  87.16 |     5 | 2021 |
| Jade            |  43.58 |     7 | 2021 |
| Shawna          | 577.21 |    12 | 2021 |
| Shawna          | 436.52 |     2 | 2022 |
| Becca           |  43.58 |     9 | 2022 |
+-----------------+--------+-------+------+

=================================================== */

# Write a query that returns the name of the salesperson
# who had the highest sales total in any single month,
# the year and the month when the record occurred,
# and the total in sales that person landed for that month.

# DROP TABLE IF EXISTS Salesperson, Sale;
#
# CREATE TABLE Salesperson (
#   id INT PRIMARY KEY,
#   name VARCHAR(255)
# );
#
# CREATE TABLE Sale (
#   id INT PRIMARY KEY,
#   salesperson_id INT,
#   amount DECIMAL(20,4),
#   created_at DATE
# );
#
# INSERT INTO Salesperson VALUES
#   (1, 'Becca'),
#   (2, 'Jade'),
#   (3, 'Shawna'),
#   (4, 'Priya');
#
# INSERT INTO Sale VALUES
# (1, 1, 55.72, '2021-01-22'),
# (2, 2, 133.48, '2021-01-12'),
# (3, 3, 533.63, '2021-12-12'),
# (4, 1, 33.78, '2021-01-12'),
# (5, 1, 31.58, '2021-02-02'),
# (6, 3, 43.58, '2021-05-13'),
# (7, 2, 43.58, '2021-07-11'),
# (8, 3, 43.58, '2021-12-13'),
# (9, 1, 43.58, '2022-09-17'),
# (10, 3, 43.58, '2021-05-13'),
# (11, 3, 436.52, '2022-02-13'),
# (12, 4, 533.64, '2021-12-12'),
# (13, 3, 500.00, '2019-12-13');

# select * from Salesperson;
# +----+--------+
# | id | name   |
# +----+--------+
# |  1 | Becca  |
# |  2 | Jade   |
# |  3 | Shawna |
# |  4 | Priya  |
# +----+--------+

# select * from Sale order by created_at asc;
# +----+----------------+----------+------------+
# | id | salesperson_id | amount   | created_at |
# +----+----------------+----------+------------+
# | 13 |              3 | 500.0000 | 2019-12-13 |
# |  2 |              2 | 133.4800 | 2021-01-12 |
# |  4 |              1 |  33.7800 | 2021-01-12 |
# |  1 |              1 |  55.7200 | 2021-01-22 |
# |  5 |              1 |  31.5800 | 2021-02-02 |
# |  6 |              3 |  43.5800 | 2021-05-13 |
# | 10 |              3 |  43.5800 | 2021-05-13 |
# |  7 |              2 |  43.5800 | 2021-07-11 |
# |  3 |              3 | 533.6300 | 2021-12-12 |
# | 12 |              4 | 533.6400 | 2021-12-12 |
# |  8 |              3 |  43.5800 | 2021-12-13 |
# | 11 |              3 | 436.5200 | 2022-02-13 |
# |  9 |              1 |  43.5800 | 2022-09-17 |
# +----+----------------+----------+------------+

# Monthly Transactions
## Question1
https://leetcode.com/problems/monthly-transactions-i/
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+

Result table:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+

### Solution1
```
SELECT FORMAT(trans_date,'yyyy-MM') month, country ,
        count(trans_date) trans_count,
        sum(case when state = 'approved' then 1 else 0 end) as approved_count, 
        sum(amount) trans_total_amount,
        sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
FROM Transactions
group by FORMAT(trans_date,'yyyy-MM'), country
```
### Solution2
```
select left(trans_date, 7) as month, country,
    count(1) as trans_count,
    sum(case when state = 'approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount, 
    sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by country, left(trans_date, 7)
```
## Question2
https://leetcode.com/problems/monthly-transactions-ii/
Table: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |
| country        | varchar |
| state          | enum    |
| amount         | int     |
| trans_date     | date    |
+----------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
Table: Chargebacks

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| trans_id       | int     |
| charge_date    | date    |
+----------------+---------+
Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
trans_id is a foreign key to the id column of Transactions table.
Each chargeback corresponds to a transaction made previously even if they were not approved.
 

Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

Note: In your query, given the month and country, ignore rows with all zeros.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 101  | US      | approved | 1000   | 2019-05-18 |
| 102  | US      | declined | 2000   | 2019-05-19 |
| 103  | US      | approved | 3000   | 2019-06-10 |
| 104  | US      | approved | 4000   | 2019-06-13 |
| 105  | US      | approved | 5000   | 2019-06-15 |
+------+---------+----------+--------+------------+

Chargebacks table:
+------------+------------+
| trans_id   | trans_date |
+------------+------------+
| 102        | 2019-05-29 |
| 101        | 2019-06-30 |
| 105        | 2019-09-18 |
+------------+------------+

Result table:
+----------+---------+----------------+-----------------+-------------------+--------------------+
| month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
+----------+---------+----------------+-----------------+-------------------+--------------------+
| 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
| 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
| 2019-09  | US      | 0              | 0               | 1                 | 5000               |
+----------+---------+----------------+-----------------+-------------------+--------------------+
### Solution
```
with u as (
    SELECT LEFT(trans_date,7) month, country, id, state, amount
    FROM transactions
    WHERE state= 'approved'
    union all
    SELECT LEFT(c.trans_date, 7) month, country, c.trans_id, 'chargeback' state, amount
    FROM transactions t 
    right join chargebacks c
    ON t.id = c.trans_id)

SELECT month, country,
    SUM(CASE WHEN state='approved' THEN 1 else 0 end) as approved_count,
    SUM(CASE WHEN state='approved' THEN amount else 0 end) as approved_amount,
    SUM(CASE WHEN state='chargeback' THEN 1 else 0 end) as chargeback_count,
    SUM(CASE WHEN state='chargeback' THEN amount else 0 end) as chargeback_amount
FROM u
GROUP BY month, country
```
Step 1 We want the Chargebacks table look similar to the Transaction table so that we can use union to concatenate all records. 
At least the fields should be the same. 
In addition to the chargeback date and transaction id, we will need to get the country and amount information for chargebacks.


Step 2 Union all gives us a long table which has all the chargebacks and approvals so that we can calculate counts and amounts based on conditions.







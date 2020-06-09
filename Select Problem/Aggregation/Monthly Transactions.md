# Monthly Transactions
## Question1
https://leetcode.com/problems/monthly-transactions-i/
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







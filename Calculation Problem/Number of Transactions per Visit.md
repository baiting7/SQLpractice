# Number of Transactions per Visit
## Question
https://leetcode.com/problems/number-of-transactions-per-visit/
### Solution
```
With temp AS
(Select v.user_id, v. visit_date, count(t.transaction_date) as transactions_count
from visits v
left join transactions t
on v.visit_date = t.transaction_date and v.user_id = t.user_id
group by v.user_id, visit_date),

temp2 AS
(Select transactions_count, count(visit_date) as visits_count
from temp
group by transactions_count),

MAXTRN as
(Select max(transactions_count) as maxcnt from temp2),

temp3(n) AS
(Select 0 AS transactions_count
Union all
Select n+1 transactions_count
from temp3 where n+1 <= (Select maxcnt from MAXTRN) )

Select t3.n as transactions_count, isnull(t2.visits_count,0) as visits_count
from temp3 t3
left join temp2 t2
on t3.n = t2.transactions_count
```
#### An easy recursive CTE can get you a list from 0 - n
```
with CTE
as(select 0 as num
   union all
   select num + 1 as num from CTE where num < n)
```












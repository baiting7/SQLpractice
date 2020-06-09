# NPV Queries
## Question
https://leetcode.com/problems/npv-queries/
### Solution
```
select q.id, q.year, ifnull(n.npv,0)as npv
from queries q
left join NPV n
on n.id=q.id and n.year=q.year
```

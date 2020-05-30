# Change Adjacent Number
## Question
https://leetcode.com/problems/exchange-seats/
###Solution
```
select if(id%2=1 and id=cnt, id, if(id%2=1, id+1, id-1)) as id, student
from seat, (select count(id) as cnt from seat) t
order by id
```
### Analysis
Change the order by changing the id
### IF(condition, value_if_true, value_if_false)

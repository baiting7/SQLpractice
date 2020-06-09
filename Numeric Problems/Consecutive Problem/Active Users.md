# Active Users
## Question
https://leetcode.com/problems/active-users/
### Solution
```
from
(select id, coalesce(datediff(day,start_date,fifth_date),0) as diff
from
(select id, login_date as start_date, lead(login_date,4) over(partition by id order by login_date) as fifth_date
from
(select distinct id, login_date
from logins ) a )b )c , accounts d
where diff = 4
and c.id = d.id
order by c.id
```

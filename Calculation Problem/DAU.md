# New Users Daily Count
## Question
https://leetcode.com/problems/new-users-daily-count/
### Solution
```
select activity_date as login_date, count(distinct user_id) as user_count
from
(select user_id, activity, activity_date, 
 rank() over(partition by user_id order by activity_date) rank
 from Traffic 
 where activity = 'login') t
 where rank=1 
 and activity='login'
 and DATEDIFF(DAY, activity_date, '2019-06-30')<=90
 group by activity_date
```

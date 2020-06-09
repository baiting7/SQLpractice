# Get the Second Most Recent Activity
## Question
https://leetcode.com/problems/get-the-second-most-recent-activity/
### Solution
```
select a.username,a.activity,a.startDate,a.endDate 
from 
(select *,   
 row_number() over (partition by username order by startDate desc)rk,
 count(*) over (partition by username) ct
 from UserActivity ) a
where a.rk=(case when a.ct=1 then 1 else 2 end)
```

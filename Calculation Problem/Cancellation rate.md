## Question
https://leetcode.com/problems/trips-and-users/
### Solution
```
select t.Request_at as Day, round(sum(case when Status like 'cancelled%' then 1 else 0 end)/count(*),2) as 'Cancellation Rate'
from Trips t, Users u
where u.Users_Id = t.Client_Id
and u.Banned = 'No'
and Request_at between '2013-10-01' and '2013-10-03'
group by Request_at
```
### Analysis
Use ```case when... then 1 else 0 end``` to calcuate the counts in a condition.

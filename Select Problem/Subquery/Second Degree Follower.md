# Second Degree Follower
## Question
https://leetcode.com/problems/second-degree-follower/
### Solution
```
select followee as follower, count(distinct follower) as num
from follow
where followee in (select distinct follower from follow)
group by followee
order by followee
```

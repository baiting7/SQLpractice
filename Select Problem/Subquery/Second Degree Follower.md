# Second Degree Follower
## Question
https://leetcode.com/problems/second-degree-follower/
### Solution1: use ```subquery```
```
select followee as follower, count(distinct follower) as num
from follow
where followee in (select distinct follower from follow)
group by followee
order by followee
```
### Solution2: use ```Self Join```
```
SELECT f1.follower as follower, COUNT(DISTINCT f2.follower) as num 
FROM follow f1 
JOIN follow f2 ON f1.follower = f2.followee 
GROUP BY f2.follower 
ORDER BY f2.follower
```

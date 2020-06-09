# Activity Participants
## Question
https://leetcode.com/problems/activity-participants/
### Solution1: use CTE
```
with t as 
(select activity, count(activity) cnt
from Friends
group by activity 
order by cnt)
    
select distinct(activity) 
from t
where cnt not in ((select max(cnt) from t), (select min(cnt) from t))
```
### Solution2
```
SELECT activity
FROM
(SELECT activity, count(*) as ac, 
       max(count(*)) OVER () as max_num, 
       min(count(*)) OVER () as min_num
FROM Friends
GROUP BY activity ) tablea
WHERE ac not in (max_num, min_num)
```

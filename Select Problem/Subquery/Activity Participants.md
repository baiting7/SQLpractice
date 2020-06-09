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
### Solution3: use ```having```
```
select activity
from friends
group by activity
having count(id) not in
(select max(cnt) as cnt
from
(select activity, count(id) as cnt
from friends
group by activity) tmp1
union
select min(cnt) as cnt 
from
(select activity, count(id) as cnt
from friends
group by activity) tmp2)
```

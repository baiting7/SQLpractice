# Second Degree Follower
## Question
https://leetcode.com/problems/second-degree-follower/
In facebook, there is a follow table with two columns: followee, follower.

Please write a sql query to get the amount of each follower’s follower if he/she has one.

For example:

+-------------+------------+
| followee    | follower   |
+-------------+------------+
|     A       |     B      |
|     B       |     C      |
|     B       |     D      |
|     D       |     E      |
+-------------+------------+
should output:
+-------------+------------+
| follower    | num        |
+-------------+------------+
|     B       |  2         |
|     D       |  1         |
+-------------+------------+
Explaination:
Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
 

 

Note:
Followee would not follow himself/herself in all cases.
Please display the result in follower's alphabet order.
 
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

# Consecutive Question
## Question1：Consecutive Number
https://leetcode.com/problems/consecutive-numbers/
### My Solution: Window Function
```
SELECT DISTINCT Num AS ConsecutiveNums
FROM
(
SELECT Num,LEAD(Num) OVER(ORDER BY ID) AS lead, LAG(Num) OVER (ORDER BY Id) AS lag
FROM Logs
)t
WHERE Num=lead and Num=lag;
```
### Another Solution
#### Analysis
Fully join 3 Logs tables, and they are used to search for the first, second and third number respectively. Exclude duplicates as well.
#### Solution
```
SELECT DISTINCT l1.Num AS ConsecutiveNums 
FROM Logs AS l1, Logs AS l2, Logs AS l3
WHERE l1.Num = l2.Num 
AND l2.Num = l3.Num 
AND l1.Id = l2.Id - 1 
AND l2.Id = l3.Id - 1;
```
## A similar question: Human Traffic of Stadium
https://leetcode.com/problems/human-traffic-of-stadium/
### Analysis
When we join the 3 tables, we are changing the date from column to row. The 3 consective number a,b and c are in one row, so when we select the column a, we will just get one number. However, we need the number a,b and c so that we shpuld consider 3 situations, which are a in the beginning, mediuma and end so that when we select the colmun a, we can get a,b and c.
### Solution
```
select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
((t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1) or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2))
order by t1.id
```














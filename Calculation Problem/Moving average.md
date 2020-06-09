# Restaurant Growth
## Question
https://leetcode.com/problems/restaurant-growth/
### Solution1: use window function
```
select visited_on, amount, round(average_amount,2) as average_amount
from
(select visited_on , 
 sum(amt) over(order by visited_on ROWS between 6 preceding and current row) as amount,
 avg(amt*1.00) over(order by visited_on ROWS between 6 preceding and current row) as average_amount,
 row_number() over(order by visited_on) as rownum
from
(select visited_on, sum(amount) as amt
from customer
group by visited_on )a ) b
where rownum >6 
```
### Solution2: use ```dateiff()```
```
SELECT a.visited_on AS visited_on, SUM(b.day_sum) AS amount,
       ROUND(AVG(b.day_sum), 2) AS average_amount
FROM
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on ) a,
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on ) b
WHERE DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6
GROUP BY a.visited_on
HAVING COUNT(b.visited_on) = 7
```

# Shortest distance
## Question1: Shortest Distance in a Line
https://leetcode.com/problems/shortest-distance-in-a-line/
### Solution
```
select min(p1.x - p2.x) shortest
from point p1
join point p2 on p1.x > p2.x
```
Use  ```p1.x > p2.x``` rather than ```p1.x <> p2.x``` to exlude the repeated points like (0,-1) and (-1,0) when calculating the distance.
## Question2: Shortest Distance in a Plane
https://leetcode.com/problems/shortest-distance-in-a-plane/
### Solution1: use ```Inner Join```
```
SELECT ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))), 2) AS shortest
FROM point_2d p1
JOIN point_2d p2 ON p1.x != p2.x OR p1.y != p2.y
```
Note: To put the ```MIN()``` inside of ```SQRT()``` will slightly improve the performance.
### Solution2: optimize to avoid reduplicate calculations
```
SELECT ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))),2) AS shortest
FROM point_2d p1
JOIN point_2d p2 ON (p1.x <= p2.x AND p1.y < p2.y)
        OR (p1.x <= p2.x AND p1.y > p2.y)
        OR (p1.x < p2.x AND p1.y = p2.y)
```
When join the table with itself, we can claim to only calculate the distance between one point to another point in a certain rule such ponts with bigger x value. 
By following this rule, we can avoid quite a lot of reduplicate calculations.
### Solution3: use ```Cross Join```
```
select round(min(path),2) as shortest from (
select sqrt(power(t1.x-t2.x,2)+power(t1.y-t2.y,2)) as path from point_2d t1
cross join point_2d t2) t
where path <>0
```
###  Cross Join
The SQL ```CROSS JOIN``` produces a result set which is the number of rows in the first table multiplied by the number of rows in the second table if no WHERE clause is used along with ```CROSS JOIN```.
This kind of result is called as **Cartesian Product**.

If WHERE clause is used with CROSS JOIN, it functions like an INNER JOIN.

An alternative way of achieving the same result is to use column names separated by commas after SELECT and mentioning the table names involved, after a FROM clause.

**Examples** in
https://www.w3resource.com/sql/joins/cross-join.php





# Find customer referee
## Question
https://leetcode.com/problems/find-customer-referee/
Given a table customer holding customers information and the referee.

+------+------+-----------+
| id   | name | referee_id|
+------+------+-----------+
|    1 | Will |      NULL |
|    2 | Jane |      NULL |
|    3 | Alex |         2 |
|    4 | Bill |      NULL |
|    5 | Zack |         1 |
|    6 | Mark |         2 |
+------+------+-----------+
Write a query to return the list of customers NOT referred by the person with id '2'.

For the sample data above, the result is:

+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+

### Solution1: use ```...is NULL```
```
SELECT name 
FROM customer 
WHERE referee_id <> 2 OR referee_id IS NULL;
```
### Solution2: use ```COALESCE(..., 0)```
```
select name
from customer
where coalesce(referee_id,0)<>2
```
### Solution3: use ```IFNULL(..., 0)```
```
SELECT name
FROM customer
WHERE IFNULL(referee_id, 0) <> 2
```

# Find customer referee
## Question
https://leetcode.com/problems/find-customer-referee/
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

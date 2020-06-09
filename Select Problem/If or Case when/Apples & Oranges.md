# Apples & Oranges
## Question
https://leetcode.com/problems/apples-oranges/
### Solution
```
select sale_date, sum(case when fruit='oranges' then -sold_num else sold_num end) as diff
from Sales
group by sale_date
```

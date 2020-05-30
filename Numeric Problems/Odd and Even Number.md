# Numeric Problems
## 1. Odd and Even Number: Use mod(,2)=1/0 to solve
### Question
https://leetcode.com/problems/not-boring-movies/
#### Solution
```
select id, movie, description, rating
from cinema
where mod(id,2)=1
and description <>'boring'
order by rating desc
```
## 2. Change Adjacent Number
### Question
https://leetcode.com/problems/exchange-seats/
#### Solution
```
select if(id%2=1 and id=cnt, id, if(id%2=1, id+1, id-1)) as id, student
from seat, (select count(id) as cnt from seat) t
order by id
```
#### Analysis
Change the order by changing the id
#### IF(condition, value_if_true, value_if_false)

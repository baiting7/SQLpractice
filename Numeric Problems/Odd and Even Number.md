# Odd and Even Number: Use mod(,2)=1/0 to solve
## Question
https://leetcode.com/problems/not-boring-movies/
### Solution
```
select id, movie, description, rating
from cinema
where mod(id,2)=1
and description <>'boring'
order by rating desc
```

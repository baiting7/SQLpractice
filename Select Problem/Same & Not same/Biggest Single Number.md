# Biggest Single Number
## Question
https://leetcode.com/problems/biggest-single-number/
### Solution
```
select nullif(max(num), null) as num
from (
    select num 
    from my_numbers
    group by num
    having count(num)=1) t
```

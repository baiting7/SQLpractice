# Last Person to Fit in the Elevator
## Question
https://leetcode.com/problems/last-person-to-fit-in-the-elevator/
### Solution
```
select top 1 person_name from
(select person_name, sum(weight) over (order by turn) as totalweight
from queue)a
where totalweight <= 1000
order by totalweight desc
```

# Median Problem
## Question1: Median Employee Salary
https://leetcode.com/problems/median-employee-salary/
### Solution
```
with temp as
(select Id, Company, Salary, 
 row_number() over (partition by company order by salary) as rank,
 count(*) over (partition by company) as cnt
 from Employee) 

select ID,Company,avg(salary) as Salary
from temp
where rank between (cnt+1)/2 and (cnt+2)/2
group by ID,Company,rank,cnt
```

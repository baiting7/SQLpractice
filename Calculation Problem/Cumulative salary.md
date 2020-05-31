# Find Cumulative Salary of an Employee
## Question
https://leetcode.com/problems/find-cumulative-salary-of-an-employee/
### Solution: use window function ```SUM() OVER ()```
```
select Id, Month, 
sum(Salary) over (partition by Id order by Month ROWS 2 PRECEDING) as Salary
from Employee
where (Id, Month) not in (select Id, max(Month) from Employee group by Id)
order by Id, Month desc
```
Notice that ```ROWS 2 PERCEDING``` limit the period during the most recent 3 months. If we don't add this condition, the query will select the total salary of all months.

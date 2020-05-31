# Employees Earning More Than Their Managers
## Question
https://leetcode.com/problems/employees-earning-more-than-their-managers/
## Solution
```
select e1.Name as Employee
from Employee e1
left join Employee e2 on e1.ManagerID=e2.ID
where e1.Salary > e2.Salary
```

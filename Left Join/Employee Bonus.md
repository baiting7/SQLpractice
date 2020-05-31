# Employee Bonus
## Question
https://leetcode.com/problems/employee-bonus/
### Solution1: Use ```COALESCE( ,0)```
```
select name, bonus
from Employee
left join Bonus on Employee.empId=Bonus.empId
where coalesce(bonus, 0)<1000
```
### Solution2: Use ```... IS NULL```
```
SELECT Employee.name, Bonus.bonus
FROM Employee
LEFT JOIN Bonus ON Employee.empid = Bonus.empid
WHERE bonus < 1000 OR bonus IS NULL
;
```
### Analysis
When use ```LEFT JOIN```, don't forget to consider null values.

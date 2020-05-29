# Department Highest & Top3 highest Salary
## Question1: Department Highest Salary
https://leetcode.com/problems/department-highest-salary/
### My Solution: Use ALL()
```
SELECT d.Name AS Department, e.Name AS Employee, e.Salary 
FROM Employee e, Department d
WHERE e.DepartmentId = d.Id 
AND e.Salary >= ALL (SELECT Salary FROM Employee e2 WHERE e2.DepartmentId = d.Id)
```
### Solution2: MAX() Function + Join
```
SELECT d.Name AS Department, e1.Name AS Employee, e1.Salary 
FROM Employee e1
JOIN Department d ON e1.DepartmentId = d.Id 
WHERE Salary IN 
(SELECT MAX(Salary) FROM Employee e2 WHERE e1.DepartmentId = e2.DepartmentId)
```
### Solution3: MAX() Function + Where
```
SELECT d.Name AS Department, e.Name AS Employee, e.Salary 
FROM Employee e, Department d
WHERE e.DepartmentId = d.Id 
AND e.Salary = (SELECT MAX(Salary) FROM Employee e2 WHERE e2.DepartmentId = d.Id)
```
## Question2: Department Top3 highest Salary
https://leetcode.com/problems/department-top-three-salaries/
### Solution: Window Function
```
Select c.Department, c.Employee, c.Salary from
(select b.Name as Department, 
a.Name as Employee, 
a.Salary as Salary,
DENSE_RANK() OVER (PARTITION BY b.Name ORDER BY a.Salary desc) as rank
from Employee a, Department b where a.DepartmentId = b.Id) c
where c.rank <=3
```

# Department Highest & Top3 highest Salary
## Question1: Department Highest Salary
https://leetcode.com/problems/department-highest-salary/
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
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
The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation:

In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, and Will earns the third highest salary. There are only two employees in the Sales department, Henry earns the highest salary while Sam earns the second highest salary.
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

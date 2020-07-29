# Employee Bonus
## Question
https://leetcode.com/problems/employee-bonus/
Select all employee's name and bonus whose bonus is < 1000.

Table:Employee

+-------+--------+-----------+--------+
| empId |  name  | supervisor| salary |
+-------+--------+-----------+--------+
|   1   | John   |  3        | 1000   |
|   2   | Dan    |  3        | 2000   |
|   3   | Brad   |  null     | 4000   |
|   4   | Thomas |  3        | 4000   |
+-------+--------+-----------+--------+
empId is the primary key column for this table.
Table: Bonus

+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
empId is the primary key column for this table.
Example ouput:

+-------+-------+
| name  | bonus |
+-------+-------+
| John  | null  |
| Dan   | 500   |
| Brad  | null  |
+-------+-------+

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

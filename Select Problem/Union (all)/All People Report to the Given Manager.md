# All People Report to the Given Manager
## Question
https://leetcode.com/problems/all-people-report-to-the-given-manager/
### Solution1: use ``` union```
```
select employee_id from Employees 
where manager_id in (select employee_id from Employees where manager_id =1 and employee_id !=1)
union
select employee_id from Employees 
where manager_id =1 and employee_id !=1
union
select employee_id from Employees 
where manager_id in (select employee_id from Employees where manager_id in (select employee_id from Employees where manager_id =1 and employee_id !=1))
```
### Solution2
```
SELECT e1.employee_id
FROM Employees e1,
     Employees e2,
     Employees e3
WHERE e1.manager_id = e2.employee_id
  AND e2.manager_id = e3.employee_id
  AND e3.manager_id = 1 
  AND e1.employee_id != 1
```

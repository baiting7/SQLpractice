# Project Employees
## Question
https://leetcode.com/problems/project-employees-iii/
### Solution
```
select project_id,employee_id 
from (
select p.project_id,e.employee_id, rank() over (partition by project_id order by e.experience_years desc) as rk
from Project as p join Employee as e
on p.employee_id = e.employee_id) as result
where rk =1
```

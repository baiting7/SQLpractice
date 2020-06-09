# Students With Invalid Departments
## Question
https://leetcode.com/problems/students-with-invalid-departments/
### Solution
```
select s.id, s.name
from Students s
left join Departments d
on s.department_id = d.id
where d.id is null
```

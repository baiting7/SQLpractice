# Highest Grade For Each Student
## Question
https://leetcode.com/problems/highest-grade-for-each-student/
### Solution
```
select student_id, course_id, grade
from
(select student_id, course_id, grade, 
 rank() over(partition by student_id order by grade desc, course_id asc) as rank
 from Enrollments) t
where rank=1
order by student_id
```

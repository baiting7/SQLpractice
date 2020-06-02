# Highest Grade For Each Student
## Question
https://leetcode.com/problems/highest-grade-for-each-student/
### Solution1: use window function
```
select student_id, course_id, grade
from
(select student_id, course_id, grade, 
 rank() over(partition by student_id order by grade desc, course_id asc) as rank
 from Enrollments) t
where rank=1
order by student_id
```
### Solution2: use correlated query
```
SELECT student_id, MIN(course_id) AS course_id, grade
FROM enrollments a
WHERE grade >=ALL(SELECT grade
  FROM enrollments b
  WHERE a.student_id=b.student_id)
GROUP BY student_id, grade
ORDER BY student_id
```
### Solution3: use aggregate functions and filtering
```
SELECT student_id, MIN(course_id) AS course_id, grade
FROM enrollments
WHERE (student_id, grade) IN (
  SELECT student_id, MAX(grade)
  FROM enrollments
  GROUP BY student_id)
GROUP BY student_id, grade
ORDER BY student_id
```

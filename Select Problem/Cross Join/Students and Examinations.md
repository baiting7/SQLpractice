# Students and Examinations
## Question
https://leetcode.com/problems/students-and-examinations/
### Solution
```
select a.student_id, a.student_name,c.subject_name,ifnull(count(b.subject_name),0) as attended_exams
from students a
cross join subjects c
left join examinations b on a.student_id = b.student_id and c.subject_name = b.subject_name
group by 1,3
order by 1,2,3
```

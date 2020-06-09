# Find the Quiet Students in All Exams
## Question
https://leetcode.com/problems/find-the-quiet-students-in-all-exams/
### Solution1: use window function
```
select student_id,student_name 
from Student
where student_id not in 
	(select a.student_id from 
		(select exam_id,student_id,
		 rank() over(partition by exam_id order by score) as rankone,
		 rank() over(partition by exam_id order by score desc) as rankn
		from Exam) as a
	where a.rankone=1 or a.rankn=1)
and student_id in (select distinct student_id from Exam)
```
### Solution2: use subquery
```
SELECT DISTINCT e.student_id, s.student_name
FROM Exam e
JOIN Student s
ON e.student_id=s.student_id
WHERE e.student_id NOT IN
    (SELECT DISTINCT student_id
    FROM Exam
    WHERE (exam_id,score) IN
        (SELECT exam_id, MAX(score)
         FROM Exam
         GROUP BY exam_id)
    OR (exam_id,score) IN
        (SELECT exam_id, MIN(score)
         FROM Exam
         GROUP BY exam_id)
    ) 
ORDER BY 1
```
### Solution3: use ```join```
```
SELECT student_id, student_name
FROM Student
WHERE student_id not in (SELECT a.student_id FROM Exam a
                          INNER JOIN (SELECT exam_id, max(score) as highest, min(score) as lowest 
                          FROM Exam 
                          GROUP BY exam_id) tmp
                          ON a.exam_id = tmp.exam_id and (a.score = highest or a.score = lowest) )
and student_id IN (select student_id from Exam)
```

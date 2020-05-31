# Get the highest answer rate
## Question
https://leetcode.com/problems/get-highest-answer-rate-question/
### Solution1: use sub-query and ```COUNT(IF...)``` function
```
SELECT question_id AS 'survey_log'
FROM survey_log
GROUP BY question_id
ORDER BY COUNT(answer_id) / COUNT(IF(action = 'show', 1, 0)) DESC
LIMIT 1
```
### Solution2:  use sub-query and ```SUM()``` function
```
SELECT question_id as survey_log
FROM (
SELECT question_id,
SUM(case when action="answer" THEN 1 ELSE 0 END) as num_answer,
SUM(case when action="show" THEN 1 ELSE 0 END) as num_show,    
FROM survey_log
GROUP BY question_id ) as tbl
ORDER BY (num_answer / num_show) DESC
LIMIT 1
```
### Solution3: use window function ```count() over ()```
```
with tb as 
( select * ,
count(answer_id) over (partition by  question_id  )*1.0  / count(question_id) over (partition by  question_id  ) rk2 
from survey_log) 

select distinct question_id survey_log 
from tb where rk2 = (select  max(rk2) from tb)
```
The solution is the fastest one.





# Get the highest answer rate
## Question
https://leetcode.com/problems/get-highest-answer-rate-question/
Get the highest answer rate question from a table survey_log with these columns: id, action, question_id, answer_id, q_num, timestamp.

id means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

Write a sql query to identify the question which has the highest answer rate.

Example:

Input:
+------+-----------+--------------+------------+-----------+------------+
| id   | action    | question_id  | answer_id  | q_num     | timestamp  |
+------+-----------+--------------+------------+-----------+------------+
| 5    | show      | 285          | null       | 1         | 123        |
| 5    | answer    | 285          | 124124     | 1         | 124        |
| 5    | show      | 369          | null       | 2         | 125        |
| 5    | skip      | 369          | null       | 2         | 126        |
+------+-----------+--------------+------------+-----------+------------+
Output:
+-------------+
| survey_log  |
+-------------+
|    285      |
+-------------+
Explanation:
question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.
 

Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.
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





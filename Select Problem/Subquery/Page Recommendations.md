# Page Recommendations
## Question
https://leetcode.com/problems/page-recommendations/
### Solution1
```
select distinct page_id as recommended_page
from likes
where user_id in (select user2_id from Friendship where user1_id = 1
                   union
                   select user1_id from Friendship where user2_id =1)
and page_id not in (select page_id from Likes where user_id =1)
```
### Solution2
```
SELECT DISTINCT page_id AS recommended_page 
FROM Likes
WHERE user_id IN (SELECT CASE WHEN user1_id=1 THEN user2_id WHEN user2_id=1 THEN user1_id ELSE '' END
FROM Friendship WHERE user1_id=1 or user2_id=1)
AND page_id NOT IN (SELECT DISTINCT page_id FROM Likes WHERE user_id=1);
```

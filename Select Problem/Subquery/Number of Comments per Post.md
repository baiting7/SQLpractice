# Number of Comments per Post
## Question
https://leetcode.com/problems/number-of-comments-per-post/
### Solution1: use subquery
```
SELECT DISTINCT sub_id AS post_id,
    (SELECT COUNT(DISTINCT sub_id) FROM Submissions S2 WHERE S1.sub_id = S2.parent_id) AS number_of_comments
FROM Submissions AS S1
WHERE parent_id IS NULL
ORDER BY sub_id
```
### Solution2: use ```left join```
```
SELECT S1.sub_id AS post_id, COUNT(DISTINCT S2.sub_id) AS number_of_comments
FROM Submissions S1
LEFT JOIN Submissions S2
ON S1.sub_id = S2.parent_id
WHERE S1.parent_id IS NULL
GROUP BY S1.sub_id
```

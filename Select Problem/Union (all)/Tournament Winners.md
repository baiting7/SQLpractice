# Tournament Winners
## Question
https://leetcode.com/problems/tournament-winners/
### Solution
```
WITH player_score AS (
    SELECT player_id, SUM(score) as score
    FROM (
        SELECT first_player as player_id, first_score as score FROM Matches
        UNION ALL
        SELECT second_player as player_id, second_score as score FROM Matches) union_all
    GROUP BY player_id
)

SELECT group_id, player_id
FROM (
    SELECT a.group_id, a.player_id, b.score, ROW_NUMBER () OVER(PARTITION BY a.group_id ORDER BY b.score DESC, a.player_id) as player_rank
    FROM Players a
    JOIN player_score b
    ON a.player_id = b.player_id) a
WHERE a.player_rank = 1
ORDER BY 1
```

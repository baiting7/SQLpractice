# Team Scores in Football Tournament
## Question
https://leetcode.com/problems/team-scores-in-football-tournament/
### Solution
```
SELECT a.*, SUM(CASE WHEN a.team_id=b.host_team AND host_goals>guest_goals THEN 3
                     WHEN a.team_id=b.host_team AND host_goals=guest_goals THEN 1
                     WHEN a.team_id=b.guest_team AND host_goals<guest_goals THEN 3
                     WHEN a.team_id=b.guest_team AND host_goals=guest_goals THEN 1
                     ELSE 0 
                END) AS num_points
FROM teams a 
LEFT JOIN matches b 
ON a.team_id=b.host_team OR a.team_id=b.guest_team
GROUP BY team_id
ORDER BY num_points DESC, a.team_id
```

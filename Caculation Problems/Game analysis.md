# Game Analysis
## 1. Find the first login date for each player
### Question1
https://leetcode.com/problems/game-play-analysis-i/
#### Solution1：use ```Group by```
```
select player_id, min(event_date) as first_login
from Activity
group by player_id
```
#### Analysis
Use MIN() Function to get the first login date.
#### Solution2: use Window function ```MIN() OVER()```
```
SELECT DISTINCT player_id,
MIN(event_date) OVER(PARTITION BY player_id) AS first_login
FROM Activity
ORDER BY player_id ASC
```
## 2. Find the device that is first logged in for each player
### Question2
https://leetcode.com/problems/game-play-analysis-ii/
#### Solution1: use SUBQUERY ```IN```
```
SELECT player_id,device_id
FROM activity
WHERE (player_id,event_date) IN (
SELECT player_id,MIN(event_date)
FROM activity
GROUP BY player_id)
```
#### Analyis
```where (a, b) in (select a, b from t) ```
#### Solution2: use ```JOIN```
```
select distinct a.player_id, a.device_id
from activity a
join (select player_id, min(event_date) as first_d 
  from activity group by player_id) b
on a.event_date = b.first_d and a.player_id = b.player_id
order by a.player_id
```
#### Solution3: use Window function ```RANK() OVER()```
```
select player_id, device_id from
(select player_id, device_id, 
rank() over (partition by player_id order by event_date) rank
from activity) a
where a.rank = 1
```
#### Analysis
Using window function is faster.
## 3. Find the cumulative game score
### Question3
https://leetcode.com/problems/game-play-analysis-iii/
#### Solution: use Window function ```SUM() OVER()```
```
select player_id, event_date, 
sum(games_played) over (partition by player_id order by event_date) as games_played_so_far
from Activity
group by player_id, event_date
```
## 4. Find the fraction of players that logged in again on the day after the first login
### Question
https://leetcode.com/problems/game-play-analysis-iv/
#### Solution
```
select round(count(distinct player_id)/(select count(distinct player_id) from Activity),2) as fraction 
from
(select player_id, event_date, 
 lead(event_date) over (partition by player_id order by event_date) as pervious_date,
 min(event_date) over (partition by player_id) as first_date
 from Activity) t
where DATEDIFF(pervious_date, event_date)=1----limit the consective login
and first_date = event_date----limit the first login
```
#### Analysis
Use window function to calucate the second login and limit the day which is the day after the first login day.



























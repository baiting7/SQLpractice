# Day 1 retentation 
## Question
https://leetcode.com/problems/game-play-analysis-v/
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

We define the install date of a player to be the first login day of that player.

We also define day 1 retention of some date X to be the number of players whose install date is X and they logged back in on the day right after X, divided by the number of players whose install date is X, rounded to 2 decimal places.

Write an SQL query that reports for each install date, the number of players that installed the game on that day and the day 1 retention.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-01 | 0            |
| 3         | 4         | 2016-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+------------+----------+----------------+
| install_dt | installs | Day1_retention |
+------------+----------+----------------+
| 2016-03-01 | 2        | 0.50           |
| 2017-06-25 | 1        | 0.00           |
+------------+----------+----------------+
Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 so the day 1 retention of 2016-03-01 is 1 / 2 = 0.50
Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00
### Solution1: use ```Join```
```
with dataset_app_installs as
(select 
player_id, event_date, 
row_number() over(partition by player_id order by event_date) as rno
from Activity)
    
select A.event_date install_dt, count(distinct A.player_id) as installs, round(count(B.player_id)/count(distinct A.player_id),2) as Day1_retention
from dataset_app_installs AS A
left join dataset_app_installs as B on A.player_id=B.player_id 
and B.event_date=date_add(A.event_date, interval 1 day) 
where A.rno=1  
group by A.event_date
```
Notice use ```and``` in ```left join dataset_app_installs as B on A.player_id=B.player_id and B.event_date=date_add(A.event_date, interval 1 day)```.  
Use palyer_id in different tables by ```Left Join``` to calculate different counts.
### Solution2: use ```case when...then...```
```
with res as (
select a.player_id, a.event_date, 
case when a.event_date + 1 = lead(a.event_date) over (partition by a.player_id order by a.event_date) then 1 else 0 end nextday, 
rank() over (partition by a.player_id order by a.event_date) rn
from activity a
)

select substr(r.event_date, 0, 10) install_dt, count(r.player_id) installs, 
round(sum(r.nextday) / count(r.player_id), 2) day1_retention
from res r
where r.rn = 1
group by r.event_date
```
```case when a.event_date + 1 = lead(a.event_date) over (partition by a.player_id order by a.event_date) then 1 else 0 end nextday``` can be used to calculate the day1 login.







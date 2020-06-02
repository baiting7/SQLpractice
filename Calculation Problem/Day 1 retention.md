# Day 1 retentation 
## Question
https://leetcode.com/problems/game-play-analysis-v/
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







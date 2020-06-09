# Create a Session Bar Chart
## Question
https://leetcode.com/problems/create-a-session-bar-chart/
### Solution1
```
select bin, ifnull(total, 0) as total 
 from (
select '[0-5>' as bin
union
select '[5-10>' as bin
union
select '[10-15>' as bin
union
select '15 or more' as bin) as ref
left join
(select bin, count(bin) as total from (
select case when duration/60 between 0 and 5 then '[0-5>'
            when duration/60 between 5 and 10  then '[5-10>'
            when duration/60 between 10 and 15 then '[10-15>'
            when duration/60 >= 15 then '15 or more' end as bin from Sessions) as t
group by bin) as counts
using (bin)
```
### Solution2
```
(select '[0-5>' as bin, sum(case when duration/60 < 5 then 1 else 0 end) as total from sessions)
union
(select '[5-10>' as bin, sum(case when ((duration/60 >= 5) and (duration/60 < 10)) then 1 else 0 end) as total from sessions)
union
(select '[10-15>' as bin, sum(case when ((duration/60 >= 10) and (duration/60 < 15)) then 1 else 0 end) as total from sessions)
union
(select '15 or more' as bin, sum(case when duration/60 >= 15 then 1 else 0 end) as total from sessions)
```

# Weather Type in Each Country
## Question
https://leetcode.com/problems/weather-type-in-each-country/
### Solution
```
select country_name, case when avg(weather_state)<=15 then 'Cold' 
when avg(weather_state)>=25 then 'Hot' else 'Warm' end as weather_type
from Countries c
left join Weather w on c.country_id = w.country_id
where year(day) = 2019 and month(day) = 11
group by country_name
```

# Investments in 2016
## Question
https://leetcode.com/problems/investments-in-2016/
### Solution
```
select sum(TIV_2016) TIV_2016
from insurance
where TIV_2015 in (select TIV_2015 from insurance group by TIV_2015 having count(1)>1)
and (lat, lon) in (select lat, lon from insurance group by lat, lon having count(1)=1)
```
Use ```having count(...)``` to select the same or differnet number or pairs.

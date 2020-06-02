# Active Businesses
## Question
https://leetcode.com/problems/active-businesses/
### Solution
```
select business_id
from
(select business_id, event_type, occurences, 
avg(occurences) over(partition by event_type) as avg
from Events) t
where occurences>avg
group by business_id
having count(business_id)>1
```
can also be
```
SELECT business_id
FROM (
SELECT business_id,event_type,
(occurences - AVG(occurences) OVER (PARTITION BY event_type)) as diff
FROM Events
) a
WHERE a.diff > 0.0
GROUP BY business_id
HAVING COUNT(business_id) > 1
```

# Find the Start and End Number of Continuous Ranges
## Question
https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/
### Solution
```
select min(log_id) as start_id, max(log_id) as end_id
from (
select log_id,  log_id - ifnull(lg, 0) as diff
from (
select log_id, row_number() over () as lg 
from Logs) as t) as t2
group by diff
```

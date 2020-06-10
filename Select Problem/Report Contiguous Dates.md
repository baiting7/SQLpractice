# Report Contiguous Dates
## Question
https://leetcode.com/problems/report-contiguous-dates/
### Solution
```
with fail_success as
(
select fail_date as date, 'failed' as state
from Failed
UNION ALL
select success_date as date, 'succeeded' as state
from Succeeded
), fail_success_2019_report as
(
select date, state,
row_number() over(partition by state order by date) as rn
from fail_success
where date between '2019-01-01' and '2019-12-31'
)
select state as period_state,
min(date) as start_date,
max(date) as end_date
from fail_success_2019_report
group by state, datediff(day,0,date) - rn
order by start_date
```

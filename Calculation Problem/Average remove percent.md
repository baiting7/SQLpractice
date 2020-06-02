# Reported Posts
## Question
https://leetcode.com/problems/reported-posts-ii/
### Solution
```
select round(avg(remove_percent),2) as average_daily_percent
from
(select action_date, 
 100.00*count(distinct r.post_id)/count(distinct a.post_id) as remove_percent
from Actions a
left join Removals r on a.post_id = r.post_id
where action = 'report' and extra = 'spam'
group by action_date) t
```
Use post_id in different tables by ```Left Join``` to calculate different counts.

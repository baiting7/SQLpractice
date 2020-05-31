# Friend Requests II: Who Has the Most Friends
## Question
https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
### Solution
```
select requester_id as id, count(requester_id) as num
from (select requester_id
      from request_accepted
      union all
      select accepter_id
      from request_accepted) t
group by requester_id
order by num desc
limit 1
```
When we want to calculate something where can be in two columns, use ```union all``` to combine the tables vertically.

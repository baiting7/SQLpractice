# Market analysis
## Question
https://leetcode.com/problems/market-analysis-ii/
### Solution
```
select u.user_id as seller_id, (case when t.item_brand = u.favorite_brand then 'yes' else 'no' end) as '2nd_item_fav_brand'
from
(select seller_id, item_brand, rank() over(partition by seller_id order by order_date) as rank
from Orders o, Items i
where o.item_id = i.item_id) t
right join Users u on u.user_id = t.seller_id and rank = 2
order by seller_id
```

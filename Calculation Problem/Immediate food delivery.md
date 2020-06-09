# Immediate food delivery
## Question1
https://leetcode.com/problems/immediate-food-delivery-i/
### Solution
```
SELECT ROUND(COUNT(d2.delivery_id)/COUNT(d1.delivery_id)*100,2) AS immediate_percentage 
FROM Delivery d1 
LEFT JOIN Delivery d2 ON d2.order_date = d2.customer_pref_delivery_date 
AND d1.delivery_id = d2.delivery_id
```
## Question2
https://leetcode.com/problems/immediate-food-delivery-ii/
### Solution1
```
select round(100.0*sum(case when t.order_date = t.customer_pref_delivery_date then 1 else 0 end)/count(distinct customer_id), 2) as immediate_percentage
from
(select customer_id, order_date, customer_pref_delivery_date, rank() over(partition by customer_id order by order_date) as rank
from Delivery) t
where rank=1
```
### Solution2
```
SELECT ROUND(100*SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)/ COUNT(distinct customer_id) ,2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
SELECT customer_id, min(order_date) as min_date
FROM Delivery
GROUP BY customer_id)
```
Notice ```100.0```.

# Customers Who Bought Products A and B but Not C
## Question
https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/
### Solution1: use subquery
```
select distinct customer_id, customer_name
from Customers
where customer_id in (select customer_id from Orders where product_name='A') 
and customer_id in (select customer_id from Orders where product_name='B') 
and customer_id not in (select customer_id from Orders where product_name='C') 
```
### Solution2: use ```having sum()```
```
select a.customer_id, a.customer_name
from customers a , orders b
where a.customer_id = b.customer_id
group by a.customer_id
having sum(b.product_name="A") >0 
and sum(b.product_name="B") > 0 
and sum(b.product_name="C")=0
```
### Solution3: use ```left outer join```
```
SELECT c.customer_id, c.customer_name
FROM Customers c
JOIN Orders a ON a.customer_id = c.customer_id AND a.product_name = "A"
JOIN Orders b ON b.customer_id = c.customer_id AND b.product_name = "B"
LEFT OUTER JOIN Orders o on o.customer_id = c.customer_id AND o.product_name = "C"
WHERE o.order_id IS NULL
```

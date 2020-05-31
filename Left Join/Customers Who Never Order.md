# Customers Who Never Order
## Question
https://leetcode.com/problems/customers-who-never-order/
### My Solution: Left Join + NULL
```
select Name as Customers
from Customers c
left join Orders o on c.ID=o.CustomerID
where o.CustomerID is null
```
### Solution2: Subquery
```
select customers.name as 'Customers'
from customers
where customers.id not in
(select customerid from orders)
```

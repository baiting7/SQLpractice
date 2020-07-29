# Customers Who Bought Products A and B but Not C
## Question
https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/
Table: Customers

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| customer_id         | int     |
| customer_name       | varchar |
+---------------------+---------+
customer_id is the primary key for this table.
customer_name is the name of the customer.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_name  | varchar |
+---------------+---------+
order_id is the primary key for this table.
customer_id is the id of the customer who bought the product "product_name".
 

Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them buy this product.

Return the result table ordered by customer_id.

The query result format is in the following example.

 

Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Diana         |
| 3           | Elizabeth     |
| 4           | Jhon          |
+-------------+---------------+

Orders table:
+------------+--------------+---------------+
| order_id   | customer_id  | product_name  |
+------------+--------------+---------------+
| 10         |     1        |     A         |
| 20         |     1        |     B         |
| 30         |     1        |     D         |
| 40         |     1        |     C         |
| 50         |     2        |     A         |
| 60         |     3        |     A         |
| 70         |     3        |     B         |
| 80         |     3        |     D         |
| 90         |     4        |     C         |
+------------+--------------+---------------+

Result table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 3           | Elizabeth     |
+-------------+---------------+
Only the customer_id with id 3 bought the product A and B but not the product C.
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

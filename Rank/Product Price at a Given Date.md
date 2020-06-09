# Product Price at a Given Date
## Question
https://leetcode.com/problems/product-price-at-a-given-date/
### Solution
```
WITH havechange AS (
    SELECT * 
    FROM (
        SELECT *, RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rnk
        FROM products
        WHERE change_date<='2019-08-16') sub1
    WHERE rnk=1)

SELECT b.product_id, IFNULL(a.new_price, 10) AS price
FROM havechange a 
RIGHT JOIN ( SELECT DISTINCT product_id FROM products ) b
ON a.product_id=b.product_id
```

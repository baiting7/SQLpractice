# Sale analysis
## Question
https://leetcode.com/problems/sales-analysis-ii/
### Solution
```
select distinct buyer_id
from Sales
where buyer_id in (select buyer_id
                   from Sales
                   join Product 
                   on Sales.product_id = Product.product_id
                   where product_name = 'S8')
and buyer_id not in (select buyer_id
                     from Sales
                     join Product on Sales.product_id = Product.product_id
                     where product_name = 'iPhone')
```
### Worng Solution
```
select distinct(buyer_id)
from Sales
join Product
on Sales.product_id = Product.product_id
where Product.product_name in ('S8') 
and Product.product_name not in ('iPhone')
```
In the example, buyer 1 had one record with S8. buyer 3 had 2 records. The first one with S8, the second one with iPhone.
In your query, it filters out the buyer 3 with iPhone record. But the buyer 3 returned because this person also purchased the S8。







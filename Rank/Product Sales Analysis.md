# Product Sales Analysis
## Question
https://leetcode.com/problems/product-sales-analysis-iii/
### Solution
```
select product_id, first_year, quantity, price
from (
    select product_id, year as first_year, quantity, price,
    rank() over (partition by product_id order by year) as rnk
    from sales) t
where rnk=1
```

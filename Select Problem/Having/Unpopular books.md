# Unpopular books
## Question
https://leetcode.com/problems/unpopular-books/
### Solution
```
select b.book_id, b.name
from books as b
left join orders as o
on o.book_id = b.book_id
where available_from <= '2019-05-23'
group by b.book_id
having sum(case when dispatch_date between '2018-06-23' and '2019-06-23' then quantity else 0 end) <10
```

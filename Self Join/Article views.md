# Article Views
## Question
https://leetcode.com/problems/article-views-ii/
### Solution
```
select distinct a.viewer_id as id
from Views a, Views b
where a.viewer_id = b.viewer_id 
and a.view_date = b.view_date
and a.article_id <> b.article_id
group by a.viewer_id
having count(a.article_id) >=1
```
### A easy solution
```
select distinct viewer_id as id
from Views
group by viewer_id,view_date
having count(distinct article_id)>1
order by viewer_id
```

# Movie Rating
## Question
https://leetcode.com/problems/movie-rating/
### Solution
```
select results from
((select name as results,a.user_id as id,count(*) as output
from Movie_Rating a left join Users b on a.user_id=b.user_id
group by results
order by output desc,name asc limit 1)
union
(select title as results,a.movie_id as id,avg(rating) as output
from Movie_Rating a left join Movies b on a.movie_id=b.movie_id
where created_at between date('2020-02-01') and date('2020-02-29')
group by results
order by output desc,title asc limit 1))temp
```

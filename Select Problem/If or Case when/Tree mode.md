# Tree mode
## Question
https://leetcode.com/problems/tree-node/
### Solution1: use ```case when```
```
select id, 
case when  p_id is null then 'Root'
     when id in (select p_id from tree) then 'Inner'
     else 'Leaf' end as Type
from tree
order by id
```
### Solution2: use ```if```
```
select t.id, 
       if(t.p_id is null, 'Root',
          if(t.id not in (select t1.p_id 
                          from tree t1
                          where t1.p_id is not null
                         ), 'Leaf', 'Inner')
         ) as Type
from tree t
order by t.id;
```

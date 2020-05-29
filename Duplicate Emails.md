# Duplicate Emails
## Question1: Select duplicate emails
https://leetcode.com/problems/duplicate-emails/
### My Solution: Use Self Join
```
select distinct p1.Email
from Person p1, Person p2
where p1.Email=p2.Email
and p1.ID<>p2.ID
```
### Solution2: Use Group by and Having
```
select Email
from Person
group by Email
having count(Email) > 1
```
## Question2: Delete duplicate emails
https://leetcode.com/problems/delete-duplicate-emails/
### Solution1: Use Self Join
```
DELETE p1 FROM Person p1,Person p2
WHERE p1.Email = p2.Email AND p1.Id > p2.Id
```
### Solution2: Use Min Function
```
DELETE FROM Person WHERE Id NOT IN 
(SELECT * FROM(SELECT MIN(Id) FROM Person GROUP BY Email) as p)
```

# Duplicate Emails
## Question1: Select duplicate emails
https://leetcode.com/problems/duplicate-emails/
Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+

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
Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
For example, after running your query, the above Person table should have the following rows:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

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

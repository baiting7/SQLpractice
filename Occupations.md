# Occupations
### Questions Link: https://www.hackerrank.com/challenges/occupations/problem

```sql
SET @r1=0, @r2=0, @r3 =0, @r4=0;
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor) FROM
(SELECT CASE Occupation WHEN 'Doctor' THEN @r1:=@r1+1
                       WHEN 'Professor' THEN @r2:=@r2+1
                       WHEN 'Singer' THEN @r3:=@r3+1
                       WHEN 'Actor' THEN @r4:=@r4+1 END
       AS RowLine,
       CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
       CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
       CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
       CASE WHEN Occupation = 'Actor' THEN Name END AS Actor
       FROM OCCUPATIONS ORDER BY Name) AS t
GROUP BY RowLine;
```
### Steps
- step1: create a table for converting rows to columns 
  - pivot: https://www.sqlservertutorial.net/sql-server-basics/sql-server-pivot/
  - @rowname
    - there is a new created column which used to increase one row in each column
    - r1=0,r2=0,r3=0,r4=0 represents rowline for each column
    - each same occupation will increase one row
  - use case when to select differnet occupation
- step2: using GROUP BY to group table t, each row include one `Doctor`, one `Professor`, one `Singer` and one `Actor`.
- step3: `Min` function is used to sorte name alphabetically

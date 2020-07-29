# Consecutive Question
## Question1: Consecutive available seats
https://leetcode.com/problems/consecutive-available-seats/
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
 

Your query should return the following result for the sample case above.
 

| seat_id |
|---------|
| 3       |
| 4       |
| 5       |
Note:
The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.

### Solution1: use ```JOIN```
```
select distinct a.seat_id
from cinema a join cinema b
  on abs(a.seat_id - b.seat_id) = 1
  and a.free = 1 and b.free = 1
order by a.seat_id
```
### Solution2: use window function
```
select seat_id
from (
SELECT seat_id,free,sum(free) over (rows between 1 preceding and 1 following) as sums
from cinema)as t1
where sums >=2 and free=1
order by seat_id
```
## Question2：Consecutive Number
https://leetcode.com/problems/consecutive-numbers/
Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
### My Solution: use window Function
```
SELECT DISTINCT Num AS ConsecutiveNums
FROM
(
SELECT Num,LEAD(Num) OVER(ORDER BY ID) AS lead, LAG(Num) OVER (ORDER BY Id) AS lag
FROM Logs)t
WHERE Num=lead and Num=lag;
```
### Another Solution
#### Analysis
Fully join 3 Logs tables, and they are used to search for the first, second and third number respectively. Exclude duplicates as well.
#### Solution
```
SELECT DISTINCT l1.Num AS ConsecutiveNums 
FROM Logs AS l1, Logs AS l2, Logs AS l3
WHERE l1.Num = l2.Num 
AND l2.Num = l3.Num 
AND l1.Id = l2.Id - 1 
AND l2.Id = l3.Id - 1;
```
## Question3: Human Traffic of Stadium
https://leetcode.com/problems/human-traffic-of-stadium/
X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

For example, the table stadium:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
For the sample data above, the output is:

+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
Note:
Each day only have one row record, and the dates are increasing with id increasing.
### Analysis
When we join the 3 tables, we are changing the date from column to row. The 3 consective number a,b and c are in one row, so when we select the column a, we will just get one number. However, we need the number a,b and c so that we shpuld consider 3 situations, which are a in the beginning, mediuma and end so that when we select the colmun a, we can get a,b and c.
### Solution
```
select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
((t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1) or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2))
order by t1.id
```














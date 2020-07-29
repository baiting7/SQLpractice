# Median Problem
## Question1: Median Employee Salary
https://leetcode.com/problems/median-employee-salary/
The Employee table holds all employees. The employee table has three columns: Employee Id, Company Name, and Salary.

+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|1    | A          | 2341   |
|2    | A          | 341    |
|3    | A          | 15     |
|4    | A          | 15314  |
|5    | A          | 451    |
|6    | A          | 513    |
|7    | B          | 15     |
|8    | B          | 13     |
|9    | B          | 1154   |
|10   | B          | 1345   |
|11   | B          | 1221   |
|12   | B          | 234    |
|13   | C          | 2345   |
|14   | C          | 2645   |
|15   | C          | 2645   |
|16   | C          | 2652   |
|17   | C          | 65     |
+-----+------------+--------+
Write a SQL query to find the median salary of each company. Bonus points if you can solve it without using any built-in SQL functions.

+-----+------------+--------+
|Id   | Company    | Salary |
+-----+------------+--------+
|5    | A          | 451    |
|6    | A          | 513    |
|12   | B          | 234    |
|9    | B          | 1154   |
|14   | C          | 2645   |
+-----+------------+--------+

### Solution
```
with temp as
(select Id, Company, Salary, 
 row_number() over (partition by company order by salary) as rank,
 count(*) over (partition by company) as cnt
 from Employee) 

select ID,Company,avg(salary) as Salary
from temp
where rank between (cnt+1)/2 and (cnt+2)/2
group by ID,Company,rank,cnt
```
## Question2:Find Median Given Frequency of Numbers
https://leetcode.com/problems/find-median-given-frequency-of-numbers/
The Numbers table keeps the value of number and its frequency.

+----------+-------------+
|  Number  |  Frequency  |
+----------+-------------|
|  0       |  7          |
|  1       |  1          |
|  2       |  3          |
|  3       |  1          |
+----------+-------------+
In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

+--------+
| median |
+--------|
| 0.0000 |
+--------+
Write a query to find the median of all numbers and name the result as median.

### Solution
```
select avg(Number*1.0) as median
from
(select Number, Frequency, 
sum(Frequency) over () as total_sum,
sum(Frequency) over (order by Number) as cumu_sum
from Numbers
group by Number, Frequency) t
where cumu_sum between total_sum/2.0 and total_sum/2.0+Frequency
```
### 3 ways to calculate the median
https://codingsight.com/calculate-the-median-by-using-tsql/

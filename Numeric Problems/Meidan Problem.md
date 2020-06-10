# Median Problem
## Question1: Median Employee Salary
https://leetcode.com/problems/median-employee-salary/
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

# Average Salary: Departments VS Company
##  Question
https://leetcode.com/problems/average-salary-departments-vs-company/
### Solution
```
with tb1 as(
select date_format( a.pay_date,'%Y-%m') pay_month, b.department_id,
avg(a.amount) over (partition by date_format( pay_date,'%Y-%m')) company_salary,
avg(a.amount) over (partition by b.department_id, date_format( pay_date, '%Y-%m')) dept_salary
from salary a
join employee b
on a.employee_id = b.employee_id)

select distinct pay_month, department_id,
case when company_salary > dept_salary then 'lower'
when company_salary < dept_salary then 'higher'
else 'same' end comparison
from tb1
order by 1 desc
```

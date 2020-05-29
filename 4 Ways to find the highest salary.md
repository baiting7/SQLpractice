# 4 Ways to find the highest salary
## Question
https://leetcode.com/problems/nth-highest-salary/
## 1. Using correlated subquery
One of the most common ways to solve this problem of finding the Nth maximum salary from Employee table is by using the correlated subquery. This is a special type of subquery where the subquery depends upon the main query and execute for every row returned by the main query.  It's slow but it can solve problems which are difficult to solve otherwise. Let's see the SQL query to find the Nth highest salary using the Correlated subquery.
### Solution1
```
SELECT name, salary 
FROM Employee e1 
WHERE N-1 = (
  SELECT COUNT(DISTINCT salary) 
  FROM Employee e2 
  WHERE e2.salary > e1.salary)
```
### Explanation
The distinct keyword is there to deal with duplicate salaries in the table. In order to find the Nth highest salary, we are only considering unique salaries. Highest salary means no salary is higher than it, Second highest means only one salary is higher than it, 3rd highest means two salaries are higher than it, similarly Nth highest salary means N-1 salaries are higher than it.
### Pros
The generic solution works in all database including Oracle, MySQL, SQL SERVER and PostgreSQL.
### Cons 
Slow, because the inner query will run for every row processed by the outer query.

## 2. Using Top Keyword in SQL Server
You can use the TOP keyword to find the Nth highest salary in SQL SERVER. This is also faster than the previous solution because here we are calculating Nth maximum salary without a subquery.
### Solution2
```
SELECT TOP 1 salary 
FROM ( 
  SELECT DISTINCT TOP 3 salary 
  FROM Employee 
  ORDER BY salary DESC ) AS temp 
ORDER BY salary
```
### Explanation
By default ORDER BY clause print rows in ascending order, since we need the highest salary at the top, we have used ORDER BY DESC, which will display salaries in descending order. Again DISTINCT is used to remove duplicates. The outer query will then pick the top most salary, which would be your Nth highest salary.

## 3. Using Limit Keyword in MySQL
Similar to TOP, MySQL also supports a LIMIT keyword, which provides pagination capability. You can find the nth highest salary in MySQL without using subquery as shown below.
```
SELECT salary 
FROM Employee 
ORDER BY salary DESC LIMIT N-1, 1
```
#### SQL limit N 1
The clause LIMIT n-1, 1 returns 1 row starting at the row n.
### Explanation
The benefit of this approach is that it's faster than correlated query approach but its vendor dependent. This solution will only work in MySQL database.

## 4. Using ROW_NUMBER() Function
```
SELECT * 
FROM ( 
SELECT e.*, ROW_NUMBER() OVER (ORDER BY salary DESC) rn FROM Employee e ) 
WHERE rn = N;
```
## Explanation
By the above code has a problem. It is not handling duplicate salaries properly. For example, in our table we have two employees with salary 3000, that's our 4th highest salary, but above code will print the same salary, albeit different employee for both 4th and 5th maximum as shown below.












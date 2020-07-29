# Students Report By Geography
## Question
https://leetcode.com/problems/students-report-by-geography/
A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
 

| name   | continent |
|--------|-----------|
| Jack   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jane   | America   |
 

Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
 

For the sample input, the output is:
 

| America | Asia | Europe |
|---------|------|--------|
| Jack    | Xi   | Pascal |
| Jane    |      |        |
 

Follow-up: If it is unknown which continent has the most students, can you write a query to generate the student report?
 
### Solution
```
SELECT America,Asia,Europe
from
(select *,
 row_number() over (partition by continent order by name) rank
 from student) AS RESULT
pivot
( max(name) 
 FOR  CONTINENT IN ([America],[Asia],[Europe])) AS PIV
```
### PIVOT
#### Syntax
```
SELECT first_column AS <first_column_alias>,
[pivot_value1], [pivot_value2], ... [pivot_value_n]
FROM 
(<source_table>) AS <source_table_alias>
PIVOT 
(aggregate_function(<aggregate_column>)
 FOR <pivot_column>
 IN ([pivot_value1], [pivot_value2], ... [pivot_value_n])
) AS <pivot_table_alias>;
```
#### Parameters or Arguments
```first_column```  
A column or expression that will display as the first column in the pivot table.  
```first_column_alias```  
The column heading for the first column in the pivot table.  
```pivot_value1, pivot_value2, ... pivot_value_n```  
A list of values to pivot.  
```source_table```  
A SELECT statement that provides the source data for the pivot table.  
```source_table_alias```  
An alias for source_table.  
```aggregate_function```  
An aggregate function such as SUM, COUNT, MIN, MAX, or AVG.  
```aggregate_column```  
The column or expression that will be used with the aggregate_function.  
```pivot_column```
The column that contains the pivot values.  
```pivot_table_alias```
An alias for the pivot table.  
#### Examples
https://www.techonthenet.com/sql_server/pivot.php
















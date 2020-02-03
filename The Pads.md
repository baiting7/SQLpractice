# The Pads
### Question Link:https://www.hackerrank.com/challenges/the-pads/problem
### Solution1
```sql
select concat(name, '(', left(occupation, 1), ')')
from occupations
order by name;
```

```sql
select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation;
```
### Solution2
```sql
SELECT CONCAT(Name, '(', SUBSTR(Occupation,1,1),')') 
FROM OCCUPATIONS 
ORDER BY Name;
```

```sql
SELECT CONCAT('There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation), 's.') 
FROM OCCUPATIONS 
GROUP BY Occupation 
ORDER BY COUNT(Occupation), Occupation;
```
### Notes
#### `CONCAT` is used to concat columns and string
#### `LEFT(string, number_of_chars)` 
#### `SUBSTRING(string, start, length)`
#### pay attention to spaces

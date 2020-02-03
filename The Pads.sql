#The Pads
#Question Link:https://www.hackerrank.com/challenges/the-pads/problem
#Solution1
select concat(name, '(', left(occupation, 1), ')')
from occupations
order by name;

select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation;
#Solution2
SELECT CONCAT(Name, '(', SUBSTR(Occupation,1,1),')') 
FROM OCCUPATIONS 
ORDER BY Name;

SELECT CONCAT('There are a total of ', COUNT(Occupation), ' ', LOWER(Occupation), 's.') 
FROM OCCUPATIONS 
GROUP BY Occupation 
ORDER BY COUNT(Occupation), Occupation;
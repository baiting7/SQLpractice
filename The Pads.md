#The Pads

Question Link: https://www.hackerrank.com/challenges/the-pads/problem

'''sql

select concat(name, '(', left(occupation, 1), ')')
from occupations
order by name;

select concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation;

'''

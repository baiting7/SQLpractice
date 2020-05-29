# Date Related Problems —— Date Function Applications
## Question1: Rising temperature
https://leetcode.com/problems/rising-temperature/
### Solution1
```
select w1.Id
from Weather w1
join Weather w2 on datediff(w1.RecordDate, w2.RecordDate)=1
and w1.Temperature > w2.Temperature
```
#### DATEDIFF ( datepart , startdate , enddate ) 
##### datepart
The units in which DATEDIFF reports the difference between the startdate and enddate. Commonly used datepart units include month or second.
The datepart value cannot be specified in a variable, nor as a quoted string like 'month'.
The following table lists all the valid datepart values. DATEDIFF accepts either the full name of the datepart, or any listed abbreviation of the full name
### Solution2
```
select b.id from Weather a, Weather b
where b.Recorddate = dateadd(day,1,a.recorddate)
and a.temperature < b.temperature
```
#### DATEADD (datepart , number , date ) 
##### datepart
The part of date to which DATEADD adds an integer number. This table lists all valid datepart arguments.
##### number
An expression that can resolve to an int that DATEADD adds to a datepart of date. DATEADD accepts user-defined variable values for number. DATEADD will truncate a specified number value that has a decimal fraction. It will not round the number value in this situation.
### Solution3
```
SELECT Weather.Id 
FROM Weather 
JOIN Weather AS w 
ON w.RecordDate = SUBDATE(Weather.RecordDate, 1) 
WHERE  Weather.Temperature > w.Temperature 
```
#### SUBDATE(date, INTERVAL, value unit)










# Replace Employee ID With The Unique Identifier
## Question
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/
### Solution
```
SELECT b.unique_id, a.name 
FROM Employees a
LEFT JOIN EmployeeUNI b
on a.id = b.id
```

# Update Problem
## Question: Swap Salary
https://leetcode.com/problems/swap-salary/
### Solution
```
UPDATE salary
SET
    sex = CASE sex
        WHEN 'm' THEN 'f'
        ELSE 'm'
    END
```

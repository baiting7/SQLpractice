# User purchase platform
## Question
https://leetcode.com/problems/user-purchase-platform/
### Solution
```
SELECT p.spend_date, p.platform, IFNULL(SUM(amount), 0) total_amount, COUNT(DISTINCT u.user_id) total_users
FROM
(SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'both' platform FROM Spending) p 
LEFT JOIN
(SELECT user_id, spend_date, SUM(amount) amount, (CASE WHEN COUNT(DISTINCT platform)>1 THEN "both" ELSE platform END) platform
FROM Spending
GROUP BY spend_date, user_id) u
ON p.platform = u.platform 
AND p.spend_date=u.spend_date
GROUP BY p.spend_date, p.platform
```
First, create a table 'platform'.  
Second, use ```left join```to connect the platform and spending table.  
Third, select relevant information from the two tables.

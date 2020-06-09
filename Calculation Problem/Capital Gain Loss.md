# Capital Gain/Loss
## Question
https://leetcode.com/problems/capital-gainloss/
### Solution
```
SELECT stock_name,
SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
ORDER BY capital_gain_loss DESC
```

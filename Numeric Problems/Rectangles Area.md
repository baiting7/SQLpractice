# Rectangles Area
## Question
https://leetcode.com/problems/rectangles-area/
### Solution
```
SELECT  pt1.id as P1, pt2.id as P2,
		ABS(pt2.x_value - pt1.x_value)*ABS(pt2.y_value-pt1.y_value) as AREA
FROM Points pt1 JOIN Points pt2 
ON pt1.id<pt2.id
AND pt1.x_value!=pt2.x_value 
AND pt2.y_value!=pt1.y_value
ORDER BY AREA DESC, p1 ASC, p2 ASC
```

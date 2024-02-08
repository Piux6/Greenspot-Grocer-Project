-- Merging the cost and prices columns---
USE greenspot;
ALTER TABLE greenspot 
ADD COLUMN Prices DECIMAL(10,2);
UPDATE greenspot SET Prices = CONCAT(cost, price);
ALTER TABLE greenspot 
DROP COLUMN Price, 
DROP COLUMN cost;
SELECT * 
FROM greenspot
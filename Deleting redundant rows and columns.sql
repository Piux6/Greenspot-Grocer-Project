-- Deleting redundant rows and columns
ALTER TABLE greenspot
DROP COLUMN cust; 
DELETE FROM greenspot
WHERE prices = 0.00;
SELECT * 
FROM greenspot
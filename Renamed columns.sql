-- Renamed columns 
ALTER TABLE greenspot 
RENAME COLUMN `Item num` TO `item_no`,
RENAME COLUMN `quantity on-hand` TO `quantity_in_stock`,
RENAME COLUMN `purchase date` TO `Purchase_date1`,
RENAME COLUMN `date sold` TO `date_sold`,
RENAME COLUMN `item type` TO `item_type`;

SELECT * 
FROM greenspot
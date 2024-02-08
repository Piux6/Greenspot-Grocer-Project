-- Merged purchase date and date sold
ALTER TABLE greenspot 
ADD COLUMN purchase_date1 VARCHAR(15);
UPDATE greenspot 
      SET purchase_date1 = CONCAT(Purchase_date,' ', date_sold);
ALTER TABLE greenspot 
DROP COLUMN purchase_date, 
DROP COLUMN date_sold;
SELECT * 
FROM greenspot;
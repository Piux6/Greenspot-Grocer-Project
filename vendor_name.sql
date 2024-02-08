-- creating the vendor name column
ALTER TABLE greenspot 
ADD COLUMN vendor_name VARCHAR(15);
UPDATE greenspot 
SET vendor_name =
			     (SELECT substring(vendor,1,LOCATE(',',vendor)-1))
WHERE vendor_name IS NULL OR vendor_name = '';
SELECT
substring(vendor,1,LOCATE(',',vendor)-1) AS Col1
from greenspot;
SELECT * FROM greenspot;




-- Vendor address
ALTER TABLE greenspot 
ADD COLUMN vendor_address1 VARCHAR(15);
UPDATE greenspot 
SET vendor_address1 =
			    (SELECT SUBSTRING(vendor, 
                 CASE WHEN REGEXP_INSTR(vendor, '[0-9]') > 0 THEN REGEXP_INSTR(vendor, 
                 '[0-9]') ELSE 1 END, LOCATE(',', vendor, REGEXP_INSTR(vendor, '[0-9]')) - CASE WHEN REGEXP_INSTR(vendor, 
                 '[0-9]') > 0 THEN REGEXP_INSTR(vendor, '[0-9]') ELSE 1 END) as extracted_address)
WHERE vendor_address1 IS NULL OR vendor_address1 = '';

SELECT * FROM greenspot;

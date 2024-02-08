-- updating vendor column

UPDATE greenspot AS t1
SET vendor = (
    SELECT derived.vendor 
    FROM (SELECT vendor, description
		  FROM greenspot 
	WHERE vendor IS NOT NULL) AS derived
	WHERE derived.description = t1.description
     LIMIT 1)
WHERE vendor = '';

SELECT * FROM greenspot;
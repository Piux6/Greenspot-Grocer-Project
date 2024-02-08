## Project Scenario

Greenspot Grocer is a small, family-owned online grocery store that is growing rapidly and planning a major expansion. They are currently storing their product data in a spreadsheet format that has become unwieldy and will soon be unable to accommodate their growing inventory.  
They want me, as a back-end developer, to examine their current data and design a relational database that will be able provide the ability to organize and store current data, while providing scalability as the business expands its product offerings.  

## Project Objectives

1. Examine the current data and reorganize it into relational tables using the modeling tool in MySQL Workbench. 
2. Create and load the data into database tables. 
3. Test the database design and verify the design by generating SQL JOIN queries.

## Project Challenge
The challenge of this project will be to build a database that can be used to store and organize the sample data from the .csv file. 
To achieve this, we must:

* Explore the sample data, looking for fields that should be grouped together in tables or columns to be splitted into multiple columns.
  Then identify logical relationships among those tables.

* Use the Modeling tool in MySQL Workbench to generate a database model that includes tables, with their fields, and shows relationships
  between tables with primary keys, and foreign keys where applicable.

* Implement the database design in MySQL Workbench by creating the database and its tables and populating the tables with the sample data provided. 

* Generate SQL JOIN queries to prove the validity of your database design by proving that data can be retrieved from multiple tables in a single query.

## Data Preparation/cleaning: 
The data greespot.csv was imported to MySQL Workbench and the following data preparation/cleaning steps were performed
* Merging columns: columns having same information were merged for uniformity.
```sql
ALTER TABLE greenspot 
ADD COLUMN purchase_date1 VARCHAR(15);
UPDATE greenspot 
      SET purchase_date1 = CONCAT(Purchase_date,' ', date_sold);
ALTER TABLE greenspot 
DROP COLUMN purchase_date, 
DROP COLUMN date_sold;
```
```sql
ALTER TABLE greenspot 
ADD COLUMN Prices DECIMAL(10,2);
UPDATE greenspot SET Prices = CONCAT(cost, price);
ALTER TABLE greenspot 
DROP COLUMN Price, 
DROP COLUMN cost;
```
*Column split: The 'vendor' is splitted to form other columns. 
```sql
ALTER TABLE greenspot 
ADD COLUMN vendor_name VARCHAR(15);
UPDATE greenspot 
SET vendor_name =
			     (SELECT substring(vendor,1,LOCATE(',',vendor)-1))
WHERE vendor_name IS NULL OR vendor_name = '';
SELECT
substring(vendor,1,LOCATE(',',vendor)-1) AS Col1
from greenspot;
```
```sql
ALTER TABLE greenspot 
ADD COLUMN vendor_address1 VARCHAR(15);
UPDATE greenspot 
SET vendor_address1 =
			    (SELECT SUBSTRING(vendor, 
                 CASE WHEN REGEXP_INSTR(vendor, '[0-9]') > 0 THEN REGEXP_INSTR(vendor, 
                 '[0-9]') ELSE 1 END, LOCATE(',', vendor, REGEXP_INSTR(vendor, '[0-9]')) - CASE WHEN REGEXP_INSTR(vendor, 
                 '[0-9]') > 0 THEN REGEXP_INSTR(vendor, '[0-9]') ELSE 1 END) as extracted_address)
WHERE vendor_address1 IS NULL OR vendor_address1 = '';
```

* Renaming columns
```sql
ALTER TABLE greenspot 
RENAME COLUMN `Item num` TO `item_no`,
RENAME COLUMN `quantity on-hand` TO `quantity_in_stock`,
RENAME COLUMN `purchase date` TO `Purchase_date1`,
RENAME COLUMN `date sold` TO `date_sold`,
RENAME COLUMN `item type` TO `item_type`;
```

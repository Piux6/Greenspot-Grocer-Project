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

* Generate SQL JOIN queries to prove the validity of database design by proving that data can be retrieved from multiple tables in a single query.
  
## Data Exploration
The organization provided the data greenspot.csv, containing records of its business activities, in a Microsoft Excel spreadsheet. 

![gree](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/80c162e4-71a1-4cae-882a-445f51dd06d9)


## Data Preparation/cleaning: 
The data greenspot.csv was imported to MySQL Workbench and the following data preparation/cleaning steps were performed
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
* Column split: The 'vendor' is splitted to form other columns. 
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
* Updating Column: The empty spaces in the 'vendor' column were updated with information from other rows with same description.
```sql
UPDATE greenspot AS t1
SET vendor = (
    SELECT derived.vendor 
    FROM (SELECT vendor, description
		  FROM greenspot 
	WHERE vendor IS NOT NULL) AS derived
	WHERE derived.description = t1.description
     LIMIT 1)
WHERE vendor = '';
```
* Deletion of rows and Column: This was done to rows with no  data and columns with insignificant information.
```sql
ALTER TABLE greenspot
DROP COLUMN cust; 
DELETE FROM greenspot
WHERE prices = 0.00;
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
* Other data preparation/cleaning steps involves using the TRIM(), RIGHT() and LEFT() in Excel to further split the vendor column to form the vendor_state, vendor_city and postcode columns.
*Data Preparation/cleaning resultant Dataset
![GREENCSV](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/cfdb1dba-3036-4d67-82bc-8bd017ae2e48)


## Database Model/Design
The next step is to build a database model in MySQL. We begin with identifying tables(entities) then we add keys (Primary/foreign) to be able to establish the relationships among the tables. 

![erd](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/d1b83025-b5f5-4df5-a6a5-21e4c6d7dde6)




## Implemeting Database Designs/models
After finalizing the database model, the next phase involves its implemetation by filling its tables with data sourced from the previously cleaned and prepared greenspot.csv file. Following this, querying the database is essential to extract table information, ensuring its integrity and validity.

![purchase_info](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/0a114a87-71fd-4b74-b80d-3f662724f52b)
![vendor](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/48c0bc1d-7b0b-46ea-be37-4e0144cd37c7)
![inventory_locations](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/95021344-86a4-4741-93de-4793af1d3913)
![items](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/201d5e74-a848-4e5f-8e06-ba3c2317aab1)




## SQL Join Query
This is to prove the validity of the database design by proving that data can be retrieved from multiple tables in a single query.
* Top 5 purchased items, their date of purchase, cost of goods sold and quantity in stock.
```sql
SELECT I.item_name, PI.purchase_date,I.price * PI.quantity AS cost_of_goods_sold, 
	   IV.quantity_in_stock FROM items I
JOIN vendor V
    ON I.item_id = V.vendor_id
JOIN purchase_info PI
    ON I.item_id = PI.purchase_id
JOIN inventory_locations IV
    ON I.item_id = IV.location_id
ORDER BY cost_of_goods_sold DESC
LIMIT 5
```
![top5](https://github.com/Piux6/Greenspot-Grocer-Project/assets/128375363/4d49f1b1-7312-4334-bbb4-9de1218d5e19)





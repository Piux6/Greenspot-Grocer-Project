-- Top 5 purchased items, their date of purchase, cost of goods sold and quantity in stock. 
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
LOAD DATA
APPEND
INTO TABLE order_items
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\''
  (
   order_id,
   line_item_id,
   product_id,
   unit_price,
   quantity
   )


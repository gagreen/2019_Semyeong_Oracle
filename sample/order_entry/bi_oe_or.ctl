LOAD DATA
APPEND
INTO TABLE orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\''
  (
   order_id,
   order_date,
   order_mode,
   customer_id,
   order_status,
   order_total,
   sales_rep_id,
   promotion_id
   )


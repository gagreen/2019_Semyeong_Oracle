LOAD DATA
APPEND
INTO TABLE product_information
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\''
  (
   product_id,
   product_name,
   product_description,
   category_id,
   weight_class,
   supplier_id,
   product_status,
   list_price,
   min_price,
   catalog_url
   )


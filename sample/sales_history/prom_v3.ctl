LOAD DATA 
    INTO TABLE PROMOTIONS
    INSERT
    FIELDS TERMINATED BY '|' OPTIONALLY ENCLOSED BY '^'
(PROMO_ID,
 PROMO_NAME,
 PROMO_SUBCATEGORY,
 PROMO_SUBCATEGORY_ID,
 PROMO_CATEGORY,
 PROMO_CATEGORY_ID,
 PROMO_COST,
 PROMO_BEGIN_DATE DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 PROMO_END_DATE DATE(19) "YYYY-MM-DD-HH24-MI-SS",
 PROMO_TOTAL,
 PROMO_TOTAL_ID)

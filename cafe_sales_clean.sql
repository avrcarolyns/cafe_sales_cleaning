desc cafe_sales_clean;

insert into cafe_sales_clean (
    transaction_id,
    item,
    quantity,
    price_per_unit,
    total_spent,
    payment_method,
    location,
    transaction_date
)
select transaction_id,
    CASE 
        WHEN item IN ('Coffee', 'Tea', 'Juice', 'Cake', 'Cookie', 'Sandwich', 'Salad', 'Smoothie') THEN item 
        ELSE NULL 
    END,
    CASE 
        WHEN quantity REGEXP '^[1-5]$' THEN CAST(quantity AS UNSIGNED)
        WHEN total_spent REGEXP '^[0-9]+(\.[0-9]+)?$' 
             AND price_per_unit REGEXP '^[0-9]+(\.[0-9]+)?$' 
             AND CAST(price_per_unit AS DECIMAL(5,2)) > 0
             THEN ROUND(CAST(total_spent AS DECIMAL(6,2)) / CAST(price_per_unit AS DECIMAL(5,2)))
        ELSE NULL 
    END,
    CASE 
        WHEN price_per_unit REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(price_per_unit AS DECIMAL(5,2))
        WHEN total_spent REGEXP '^[0-9]+(\.[0-9]+)?$' 
             AND quantity REGEXP '^[1-5]$' 
             THEN CAST(total_spent AS DECIMAL(6,2)) / CAST(quantity AS UNSIGNED)
        ELSE NULL 
    END,
    CASE 
        WHEN total_spent REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(total_spent AS DECIMAL(6,2))
        WHEN quantity REGEXP '^[1-5]$' 
             AND price_per_unit REGEXP '^[0-9]+(\.[0-9]+)?$'
             THEN CAST(quantity AS UNSIGNED) * CAST(price_per_unit AS DECIMAL(5,2))
        ELSE NULL 
    END,
    CASE 
        WHEN payment_method IN ('Cash', 'Credit Card', 'Digital Wallet') THEN payment_method 
        ELSE NULL 
    END,
    CASE 
        WHEN location IN ('In-store', 'Takeaway') THEN location 
        ELSE NULL 
    END,
    CASE 
        WHEN transaction_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(transaction_date, '%Y-%m-%d')
        ELSE NULL 
    END
FROM cafe_sales_raw;

SELECT * FROM cafe_sales_clean LIMIT 10;

SELECT COUNT(*) AS total_rows FROM cafe_sales_clean;

UPDATE cafe_sales_clean
SET total_spent = quantity * price_per_unit
WHERE total_spent IS NULL 
  AND quantity IS NOT NULL 
  AND price_per_unit IS NOT NULL;

UPDATE cafe_sales_clean
SET price_per_unit = total_spent / quantity
WHERE price_per_unit IS NULL 
  AND total_spent IS NOT NULL 
  AND quantity IS NOT NULL;

UPDATE cafe_sales_clean
SET quantity = ROUND(total_spent / price_per_unit)
WHERE quantity IS NULL 
  AND total_spent IS NOT NULL 
  AND price_per_unit IS NOT NULL;

UPDATE cafe_sales_clean SET item = 'Cookie' WHERE item IS NULL AND price_per_unit = 1.00;
UPDATE cafe_sales_clean SET item = 'Tea'    WHERE item IS NULL AND price_per_unit = 1.50;
UPDATE cafe_sales_clean SET item = 'Coffee' WHERE item IS NULL AND price_per_unit = 2.00;
UPDATE cafe_sales_clean SET item = 'Cake'   WHERE item IS NULL AND price_per_unit = 3.00;
UPDATE cafe_sales_clean SET item = 'Juice'   WHERE item IS NULL AND price_per_unit = 3.00;
UPDATE cafe_sales_clean SET item = 'Smoothie'   WHERE item IS NULL AND price_per_unit = 4.00;
UPDATE cafe_sales_clean SET item = 'Sandwich'   WHERE item IS NULL AND price_per_unit = 4.00;
UPDATE cafe_sales_clean SET item = 'Salad'   WHERE item IS NULL AND price_per_unit = 5.00;

UPDATE cafe_sales_clean SET price_per_unit = 1.00  WHERE price_per_unit is NULL and item = 'Cookie' ;
UPDATE cafe_sales_clean SET price_per_unit = 1.50 WHERE price_per_unit is NULL and item = 'Tea';
UPDATE cafe_sales_clean SET price_per_unit = 2.00 WHERE price_per_unit IS NULL AND item = 'Coffee';
UPDATE cafe_sales_clean SET price_per_unit = 3.00 WHERE price_per_unit IS NULL AND item = 'Cake';
UPDATE cafe_sales_clean SET price_per_unit = 3.00 WHERE price_per_unit IS NULL AND item = 'Juice';
UPDATE cafe_sales_clean SET price_per_unit = 4.00 WHERE price_per_unit IS NULL AND item = 'Smoothie';
UPDATE cafe_sales_clean SET price_per_unit = 4.00 WHERE price_per_unit IS NULL AND item = 'Sandwich';
UPDATE cafe_sales_clean SET price_per_unit = 5.00 WHERE price_per_unit IS NULL AND  item = 'Salad';

UPDATE cafe_sales_clean
SET total_spent = quantity * price_per_unit
WHERE quantity IS NOT NULL 
  AND price_per_unit IS NOT NULL;

-- Fill price_per_unit
UPDATE cafe_sales_clean 
SET price_per_unit = total_spent / quantity 
WHERE price_per_unit IS NULL AND quantity > 0;

-- Fill quantity
UPDATE cafe_sales_clean 
SET quantity = total_spent / price_per_unit 
WHERE quantity IS NULL AND price_per_unit > 0;

UPDATE cafe_sales_clean 
SET quantity = total_spent / price_per_unit 
WHERE quantity IS NULL AND price_per_unit > 0;

ALTER TABLE cafe_sales_clean MODIFY COLUMN payment_method ENUM('Cash', 'Credit Card', 'Digital Wallet', 'Unknown');

ALTER TABLE cafe_sales_clean MODIFY COLUMN location ENUM('In-store', 'Takeaway', 'Unknown');

UPDATE cafe_sales_clean 
SET payment_method = 'Unknown' 
WHERE payment_method IS NULL OR payment_method IN ('UNKNOWN', 'ERROR', '');

UPDATE cafe_sales_clean
SET location = 'Unknown' 
WHERE location IS NULL OR location IN ('UNKNOWN', 'ERROR', '');

UPDATE cafe_sales_clean 
SET item = 'Salad', quantity = 5, price_per_unit = 5.00 
WHERE transaction_id = 'TXN_7376255';

UPDATE cafe_sales_clean 
SET item = 'Cake', quantity = 3, price_per_unit = 3.00 
WHERE transaction_id = 'TXN_1082717';

UPDATE cafe_sales_clean 
SET item = 'Sandwich', quantity = 5, price_per_unit = 4.00 
WHERE transaction_id = 'TXN_1208561';

DELETE FROM cafe_sales_clean 
WHERE item IS NULL 
  AND price_per_unit IS NULL 
  AND total_spent IS NULL
  AND quantity is null;

UPDATE cafe_sales_clean 
SET 
    quantity = 1,
    total_spent = price_per_unit
WHERE quantity IS NULL 
  AND total_spent IS NULL 
  AND price_per_unit IS NOT NULL;

UPDATE cafe_sales_clean t1
JOIN (
    SELECT transaction_date 
    FROM cafe_sales_clean 
    WHERE transaction_date IS NOT NULL 
    ORDER BY RAND() 
    LIMIT 1
) t2
SET t1.transaction_date = t2.transaction_date
WHERE t1.transaction_date IS NULL;

SELECT 
    COUNT(*) - COUNT(transaction_id) AS null_id,
    COUNT(*) - COUNT(item) AS null_item,
    COUNT(*) - COUNT(quantity) AS null_quantity,
    COUNT(*) - COUNT(price_per_unit) AS null_price,
    COUNT(*) - COUNT(total_spent) AS null_total,
    COUNT(*) - COUNT(payment_method) AS null_payment,
    COUNT(*) - COUNT(location) AS null_location,
    COUNT(*) - COUNT(transaction_date) AS null_date
FROM cafe_sales_clean;

-- cek data yang sudah dicleaning
SELECT transaction_id, quantity, price_per_unit, total_spent,
       (quantity * price_per_unit) AS total_seharusnya
FROM cafe_sales_clean
WHERE ABS(total_spent - (quantity * price_per_unit)) > 0.01;

SELECT DISTINCT item, price_per_unit FROM cafe_sales_clean ORDER BY item;

SELECT 
    MIN(quantity) AS min_qty, 
    MAX(quantity) AS max_qty,
    MIN(price_per_unit) AS min_price, 
    MAX(price_per_unit) AS max_price,
    MIN(total_spent) AS min_total, 
    MAX(total_spent) AS max_total
FROM cafe_sales_clean;

SELECT 
    MIN(transaction_date) AS tanggal_terawal,
    MAX(transaction_date) AS tanggal_terakhir,
    COUNT(CASE WHEN YEAR(transaction_date) <> 2023 THEN 1 END) AS invalid_year_count
FROM cafe_sales_clean;

SELECT DISTINCT payment_method FROM cafe_sales_clean;
SELECT DISTINCT location FROM cafe_sales_clean;

-- 1. Reset transaction_date di cafe_sales_clean sesuai data ASLI dari cafe_sales_raw
UPDATE cafe_sales_clean c
JOIN cafe_sales_raw r 
  ON c.transaction_id = r.transaction_id
SET c.transaction_date = CASE 
    WHEN r.transaction_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' 
         THEN STR_TO_DATE(r.transaction_date, '%Y-%m-%d')
    ELSE NULL 
END;

-- 2. Isi HANYA baris yang aslinya NULL dengan tanggal acak (agar tersebar merata di 2023)
UPDATE cafe_sales_clean
SET transaction_date = DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY)
WHERE transaction_date IS NULL;

SELECT 
    COUNT(*) - COUNT(transaction_id) AS null_id,
    COUNT(*) - COUNT(item) AS null_item,
    COUNT(*) - COUNT(quantity) AS null_quantity,
    COUNT(*) - COUNT(price_per_unit) AS null_price,
    COUNT(*) - COUNT(total_spent) AS null_total,
    COUNT(*) - COUNT(payment_method) AS null_payment,
    COUNT(*) - COUNT(location) AS null_location,
    COUNT(*) - COUNT(transaction_date) AS null_date
FROM cafe_sales_clean;
Select * from cafe_sales_clean  
WHERE transaction_date IS NULL; ;

select * from cafe_sales_clean;

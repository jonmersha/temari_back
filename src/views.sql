create view product_full as
SELECT 
    p.product_id, 
    p.category_id,
    p.product_name, 
    p.description, 
    p.price, 
    p.stock, 
    p.image_url, 
    p.created_at,
    p.updated_at,
    p.merchant_id,
    COUNT(pl.like_id) AS total_likes, 
    COUNT(pv.view_id) AS total_views
FROM 
    products p
LEFT JOIN 
    product_likes pl ON p.product_id = pl.product_id
LEFT JOIN 
    product_views pv ON p.product_id = pv.product_id
GROUP BY 
    p.product_id;



create view promotion_view as SELECT 
    p.promotion_id,
    p.title AS promotion_title,
    p.description AS promotion_description,
    p.start_date,
    p.end_date,
    pi.image_url AS promotion_image_url,
    m.merchant_id,
    m.business_name AS merchant_name,
    m.contact_email AS merchant_email
FROM 
    promotions p
JOIN 
    promotion_images pi ON p.promotion_id = pi.promotion_id
JOIN 
    merchants m ON p.merchant_id = m.merchant_id
ORDER BY 
    p.start_date DESC;



    CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `image_url` varchar(255) DEFAULT 'no.png',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `merchant_id` int DEFAULT NULL,
  `on_discount` varchar(45) NOT NULL DEFAULT '0',
  `discount_end_date` varchar(45) DEFAULT 'CURR_DATE()',
  `discount_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `idx_product_name` (`product_name`),
  KEY `merchant_id` (`merchant_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE
) 

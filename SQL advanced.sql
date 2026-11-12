-- JOINS
select hs.year,hs.country,hs.happiness_score,cs.country,cs.continent
from happiness_scores hs
inner JOIN country_stats cs
ON hs.country=cs.country ;

select p.product_id,p.product_name,o.product_id
from products AS p
LEFT JOIN orders AS o
ON p.product_id=o.product_id
where o.product_id IS NULL;

-- joining 2 tables with 2 columns
select *
from happiness_scores hs
INNER JOIN inflation_rates ir
ON hs.country=ir.country_name AND hs.year=ir.year;

-- self joins
select p1.product_name,p1.unit_price,p2.product_name,p2.unit_price,
p1.unit_price - p2.unit_price as price_diff
from products p1
INNER JOIN products p2
ON p1.product_id<>p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price)<0.25
AND p1.product_name<p2.product_name
ORDER BY price_diff DESC;

-- sub queries in the select clause
SELECT product_id,product_name,unit_price,(SELECT AVG(unit_price) from products)
AS avg_unit_price ,unit_price - (SELECT AVG(unit_price) from products) as diff_price
FROM products
ORDER BY unit_price DESC;

-- sub   queries in the from clause
SELECT fp.factory, fp.product_name, fn.num_products
FROM 
(SELECT factory, product_name
FROM products) AS fp
LEFT JOIN
(SELECT factory, COUNT(product_id) AS num_products
FROM products
GROUP BY factory) AS fn
ON fp.factory=fn.factory
ORDER BY fp.factory,fp.product_name;


select *
from products
WHERE unit_price< ALL (SELECT unit_price
FROM products
WHERE factory='Wicked Choccy''s');

-- CTEs


select o.order_id,o.product_id,o.units,p.unit_price, 
o.units*p.unit_price as amount_spent
from orders o LEFT JOIN products p ON o.product_id=p.product_id;


WITH tas AS 
(select o.order_id, 
SUM(o.units*p.unit_price) as total_amount_spent
from orders o 
LEFT JOIN products p ON o.product_id=p.product_id
GROUP BY  o.order_id
having total_amount_spent>200
ORDER BY  total_amount_spent DESC)

SELECT COUNT(*)
FROM tas;

-- Multiple CTEs
SELECT fp.factory, fp.product_name, fn.num_products
FROM 
(SELECT factory, product_name
FROM products) AS fp
LEFT JOIN
(SELECT factory, COUNT(product_id) AS num_products
FROM products
GROUP BY factory) AS fn
ON fp.factory=fn.factory
ORDER BY fp.factory,fp.product_name; 
   
   
   
WITH fp AS 
(SELECT factory, product_name
    FROM products),
fn AS (
    SELECT factory, COUNT(product_id) AS num_products
    FROM products
    GROUP BY factory)
SELECT fp.factory,fp.product_name,fn.num_products 
FROM fp
LEFT JOIN fn
    ON fp.factory = fn.factory
ORDER BY 
    fp.factory, 
    fp.product_name;
    
    
-- Window Functions
SELECT customer_id, order_id, order_date,transaction_id, ROW_NUMBER() 
OVER(PARTITION BY customer_id ORDER BY transaction_id) as transaction_num 
FROM orders 
ORDER BY customer_id,transaction_id;

SELECT order_id, product_id, units,DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC ) 
as product_rank 
FROM orders
WHERE order_id LIKE '%44262';


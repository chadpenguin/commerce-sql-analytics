-- Original assignment query: Analysis I, Q5
-- Category price ranges
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q5: Categories having price difference greater than 500 BRL

SELECT
    p.product_category_name,
    MAX(oi.price) - MIN(oi.price) AS price_difference
FROM amazon_brazil.product AS p
INNER JOIN amazon_brazil.order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
HAVING MAX(oi.price) - MIN(oi.price) > 500
ORDER BY price_difference DESC;

-- Original assignment query: Analysis II, Q2
-- Category price statistics
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

SELECT
    p.product_category_name,
    MIN(oi.price) AS min_price,
    MAX(oi.price) AS max_price,
    ROUND(AVG(oi.price),2) AS avg_price
FROM amazon_brazil.product p
JOIN amazon_brazil.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC;

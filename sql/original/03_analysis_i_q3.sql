-- Original assignment query: Analysis I, Q3
-- Smart category price filter
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

SELECT
    oi.product_id,
    oi.price
FROM amazon_brazil.order_items AS oi
INNER JOIN amazon_brazil.product AS p
    ON oi.product_id = p.product_id
WHERE oi.price BETWEEN 100 AND 500
  AND p.product_category_name ILIKE '%Smart%'
ORDER BY oi.price DESC;

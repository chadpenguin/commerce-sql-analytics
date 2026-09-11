-- Original assignment query: Analysis III, Q2
-- Products above mean item count
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q2: Products with sales quantity above overall average

SELECT
    product_id,
    COUNT(*) AS total_quantity_sold
FROM amazon_brazil.order_items
GROUP BY product_id
HAVING COUNT(*) >
(
    SELECT AVG(product_count)
    FROM
    (
        SELECT COUNT(*) AS product_count
        FROM amazon_brazil.order_items
        GROUP BY product_id
    ) AS avg_quantity
)
ORDER BY total_quantity_sold DESC;

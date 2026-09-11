-- Original assignment query: Analysis II, Q3
-- Repeat-purchase customers
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM amazon_brazil.customers c
INNER JOIN amazon_brazil.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

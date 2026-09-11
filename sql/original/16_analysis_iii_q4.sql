-- Original assignment query: Analysis III, Q4
-- CTE purchase-frequency segments
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q4: Customer Segmentation using CTE

WITH customer_segment AS
(
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders,
        CASE
            WHEN COUNT(o.order_id) BETWEEN 1 AND 2 THEN 'Occasional'
            WHEN COUNT(o.order_id) BETWEEN 3 AND 5 THEN 'Regular'
            ELSE 'Loyal'
        END AS customer_type
    FROM amazon_brazil.customers AS c
    INNER JOIN amazon_brazil.orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_type,
    COUNT(*) AS customer_count
FROM customer_segment
GROUP BY customer_type
ORDER BY customer_count DESC;

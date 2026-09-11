-- Original assignment query: Analysis III, Q5
-- Original customer payment-average ranking
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q5: Top 20 Customers by Average Order Value

WITH customer_avg_order AS
(
    SELECT
        o.customer_id,
        AVG(p.payment_value) AS avg_order_value
    FROM amazon_brazil.orders AS o
    INNER JOIN amazon_brazil.payments AS p
        ON o.order_id = p.order_id
    GROUP BY o.customer_id
)

SELECT
    customer_id,
    ROUND(avg_order_value, 2) AS avg_order_value,
    RANK() OVER(ORDER BY avg_order_value DESC) AS customer_rank
FROM customer_avg_order
ORDER BY customer_rank
LIMIT 20;

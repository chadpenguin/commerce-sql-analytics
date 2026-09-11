-- Original assignment query: Analysis I, Q2
-- Payment-record mix
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q2: Percentage distribution of orders by payment type

SELECT
    payment_type,
    ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(order_id) FROM amazon_brazil.payments),
        1
    ) AS percentage_orders
FROM amazon_brazil.payments
GROUP BY payment_type
ORDER BY percentage_orders DESC;

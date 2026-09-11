-- Original assignment query: Analysis III, Q3
-- Monthly item sales in 2018
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q3: Monthly Revenue for 2018 (Month Name)

SELECT
    TO_CHAR(o.order_purchase_timestamp, 'FMMonth') AS month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM amazon_brazil.orders AS o
INNER JOIN amazon_brazil.order_items AS oi
    ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY
    EXTRACT(MONTH FROM o.order_purchase_timestamp),
    TO_CHAR(o.order_purchase_timestamp, 'FMMonth')
ORDER BY
    EXTRACT(MONTH FROM o.order_purchase_timestamp);

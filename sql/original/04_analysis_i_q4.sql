-- Original assignment query: Analysis I, Q4
-- Highest sales calendar months pooled across years
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q4: Top 3 months with highest total sales

SELECT
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price), 0) AS total_sales
FROM amazon_brazil.orders AS o
INNER JOIN amazon_brazil.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY total_sales DESC
LIMIT 3;

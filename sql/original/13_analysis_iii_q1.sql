-- Original assignment query: Analysis III, Q1
-- Assignment-defined seasonal buckets
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q1: Total Sales by Season

SELECT
    season,
    ROUND(SUM(total_sales), 2) AS total_sales
FROM
(
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp) IN (3,4,5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp) IN (6,7,8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM o.order_purchase_timestamp) IN (9,10,11) THEN 'Autumn'
            ELSE 'Winter'
        END AS season,
        oi.price AS total_sales
    FROM amazon_brazil.orders AS o
    INNER JOIN amazon_brazil.order_items AS oi
        ON o.order_id = oi.order_id
) AS seasonal_sales
GROUP BY season
ORDER BY total_sales DESC;

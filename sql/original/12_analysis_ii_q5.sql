-- Original assignment query: Analysis II, Q5
-- Top categories by item sales
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q5: Top 5 Revenue Generating Product Categories

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM amazon_brazil.product AS p
INNER JOIN amazon_brazil.order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 5;

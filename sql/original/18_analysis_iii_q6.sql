-- Original assignment query: Analysis III, Q6
-- Original recursive cumulative sales
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q6: Monthly Cumulative Sales using Recursive CTE

WITH RECURSIVE monthly_sales AS
(
    -- Step 1: Monthly sales for each product
    SELECT
        oi.product_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
        SUM(oi.price) AS monthly_sales
    FROM amazon_brazil.orders AS o
    INNER JOIN amazon_brazil.order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY
        oi.product_id,
        DATE_TRUNC('month', o.order_purchase_timestamp)
),

cumulative_sales AS
(
    -- Base Case: First sale month for each product
    SELECT
        ms.product_id,
        ms.sale_month,
        ms.monthly_sales AS total_sales
    FROM monthly_sales ms
    WHERE ms.sale_month =
    (
        SELECT MIN(m2.sale_month)
        FROM monthly_sales m2
        WHERE m2.product_id = ms.product_id
    )

    UNION ALL

    -- Recursive Step
    SELECT
        ms.product_id,
        ms.sale_month,
        cs.total_sales + ms.monthly_sales AS total_sales
    FROM cumulative_sales cs
    INNER JOIN monthly_sales ms
        ON cs.product_id = ms.product_id
       AND ms.sale_month = cs.sale_month + INTERVAL '1 month'
)

SELECT
    product_id,
    TO_CHAR(sale_month, 'Mon YYYY') AS sale_month,
    ROUND(total_sales, 2) AS total_sales
FROM cumulative_sales
ORDER BY
    product_id,
    sale_month;

-- Revised: cumulative item sales over observed months, including nonconsecutive months.
-- This does not generate rows for missing months. No status/refund adjustment applied.
WITH monthly_sales AS (
    SELECT oi.product_id,
           DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
           SUM(oi.price) AS monthly_item_sales
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.order_items oi ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp IS NOT NULL
    GROUP BY oi.product_id, DATE_TRUNC('month', o.order_purchase_timestamp)
)
SELECT product_id, sale_month, monthly_item_sales,
       SUM(monthly_item_sales) OVER (
           PARTITION BY product_id ORDER BY sale_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_item_sales
FROM monthly_sales
ORDER BY product_id, sale_month;

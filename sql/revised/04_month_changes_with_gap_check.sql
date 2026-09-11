-- Revised: compare only adjacent observed calendar months.
-- Missing months are unknown coverage, not automatically zero sales.
WITH monthly_sales AS (
    SELECT p.payment_type,
           DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
           SUM(p.payment_value) AS monthly_payment_value
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.payments p ON p.order_id = o.order_id
    WHERE o.order_purchase_timestamp >= TIMESTAMP '2018-01-01'
      AND o.order_purchase_timestamp < TIMESTAMP '2019-01-01'
    GROUP BY p.payment_type, DATE_TRUNC('month', o.order_purchase_timestamp)
), lagged AS (
    SELECT *,
           LAG(sale_month) OVER (PARTITION BY payment_type ORDER BY sale_month) AS prior_month,
           LAG(monthly_payment_value) OVER (PARTITION BY payment_type ORDER BY sale_month) AS prior_value
    FROM monthly_sales
)
SELECT payment_type, sale_month, monthly_payment_value,
       CASE WHEN sale_month = prior_month + INTERVAL '1 month'
            THEN ROUND(100.0 * (monthly_payment_value - prior_value)
                       / NULLIF(prior_value, 0), 2)
       END AS adjacent_month_change_pct
FROM lagged
ORDER BY payment_type, sale_month;
-- Adjacency does not establish completeness; check partial-month coverage separately.

-- Original assignment query: Analysis III, Q7
-- Original payment-type period changes
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q7: Month-over-Month Sales Growth by Payment Type (2018)

WITH monthly_sales AS
(
    SELECT
        p.payment_type,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
        ROUND(SUM(p.payment_value), 2) AS monthly_total
    FROM amazon_brazil.orders AS o
    INNER JOIN amazon_brazil.payments AS p
        ON o.order_id = p.order_id
    WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
    GROUP BY
        p.payment_type,
        DATE_TRUNC('month', o.order_purchase_timestamp)
)

SELECT
    payment_type,
    TO_CHAR(sale_month, 'FMMonth YYYY') AS sale_month,
    monthly_total,

    ROUND(
        (
            monthly_total -
            LAG(monthly_total) OVER (
                PARTITION BY payment_type
                ORDER BY sale_month
            )
        )
        /
        NULLIF(
            LAG(monthly_total) OVER (
                PARTITION BY payment_type
                ORDER BY sale_month
            ),
            0
        )
        * 100,
        2
    ) AS monthly_change

FROM monthly_sales

ORDER BY
    payment_type,
    sale_month;

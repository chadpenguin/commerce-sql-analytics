-- Original assignment query: Analysis II, Q1
-- Payment-value bands
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

SELECT
    CASE
        WHEN payment_value < 200 THEN 'Less than 200 BRL'
        WHEN payment_value BETWEEN 200 AND 1000 THEN '200-1000 BRL'
        ELSE 'More than 1000 BRL'
    END AS order_value_segment,
    payment_type,
    COUNT(*) AS count
FROM amazon_brazil.payments
GROUP BY
    CASE
        WHEN payment_value < 200 THEN 'Less than 200 BRL'
        WHEN payment_value BETWEEN 200 AND 1000 THEN '200-1000 BRL'
        ELSE 'More than 1000 BRL'
    END,
    payment_type
ORDER BY count DESC;

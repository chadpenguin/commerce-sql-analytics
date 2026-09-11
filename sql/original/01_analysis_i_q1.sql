-- Original assignment query: Analysis I, Q1
-- Average payment amount
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

SELECT 
    payment_type, 
    ROUND(AVG(payment_value)) AS rounded_avg_payment 
FROM 
    amazon_brazil.payments
GROUP BY payment_type
ORDER BY rounded_avg_payment;

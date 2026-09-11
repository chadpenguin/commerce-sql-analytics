-- Original assignment query: Analysis I, Q6
-- Payment standard deviation
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q6: Payment types with least standard deviation

SELECT
    payment_type,
    ROUND(STDDEV(payment_value), 2) AS std_deviation
FROM amazon_brazil.payments
GROUP BY payment_type
ORDER BY std_deviation ASC;

-- Revised interpretation: share of payment rows, not mutually exclusive orders.
SELECT payment_type, COUNT(*) AS payment_records,
       ROUND(100.0 * COUNT(*) / NULLIF(SUM(COUNT(*)) OVER (), 0), 1)
         AS payment_record_share_pct
FROM amazon_brazil.payments
GROUP BY payment_type
ORDER BY payment_record_share_pct DESC;

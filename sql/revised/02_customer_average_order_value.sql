-- Revised: sum payments per order before averaging across persistent customers.
-- Paid orders only. No delivered-status or refund adjustment is imposed.
-- Null persistent customer IDs are excluded explicitly.
WITH order_payments AS (
    SELECT order_id, SUM(payment_value) AS order_payment_value
    FROM amazon_brazil.payments
    GROUP BY order_id
), customer_values AS (
    SELECT c.customer_unique_id, COUNT(*) AS paid_orders,
           AVG(p.order_payment_value) AS avg_order_payment_value
    FROM amazon_brazil.orders o
    JOIN amazon_brazil.customers c ON c.customer_id = o.customer_id
    JOIN order_payments p ON p.order_id = o.order_id
    WHERE c.customer_unique_id IS NOT NULL
    GROUP BY c.customer_unique_id
), ranked AS (
    SELECT *, RANK() OVER (ORDER BY avg_order_payment_value DESC) AS customer_rank
    FROM customer_values
)
SELECT customer_unique_id, paid_orders,
       ROUND(avg_order_payment_value, 2) AS avg_order_payment_value, customer_rank
FROM ranked
WHERE customer_rank <= 20
ORDER BY customer_rank, customer_unique_id;
-- Includes ties: this may return more than 20 customers.

-- Original assignment query: Analysis II, Q4
-- Temporary-table purchase segments
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Analysis II - Q4
-- Categorize customers based on purchase history using a temporary table

-- Step 1: Create a temporary table
CREATE TEMP TABLE customer_types AS
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders,
    CASE
        WHEN COUNT(o.order_id) = 1 THEN 'New'
        WHEN COUNT(o.order_id) BETWEEN 2 AND 4 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_type
FROM amazon_brazil.customers AS c
INNER JOIN amazon_brazil.orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id;

-- Step 2: Join with customers table and display customer type
SELECT
    c.customer_unique_id,
    ct.customer_type
FROM amazon_brazil.customers AS c
INNER JOIN customer_types AS ct
    ON c.customer_unique_id = ct.customer_unique_id
ORDER BY c.customer_unique_id;

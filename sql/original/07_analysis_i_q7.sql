-- Original assignment query: Analysis I, Q7
-- Incomplete product categories
-- Logic preserved; wrapper comments removed so the SQL can be selected/executed.
-- Read docs/QUERY_REVIEW.md before interpreting results.

-- Q7: Products with missing or single-character category names

SELECT
    product_id,
    product_category_name
FROM amazon_brazil.product
WHERE product_category_name IS NULL
   OR LENGTH(TRIM(product_category_name)) = 1;

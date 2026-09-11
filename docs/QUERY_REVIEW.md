# Query review and interpretation boundaries

Original queries retain their assignment logic, including the following limitations. Do not present the original report as fully corrected or independently reproduced.

| Query | Issue | Public interpretation / revision |
|---|---|---|
| I-Q1, I-Q2, II-Q1 | Payments can contain multiple rows per order | Mean, distribution and bands apply to payment records, not necessarily whole orders. Revised example 01 labels the distribution correctly |
| I-Q3 | Filters category text, not product name; returns item rows | Describe a Smart-category item filter; the schema has name length but no actual product-name field |
| I-Q4 | Pools calendar month across years | Not a calendar-year monthly trend or proof of recurring seasonality; verify time coverage |
| I-Q6 | STDDEV is sample standard deviation; tiny/zero-value groups can mislead | Report sample sizes and inspect anomalous payment types; do not equate low variation with business suitability |
| I-Q7 | NULL or trimmed length exactly one | Empty strings are not captured. Preserve this condition when discussing the report's 614 count |
| II-Q4 | Joining the customer-level temporary table back to customers may repeat persistent IDs | For one row per persistent customer, read the temporary table directly or deliberately deduplicate. The temporary table name also makes same-session reruns fail if it already exists |
| III-Q1 | Uses assignment-defined March–May spring, June–August summer | These are teaching buckets, not Brazil's meteorological seasons; do not label them as local seasonality |
| II-Q4 versus III-Q4 | Different segment thresholds | Two different assignment definitions, not interchangeable customer labels. Purchase counts do not establish retention or customer lifetime value |
| III-Q5 | Averages payment rows by order-linked customer_id | Does not calculate persistent-customer AOV correctly for split payments. Revised example 02 aggregates order payments and groups by customer_unique_id |
| III-Q6 | Recursion requires every next month to exist | Later months after a gap can disappear. Revised example 03 uses a window cumulative sum and retains observed months |
| III-Q7 | LAG uses previous observed row; text-month sort may misorder display | Revised example 04 checks month adjacency and sorts a timestamp. Neither version proves each month is complete |

## Shared metric limits

SUM(order_items.price) is item sales value in the included rows: it excludes freight and is not net revenue or profit. SUM(payments.payment_value) is recorded payment value. The original queries generally do not filter order status or adjust for refunds; avoid calling every row a completed sale.

The report describes September 2018 as partial coverage. Confirm the actual date range before trend interpretation. A low last-month total alone is insufficient evidence of an economic collapse or a recurring seasonal effect.

Report recommendations are proposals. Payment preference counts, high average value and repeat purchasing do not by themselves prove campaign effectiveness, loyalty or future profitability.

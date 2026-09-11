<div align="center">

# Commerce SQL Analytics

### Customer behavior. Payment patterns. Better-defined metrics.

**PostgreSQL · 19 assignment queries · CTEs · Window functions · Data quality**

[Explore the queries](#query-catalog) · [Query review](docs/QUERY_REVIEW.md) · [Setup](docs/SETUP.md)

</div>

---

An academic NextLeap case study using a supplied Brazil e-commerce dataset to investigate customer purchasing patterns, payment behavior and product performance.

The original coursework used Amazon Brazil/India framing. This repository does not claim the supplied records are Amazon operational data or that the analysis was commissioned by Amazon. Dataset origin and redistribution rights have not been independently established.

## What the project demonstrates

- Relational joins and aggregation across customers, orders, payments, products and order items.
- CASE-based segmentation, temporary tables, subqueries and CTEs.
- RANK, LAG and recursive queries for analytical questions.
- Translating query outputs into a 25-page coursework report with findings and recommendations.
- Reviewing metric definitions and query grain before making business claims.

The original report identified **614 product records with NULL or single-character category names**. This is a report-backed result, not a fresh database execution. The original condition does not include empty strings; a broader data-quality rule could yield a different count.

## What is included

| Folder | Contents |
|---|---|
| `sql/original/` | 19 original query bodies, separated for readability; original logic preserved |
| `sql/revised/` | Four proposed improvements addressing payment grain, customer order averages and missing months |
| `sql/00_schema.sql` | Empty PostgreSQL schema derived from the supplied script |
| `docs/` | Setup, metric definitions, review findings and validation cases |

**Validation boundary:** queries were reviewed statically. No PostgreSQL execution or re-run against the original dataset was performed for this publication pass. Revised examples are explicitly separate from the coursework and do not reproduce its reported outputs by default.

## Business questions

Which payment methods dominate recorded activity? How do product-category prices vary? Which customers have repeated purchases? How does recorded sales activity change over time? Which data-quality issues affect interpretation?

## Query catalog

| # | Question / actual query scope | Source |
|---|---|---|
| 01 | Average payment amount | [SQL](sql/original/01_analysis_i_q1.sql) |
| 02 | Payment-record mix | [SQL](sql/original/02_analysis_i_q2.sql) |
| 03 | Smart category price filter | [SQL](sql/original/03_analysis_i_q3.sql) |
| 04 | Highest sales calendar months pooled across years | [SQL](sql/original/04_analysis_i_q4.sql) |
| 05 | Category price ranges | [SQL](sql/original/05_analysis_i_q5.sql) |
| 06 | Payment standard deviation | [SQL](sql/original/06_analysis_i_q6.sql) |
| 07 | Incomplete product categories | [SQL](sql/original/07_analysis_i_q7.sql) |
| 08 | Payment-value bands | [SQL](sql/original/08_analysis_ii_q1.sql) |
| 09 | Category price statistics | [SQL](sql/original/09_analysis_ii_q2.sql) |
| 10 | Repeat-purchase customers | [SQL](sql/original/10_analysis_ii_q3.sql) |
| 11 | Temporary-table purchase segments | [SQL](sql/original/11_analysis_ii_q4.sql) |
| 12 | Top categories by item sales | [SQL](sql/original/12_analysis_ii_q5.sql) |
| 13 | Assignment-defined seasonal buckets | [SQL](sql/original/13_analysis_iii_q1.sql) |
| 14 | Products above mean item count | [SQL](sql/original/14_analysis_iii_q2.sql) |
| 15 | Monthly item sales in 2018 | [SQL](sql/original/15_analysis_iii_q3.sql) |
| 16 | CTE purchase-frequency segments | [SQL](sql/original/16_analysis_iii_q4.sql) |
| 17 | Original customer payment-average ranking | [SQL](sql/original/17_analysis_iii_q5.sql) |
| 18 | Original recursive cumulative sales | [SQL](sql/original/18_analysis_iii_q6.sql) |
| 19 | Original payment-type period changes | [SQL](sql/original/19_analysis_iii_q7.sql) |

## Revisions worth inspecting

- [Payment-record share](sql/revised/01_payment_record_mix.sql): labels the actual denominator.
- [Average order payment value](sql/revised/02_customer_average_order_value.sql): aggregates split payments before ranking persistent customers.
- [Cumulative sales across gaps](sql/revised/03_cumulative_sales_across_gaps.sql): continues across nonconsecutive observed months.
- [Adjacent-month changes](sql/revised/04_month_changes_with_gap_check.sql): avoids silently comparing nonadjacent months.

These examples were added during portfolio preparation. See the [review notes](docs/QUERY_REVIEW.md) for the original limitations and the [validation cases](docs/VALIDATION.md) for expected behavior.

## Data and privacy

No raw data, query result rows, original report, personal details, database credentials or machine paths are included. Column names such as customer_id describe the schema; they are not actual customer records. Authorized compatible data is required to run the analysis meaningfully.

See [setup](docs/SETUP.md) before execution. This project demonstrates analysis and proposed recommendations, not deployed changes, measured retention improvement or realized revenue uplift.

# Validation status and expected cases

## Completed in publication preparation

- Read the original SQL and 25-page report.
- Confirmed 19 query blocks: seven in Analysis I, five in Analysis II and seven in Analysis III.
- Preserved original query bodies while removing their outer comment wrappers and non-SQL question labels.
- Added four separately labeled revisions; did not rewrite the user's original file.
- Checked upload file inventory, internal Markdown links and personal/system-information patterns.

## Still required before claiming runtime validation

Execute the schema and queries in PostgreSQL with authorized data. Check key cardinality, dates, null treatment and result reconciliation. The following are test specifications, not tests already passed:

| Case | Expected result |
|---|---|
| One order has payment rows 40 and 60; the same persistent customer's next order has payment 200 | Revised customer average order payment value is 150, not 100 |
| Product sales exist in January (10) and March (20), with February absent | Revised cumulative totals are 10 and 30; original recursion may omit March |
| Payment-type activity exists in January and March only | Revised March month-change percentage is NULL, because February coverage is absent |
| Prior adjacent month has zero recorded value | Revised percentage change is NULL rather than division by zero |
| Two customers tie at rank 20 | Revised customer ranking includes ties and may exceed 20 rows |
| Category values are NULL, empty string, single letter and a normal name | Original incomplete-category query captures NULL and the single letter, not empty string |
| One persistent customer has multiple customer_id records | Revised AOV aggregates across that customer's paid orders; original temporary-table join may duplicate display rows |

No model of future growth, causal effect, net revenue or customer lifetime value is established by these queries.

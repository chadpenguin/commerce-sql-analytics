# Setup and data requirements

Use PostgreSQL with a SQL editor such as psql or pgAdmin. No original database, row-level data or connection configuration is included. A tested PostgreSQL version is not claimed because these publication files have not been executed against PostgreSQL in this pass.

1. Create a new disposable database using your own local connection settings.
2. Inspect and run `sql/00_schema.sql` to create the empty `amazon_brazil` schema and six tables. Do not run it against an existing production schema. Table creation is not idempotent.
3. Load an authorized compatible dataset through your SQL client's import facility. Load customers, product and sellers before orders; then payments and order_items. Follow the exact column order and types in the DDL.
4. Verify primary-key uniqueness, foreign-key coverage, nulls, payment sequence duplicates and timestamp coverage. Payments has no primary key in the original DDL; explicitly assess its intended order_id/payment_sequential grain.
5. Run original queries individually. Analysis II Q4 creates a session-local temporary table: run it in a fresh session if the table already exists. Do not execute all files repeatedly without understanding their state.
6. Read the query-review notes before using outputs. Run revised examples separately and reconcile differences intentionally.

## Table relationships

Customers connect to orders using customer_id. customer_unique_id is the persistent customer identifier used for repeat-purchase analysis. Orders connect to multiple payment rows and multiple item rows. Each order item references a product and seller.

Do not directly join both detail tables and then sum payment values: payment/item combinations can multiply rows. Aggregate to a common grain first.

## What cannot be reproduced from this release alone

The original report's exact output values require the supplied data and its original state. No records or report screenshots have been included. This repository is SQL source plus documentation, not a complete data bundle.

# SQL Task for GoCardless

## Relevant files
- `profiles.yml`: allows to connect to BigQuery
- `gocardless/packages.yml`: dbt packages used
- `gocardless/models/sources.yml`: source table schemas and tests performed against them (which were all successful)
- `gocardless/analyses/`: SQL queries used, before compilation
- `gocardless/target/compiled/`: SQL queries used, after compilation

## Why use dbt for the task?
- less BigQuery-specific syntax to deal with
- allows to design basic data quality tests very quickly
- allows to use pre-defined SQL blocks thanks to macros
- allows not to have some SQL code in Google Slides

ETL Decisions
Decision 1 — Handling Missing and Inconsistent Dates

Problem:
The raw retail_transactions.csv dataset may contain missing or inconsistently formatted date values (e.g., different date formats or null entries). This creates issues when building the dim_date table and performing time-based analysis such as monthly trends.

Resolution:
All date values were standardized into a consistent YYYY-MM-DD format before loading. Records with missing or invalid dates were either corrected (if possible) or excluded from the fact table. A surrogate date_id was then generated and mapped to each transaction to ensure referential integrity with the dim_date table.

Decision 2 — Removing Data Redundancy and Creating Dimensions

Problem:
The raw dataset contained repeated product and store information in every transaction row. This redundancy increases storage usage and leads to potential inconsistencies if the same product or store is recorded differently across rows.

Resolution:
The data was decomposed into separate dimension tables: dim_product and dim_store. Unique records were extracted for each dimension, and duplicate entries were removed. Surrogate keys (product_id, store_id) were assigned and used in the fact_sales table as foreign keys, ensuring a clean star schema design.

Decision 3 — Calculating and Standardizing Sales Metrics

Problem:
The dataset may not consistently provide a reliable total_amount field, or it may contain inconsistencies due to manual entry errors (e.g., mismatch between price and quantity).

Resolution:
The total_amount in the fact_sales table was recalculated using a standardized formula:
total_amount = quantity × unit_price.
This ensured consistency and accuracy across all records. Any anomalies (e.g., negative or zero values) were filtered out or corrected before loading into the warehouse.
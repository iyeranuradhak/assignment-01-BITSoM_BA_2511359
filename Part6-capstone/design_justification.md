Storage Systems

To meet the four goals of the hospital system, a combination of specialized storage systems is used.

For predicting patient readmission risk, a Data Warehouse is used to store cleaned and historical treatment data. This enables efficient analytical queries and model training using structured data such as patient history, diagnoses, and outcomes.

For enabling doctors to query patient history in plain English, a Vector Database is used. Patient records and clinical notes are converted into embeddings using models such as sentence-transformers. This allows semantic search, enabling doctors to retrieve relevant patient information even if the query wording differs from stored text.

For generating monthly reports (e.g., bed occupancy and costs), the Data Warehouse is again used, as it supports OLAP workloads and aggregations required for business intelligence dashboards.

For streaming and storing real-time ICU vitals, a Data Lake is used. It can handle high-velocity, unstructured, and time-series data efficiently. Stream processing tools ingest data continuously into the lake, where it can later be processed for analytics or anomaly detection.

OLTP vs OLAP Boundary

The OLTP (Online Transaction Processing) layer consists of systems such as Electronic Health Records (EHR), billing systems, and ICU monitoring devices. These systems are responsible for capturing real-time, transactional data such as patient updates, treatments, and vitals. They prioritize low-latency writes and high availability.

The OLAP (Online Analytical Processing) layer begins once data is extracted from these operational systems and moved into analytical storage systems like the Data Warehouse and Data Lake. ETL and stream processing pipelines act as the boundary between OLTP and OLAP. Data is cleaned, transformed, and aggregated before being loaded into the warehouse for reporting or used to train machine learning models.

The Vector Database also sits closer to the OLAP side, as it is used for querying and retrieving insights rather than handling transactional updates.

Trade-offs

A significant trade-off in this design is the increased system complexity due to the use of multiple storage systems (Data Warehouse, Data Lake, and Vector Database). While each system is optimized for a specific use case, managing data consistency, integration, and maintenance across them can be challenging.

To mitigate this, a well-defined data pipeline architecture is essential. Centralized ETL and stream processing layers can ensure consistent data flow and transformation logic across systems. Additionally, implementing data governance practices such as schema validation, monitoring, and logging can help maintain data quality and reliability.

Another mitigation strategy is adopting a Data Lakehouse approach in the future, which can unify some of these capabilities and reduce architectural complexity while still supporting both analytical and AI workloads.
Normalization Justification

Keeping all data in a single table may appear simpler initially, but in the case of the orders_flat.csv dataset, it leads to significant inefficiencies and data integrity issues. The dataset combines customer details, order information, and product attributes into one structure, resulting in heavy redundancy.

For example, a customer such as CUST048 appears in multiple orders . In a flat table, their details (name, email, city) would be repeated in every row associated with each order. If the customer’s city changes, this update must be made across all rows. Missing even one row would result in inconsistent data, demonstrating an update anomaly.

Similarly, product information is duplicated across multiple orders. If a product’s price changes, it must be updated in every occurrence. This not only increases storage overhead but also risks data inconsistency. Additionally, if a product exists in only one order and that order is deleted, all information about that product is lost, which is a delete anomaly.

Insert anomalies are also evident. For instance, adding a new product that has not yet been ordered is not possible without inserting a dummy order, which is impractical and violates data integrity.

Normalization addresses these issues by separating the data into logical tables such as Customers, Orders, Products, and Order_Items. This reduces redundancy, ensures consistency, and improves maintainability. Therefore, normalization is not over-engineering but a necessary step for building a reliable and scalable database system.
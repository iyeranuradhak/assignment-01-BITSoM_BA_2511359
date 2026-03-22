--------------------------------------------------
-- DROP TABLES (for re-run)
--------------------------------------------------
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

--------------------------------------------------
-- DIMENSION TABLE: DATE
--------------------------------------------------
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date DATE,
    day INTEGER,
    month INTEGER,
    year INTEGER
);

INSERT INTO dim_date VALUES
(1, '2023-01-01', 1, 1, 2023),
(2, '2023-01-02', 2, 1, 2023),
(3, '2023-01-03', 3, 1, 2023),
(4, '2023-01-04', 4, 1, 2023),
(5, '2023-01-05', 5, 1, 2023);

--------------------------------------------------
-- DIMENSION TABLE: STORE
--------------------------------------------------
CREATE TABLE dim_store (
    store_id VARCHAR PRIMARY KEY,
    store_name VARCHAR,
    city VARCHAR,
    state VARCHAR
);

INSERT INTO dim_store VALUES
('S001', 'Reliance Retail', 'Mumbai', 'Maharashtra'),
('S002', 'Big Bazaar', 'Delhi', 'Delhi'),
('S003', 'D-Mart', 'Bangalore', 'Karnataka');

--------------------------------------------------
-- DIMENSION TABLE: PRODUCT
--------------------------------------------------
CREATE TABLE dim_product (
    product_id VARCHAR PRIMARY KEY,
    product_name VARCHAR,
    category VARCHAR,
    price INTEGER
);

INSERT INTO dim_product VALUES
('P001', 'Laptop', 'Electronics', 60000),
('P002', 'Shirt', 'Clothing', 2000),
('P003', 'Milk', 'Groceries', 60),
('P004', 'Headphones', 'Electronics', 3000),
('P005', 'Rice Bag', 'Groceries', 1200);

--------------------------------------------------
-- FACT TABLE: SALES
--
--------------------------------------------------
CREATE TABLE fact_sales (
    sales_id INTEGER PRIMARY KEY,
    date_id INTEGER,
    store_id VARCHAR,
    product_id VARCHAR,
    quantity INTEGER,
    total_amount INTEGER,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

--------------------------------------------------
-- INSERT SAMPLE DATA (10+ rows)
--------------------------------------------------
INSERT INTO fact_sales VALUES
(1, 1, 'S001', 'P001', 1, 60000),
(2, 1, 'S002', 'P002', 3, 6000),
(3, 2, 'S003', 'P003', 10, 600),
(4, 2, 'S001', 'P004', 2, 6000),
(5, 3, 'S002', 'P005', 5, 6000),
(6, 3, 'S003', 'P001', 1, 60000),
(7, 4, 'S001', 'P002', 4, 8000),
(8, 4, 'S002', 'P003', 20, 1200),
(9, 5, 'S003', 'P004', 3, 9000),
(10, 5, 'S001', 'P005', 2, 2400),
(11, 2, 'S002', 'P001', 1, 60000);
-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

--------------------------------------------------
-- CUSTOMERS TABLE
--------------------------------------------------
CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_name VARCHAR NOT NULL,
    email VARCHAR,
    city VARCHAR
);

INSERT INTO customers VALUES
('CUST001', 'Alice Sharma', 'alice@example.com', 'Mumbai'),
('CUST002', 'Rahul Verma', 'rahul@example.com', 'Delhi'),
('CUST003', 'Sneha Iyer', 'sneha@example.com', 'Chennai'),
('CUST004', 'Arjun Mehta', 'arjun@example.com', 'Bangalore'),
('CUST005', 'Priya Nair', 'priya@example.com', 'Kochi');

--------------------------------------------------
-- PRODUCTS TABLE
--------------------------------------------------
CREATE TABLE products (
    product_id VARCHAR PRIMARY KEY,
    product_name VARCHAR NOT NULL,
    category VARCHAR,
    price INTEGER
);

INSERT INTO products VALUES
('P001', 'Laptop', 'Electronics', 60000),
('P002', 'Phone', 'Electronics', 20000),
('P003', 'Headphones', 'Accessories', 2000),
('P004', 'Keyboard', 'Accessories', 1500),
('P005', 'Monitor', 'Electronics', 12000);

--------------------------------------------------
-- ORDERS TABLE
--------------------------------------------------
CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    order_date DATE,
    status VARCHAR,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
('ORD2001', 'CUST001', '2023-05-20', 'delivered'),
('ORD2002', 'CUST002', '2023-08-22', 'delivered'),
('ORD2003', 'CUST003', '2023-12-12', 'delivered'),
('ORD2004', 'CUST004', '2023-01-07', 'shipped'),
('ORD2005', 'CUST005', '2023-01-19', 'processing');

--------------------------------------------------
-- ORDER ITEMS TABLE
--------------------------------------------------
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id VARCHAR,
    product_id VARCHAR,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1, 'ORD2001', 'P001', 1),
(2, 'ORD2002', 'P002', 2),
(3, 'ORD2003', 'P003', 1),
(4, 'ORD2004', 'P004', 1),
(5, 'ORD2005', 'P005', 2);
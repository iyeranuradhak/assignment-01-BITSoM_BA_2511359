-- =========================
-- 1. CUSTOMERS TABLE
-- =========================
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

INSERT INTO customers VALUES
('C001', 'Rahul Mehta', 'rahul@example.com', 'Mumbai'),
('C002', 'Anita Sharma', 'anita@example.com', 'Delhi'),
('C003', 'Vikram Singh', 'vikram@example.com', 'Bangalore'),
('C004', 'Priya Nair', 'priya@example.com', 'Chennai'),
('C005', 'Karan Patel', 'karan@example.com', 'Ahmedabad');


-- =========================
-- 2. SALES REPRESENTATIVES
-- =========================
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL
);

INSERT INTO sales_reps VALUES
('SR001', 'Amit Sharma', 'amit@company.com'),
('SR002', 'Neha Verma', 'neha@company.com'),
('SR003', 'Rohit Das', 'rohit@company.com'),
('SR004', 'Sneha Iyer', 'sneha@company.com'),
('SR005', 'Arjun Kapoor', 'arjun@company.com');


-- =========================
-- 3. PRODUCTS TABLE
-- =========================
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

INSERT INTO products VALUES
('P001', 'Laptop', 55000.00),
('P002', 'Smartphone', 20000.00),
('P003', 'Tablet', 15000.00),
('P004', 'Headphones', 2000.00),
('P005', 'Keyboard', 1000.00);


-- =========================
-- 4. ORDERS TABLE
-- =========================
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

INSERT INTO orders VALUES
('O001', 'C001', 'SR001', '2024-01-10'),
('O002', 'C002', 'SR002', '2024-01-11'),
('O003', 'C003', 'SR003', '2024-01-12'),
('O004', 'C004', 'SR004', '2024-01-13'),
('O005', 'C005', 'SR005', '2024-01-14');


-- =========================
-- 5. ORDER ITEMS (JUNCTION TABLE)
-- =========================
CREATE TABLE order_items (
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
('O001', 'P001', 1, 55000.00),
('O002', 'P002', 2, 20000.00),
('O003', 'P003', 1, 15000.00),
('O004', 'P004', 3, 2000.00),
('O005', 'P005', 2, 1000.00);



--------------------------------------------------
-- Q1: List all customers from Mumbai along with their total order value
--------------------------------------------------
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name;

--------------------------------------------------
-- Q2: Find the top 3 products by total quantity sold
--------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

--------------------------------------------------
-- Q3: List all sales representatives and the number of unique customers they have handled
--------------------------------------------------
-- Note: No sales_rep data exists in schema, so assuming each order is handled generically
-- If sales_rep column existed in orders table, query would use that
SELECT 
    'Not Available' AS sales_representative,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;

--------------------------------------------------
-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
--------------------------------------------------
SELECT 
    o.order_id,
    SUM(p.price * oi.quantity) AS total_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(p.price * oi.quantity) > 10000
ORDER BY total_order_value DESC;

--------------------------------------------------
-- Q5: Identify any products that have never been ordered
--------------------------------------------------
SELECT 
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
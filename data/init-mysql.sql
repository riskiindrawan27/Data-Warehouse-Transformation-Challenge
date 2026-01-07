-- Retail Business Sample Data for MySQL
-- This script creates tables and populates them with sample data

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS shippers;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Stores Table
CREATE TABLE stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    unit_price DECIMAL(10, 2),
    cost_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Shippers Table
CREATE TABLE shippers (
    shipper_id INT PRIMARY KEY AUTO_INCREMENT,
    shipper_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    store_id INT,
    shipper_id INT,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    order_status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (shipper_id) REFERENCES shippers(shipper_id)
);

-- Create Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Sample Data

-- Customers
INSERT INTO customers (customer_name, email, phone, city, state, country) VALUES
('John Doe', 'john.doe@email.com', '555-0101', 'New York', 'NY', 'USA'),
('Jane Smith', 'jane.smith@email.com', '555-0102', 'Los Angeles', 'CA', 'USA'),
('Bob Johnson', 'bob.j@email.com', '555-0103', 'Chicago', 'IL', 'USA'),
('Alice Brown', 'alice.b@email.com', '555-0104', 'Houston', 'TX', 'USA'),
('Charlie Wilson', 'charlie.w@email.com', '555-0105', 'Phoenix', 'AZ', 'USA'),
('Diana Martinez', 'diana.m@email.com', '555-0106', 'Philadelphia', 'PA', 'USA'),
('Edward Davis', 'edward.d@email.com', '555-0107', 'San Antonio', 'TX', 'USA'),
('Fiona Garcia', 'fiona.g@email.com', '555-0108', 'San Diego', 'CA', 'USA'),
('George Miller', 'george.m@email.com', '555-0109', 'Dallas', 'TX', 'USA'),
('Helen Anderson', 'helen.a@email.com', '555-0110', 'San Jose', 'CA', 'USA');

-- Stores
INSERT INTO stores (store_name, city, state, country) VALUES
('Store East Coast', 'New York', 'NY', 'USA'),
('Store West Coast', 'Los Angeles', 'CA', 'USA'),
('Store Central', 'Chicago', 'IL', 'USA'),
('Store South', 'Houston', 'TX', 'USA');

-- Products
INSERT INTO products (product_name, category, subcategory, unit_price, cost_price) VALUES
('Office Chair', 'Furniture', 'Chairs', 299.99, 150.00),
('Desk Lamp', 'Furniture', 'Furnishings', 49.99, 25.00),
('Laptop Stand', 'Technology', 'Accessories', 89.99, 45.00),
('Wireless Mouse', 'Technology', 'Accessories', 29.99, 15.00),
('Mechanical Keyboard', 'Technology', 'Accessories', 149.99, 75.00),
('Bookshelf', 'Furniture', 'Bookcases', 199.99, 100.00),
('Monitor 27 inch', 'Technology', 'Phones', 399.99, 200.00),
('Printer All-in-One', 'Technology', 'Machines', 299.99, 150.00),
('Paper A4 500 sheets', 'Office Supplies', 'Paper', 9.99, 5.00),
('Pen Set 10pcs', 'Office Supplies', 'Art', 14.99, 7.00),
('Notebook Pack', 'Office Supplies', 'Paper', 19.99, 10.00),
('Desk Organizer', 'Office Supplies', 'Storage', 24.99, 12.00),
('Ergonomic Chair', 'Furniture', 'Chairs', 499.99, 250.00),
('Standing Desk', 'Furniture', 'Tables', 699.99, 350.00),
('USB Hub 7 Port', 'Technology', 'Accessories', 39.99, 20.00);

-- Shippers
INSERT INTO shippers (shipper_name, phone) VALUES
('FedEx Express', '1-800-463-3339'),
('UPS Ground', '1-800-742-5877'),
('DHL Delivery', '1-800-225-5345'),
('USPS Priority', '1-800-275-8777');

-- Orders
INSERT INTO orders (customer_id, store_id, shipper_id, order_date, ship_date, ship_mode, order_status) VALUES
(1, 1, 1, '2024-01-05', '2024-01-07', 'Standard', 'Delivered'),
(2, 2, 2, '2024-01-08', '2024-01-10', 'Express', 'Delivered'),
(3, 3, 1, '2024-01-10', '2024-01-12', 'Standard', 'Delivered'),
(4, 4, 3, '2024-01-12', '2024-01-14', 'Standard', 'Delivered'),
(1, 1, 2, '2024-01-15', '2024-01-16', 'Express', 'Delivered'),
(5, 2, 1, '2024-01-18', '2024-01-20', 'Standard', 'Delivered'),
(6, 3, 4, '2024-01-20', '2024-01-22', 'Economy', 'Delivered'),
(7, 1, 1, '2024-01-22', '2024-01-24', 'Standard', 'Delivered'),
(8, 2, 2, '2024-01-25', '2024-01-26', 'Express', 'Delivered'),
(9, 4, 3, '2024-01-28', '2024-01-30', 'Standard', 'Delivered'),
(10, 3, 1, '2024-02-01', '2024-02-03', 'Standard', 'Delivered'),
(1, 2, 2, '2024-02-05', '2024-02-06', 'Express', 'Delivered'),
(2, 1, 1, '2024-02-08', '2024-02-10', 'Standard', 'Delivered'),
(3, 4, 4, '2024-02-10', '2024-02-12', 'Economy', 'Delivered'),
(4, 3, 2, '2024-02-12', '2024-02-13', 'Express', 'Delivered'),
(5, 1, 1, '2024-02-15', '2024-02-17', 'Standard', 'Delivered'),
(6, 2, 3, '2024-02-18', '2024-02-20', 'Standard', 'Delivered'),
(7, 4, 1, '2024-02-20', '2024-02-22', 'Standard', 'Delivered'),
(8, 3, 2, '2024-02-22', '2024-02-23', 'Express', 'Delivered'),
(9, 1, 4, '2024-02-25', '2024-02-27', 'Economy', 'Delivered'),
(10, 2, 1, '2024-02-28', '2024-03-01', 'Standard', 'Shipped'),
(1, 3, 2, '2024-03-01', '2024-03-02', 'Express', 'Shipped'),
(2, 4, 1, '2024-03-03', NULL, 'Standard', 'Processing'),
(3, 1, 3, '2024-03-05', NULL, 'Standard', 'Processing'),
(4, 2, 1, '2024-03-08', NULL, 'Standard', 'Pending');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, discount) VALUES
(1, 1, 2, 10.00),
(1, 4, 1, 0.00),
(2, 7, 1, 5.00),
(2, 5, 1, 0.00),
(3, 3, 2, 15.00),
(3, 15, 1, 0.00),
(4, 9, 5, 0.00),
(4, 10, 3, 5.00),
(5, 14, 1, 20.00),
(6, 2, 3, 0.00),
(6, 12, 2, 10.00),
(7, 6, 1, 0.00),
(8, 8, 1, 15.00),
(9, 11, 4, 5.00),
(10, 13, 1, 10.00),
(11, 1, 1, 0.00),
(11, 3, 1, 0.00),
(12, 5, 2, 20.00),
(13, 7, 2, 0.00),
(14, 9, 10, 5.00),
(15, 14, 1, 25.00),
(16, 2, 2, 0.00),
(16, 4, 2, 0.00),
(17, 6, 2, 10.00),
(18, 8, 1, 0.00),
(19, 10, 5, 5.00),
(19, 11, 5, 5.00),
(20, 12, 3, 0.00),
(21, 15, 4, 10.00),
(22, 1, 1, 15.00),
(23, 3, 3, 0.00),
(24, 7, 1, 5.00),
(25, 9, 6, 0.00);

-- Create indexes for better query performance
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_store ON orders(store_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

SHOW TABLES;

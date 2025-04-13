CREATE DATABASE bookStoreDB;
USE bookStoreDB;

-- Create a Book Language Table
CREATE TABLE book_language (
     language_id INT PRIMARY KEY AUTO_INCREMENT,
     language_code CHAR(2) NOT NULL,
     language_name VARCHAR(50) NOT NULL
);

-- Create a Publisher Table
CREATE TABLE publisher (
     publisher_id INT PRIMARY KEY AUTO_INCREMENT,
     publisher_name VARCHAR(100) NOT NULL,
     contact_info VARCHAR(100)
);

-- Create an Author Table
CREATE TABLE author (
     author_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(50) NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     birth_date DATE,
     biography TEXT
);

-- Create a Book Table
CREATE TABLE book (
     book_id INT PRIMARY KEY AUTO_INCREMENT,
     title VARCHAR(100) NOT NULL,
     isbn VARCHAR(20) UNIQUE NOT NULL,
     publisher_id INT,
     language_id INT,
     num_pages INT,
     publication_date DATE,
     price DECIMAL(10,2) NOT NULL,
     stock_quantity INT NOT NULL DEFAULT 0,
     FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
     FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book-Author Relationship (Many-to-Many)
CREATE TABLE book_author (
     book_id INT NOT NULL,
     author_id INT NOT NULL,
     PRIMARY KEY (book_id, author_id),
     FOREIGN KEY (book_id) REFERENCES book(book_id),
     FOREIGN KEY (author_id) REFERENCES author(author_id)
);


-- Customer and Address Tables

-- Country
CREATE TABLE country (
     country_id INT PRIMARY KEY AUTO_INCREMENT,
     country_name VARCHAR(100) NOT NULL,
     country_code CHAR(3) NOT NULL
);

-- Address Status
 CREATE TABLE address_status (
     status_id INT PRIMARY KEY AUTO_INCREMENT,
     status_name VARCHAR(20) NOT NULL
);

-- Address
CREATE TABLE address (
     address_id INT PRIMARY KEY AUTO_INCREMENT,
     street_number VARCHAR(10),
     street_name VARCHAR(100) NOT NULL,
     city VARCHAR(50) NOT NULL,
     state VARCHAR(50),
     postal_code VARCHAR(20),
     country_id INT NOT NULL,
     FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Customer
CREATE TABLE customer (
     customer_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(50) NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL,
     phone VARCHAR(20),
     registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Customer Address
CREATE TABLE customer_address (
     customer_id INT NOT NULL,
     address_id INT NOT NULL,
     status_id INT NOT NULL,
     PRIMARY KEY (customer_id, address_id),
     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
     FOREIGN KEY (address_id) REFERENCES address(address_id),
     FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Shipping Method
CREATE TABLE shipping_method (
   method_id INT PRIMARY KEY AUTO_INCREMENT,
   method_name VARCHAR(50) NOT NULL,
   cost DECIMAL(10,2) NOT NULL
);
 
 -- Order Status
CREATE TABLE order_status (
  status_id INT PRIMARY KEY AUTO_INCREMENT,
  status_value VARCHAR(20) NOT NULL
);
 
 -- Customer Order
CREATE TABLE cust_order (
   order_id INT PRIMARY KEY AUTO_INCREMENT,
   customer_id INT NOT NULL,
   order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   shipping_method_id INT NOT NULL,
   dest_address_id INT NOT NULL,
   FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
   FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
   FOREIGN KEY (dest_address_id) REFERENCES address(address_id)
);
 
 -- Order Line
CREATE TABLE order_line (
   line_id INT PRIMARY KEY AUTO_INCREMENT,
   order_id INT NOT NULL,
   book_id INT NOT NULL,
   quantity INT NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
   FOREIGN KEY (book_id) REFERENCES book(book_id)
);
 
 -- Order History
CREATE TABLE order_history (
   history_id INT PRIMARY KEY AUTO_INCREMENT,
   order_id INT NOT NULL,
   status_id INT NOT NULL,
   status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   notes TEXT,
   FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
   FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
 
 -- sample data for demonstration
INSERT INTO book_language (language_code, language_name) VALUES 
  ('EN', 'English'), ('FR', 'French'), ('ES', 'Spanish');
  
INSERT INTO publisher (publisher_name) VALUES 
  ('Penguin Random House'), ('HarperCollins'), ('Simon & Schuster');
  
INSERT INTO author (first_name, last_name) VALUES 
  ('George', 'Orwell'), ('J.K.', 'Rowling'), ('Stephen', 'King');
 
 
-- admin user with full privileges
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON BookStore.* TO 'bookstore_admin'@'localhost';
 
-- read-only user for reports
CREATE USER 'bookstore_report'@'localhost' IDENTIFIED BY 'readonly_pass';
GRANT SELECT ON BookStore.* TO 'bookstore_report'@'localhost';

-- customer service user with limited access
CREATE USER 'bookstore_cs'@'localhost' IDENTIFIED BY 'service_pass';
GRANT SELECT, INSERT, UPDATE ON customer TO 'bookstore_cs'@'localhost';
GRANT SELECT, INSERT, UPDATE ON address TO 'bookstore_cs'@'localhost';
GRANT SELECT, INSERT, UPDATE ON customer_address TO 'bookstore_cs'@'localhost';
GRANT SELECT ON cust_order TO 'bookstore_cs'@'localhost';
 
 
 -- Sample Queries
 -- Find all books by a specific author
SELECT b.title, b.price 
  FROM book b
  JOIN book_author ba ON b.book_id = ba.book_id
  JOIN author a ON ba.author_id = a.author_id
  WHERE a.last_name = 'Rowling';
 
-- Get customer order history
SELECT c.first_name, c.last_name, co.order_date, 
       SUM(ol.quantity * ol.price) AS total_amount
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY co.order_id;

 -- Check inventory status
SELECT b.title, b.stock_quantity
FROM book b
WHERE b.stock_quantity < 5;
  
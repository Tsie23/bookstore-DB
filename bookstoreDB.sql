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
     country_code CHAR(2) NOT NULL
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


# 📚 BookStoreDB: MySQL Database System

## Database Name: BookStoreDB

### 👋 Overview:
This database is designed to manage data related to a book store, including books, authors, publishers, languages, customers, addresses, orders, shipping methods, order statuses, and inventory. 
 
###  🏗️ Table Descriptions:

### 🔹 Core Tables
1. **book_language**: Contains information about the languages in which books are written.
    - Columns: `language_id`, `language_code`, `language_name`

 2. **publisher**: Information about the publishers of the books.
    - Columns: `publisher_id`, `publisher_name`, `contact_info`

 3. **author**: Details about the authors of the books.
    - Columns: `author_id`, `first_name`, `last_name`, `birth_date`, `biography`

 4. **book**: Information about the books in the store.
    - Columns: `book_id`, `title`, `isbn`, `publisher_id`, `language_id`, `num_pages`, `publication_date`, `price`, `stock_quantity`

 5. **book_author**: Represents the many-to-many relationship between books and authors.
    - Columns: `book_id`, `author_id`
    - 
### 👤 Customer and Address Tables
 6. **country**: Details about countries where customers reside.
    - Columns: `country_id`, `country_name`, `country_code`

 7. **address_status**: Status of the customer's address.
    - Columns: `status_id`, `status_name`

 8. **address**: Information about the addresses where customers can be contacted.
    - Columns: `address_id`, `street_number`, `street_name`, `city`, `state`, `postal_code`, `country_id`

 9. **customer**: Information about the customers.
    - Columns: `customer_id`, `first_name`, `last_name`, `email`, `phone`, `registration_date`

 10. **customer_address**: Links customers to their addresses and address statuses.
    - Columns: `customer_id`, `address_id`, `status_id`
     
### 📦 Order Management
 12. **shipping_method**: Methods of shipping available.
    - Columns: `method_id`, `method_name`, `cost`

 13. **order_status**: Status of customer orders.
    - Columns: `status_id`, `status_value`

 14. **cust_order**: Information about customer orders.
    - Columns: `order_id`, `customer_id`, `order_date`, `shipping_method_id`, `dest_address_id`

 15. **order_line**: Details of individual items in a customer order.
    - Columns: `line_id`, `order_id`, `book_id`, `quantity`, `price`

 16. **order_history**: Historical status of customer orders.
    - Columns: `history_id`, `order_id`, `status_id`, `status_date`, `notes`

### Relationships:
- **Books** are connected to **Authors** and **Publishers** through **Many-to-Many** and **One-to-Many** relationships.
- **Customers** have **Addresses** with a certain **Status**.
- **Orders** are linked to **Shipping Methods** and **Dest Addresses**.
- **Order Lines** detail what is in each **Order** and link back to **Books**.

### 🧪 Sample Data
The following data has been pre-inserted:
- Languages: English, French, Spanish
- Publishers: Penguin Random House, HarperCollins, Simon & Schuster
- Authors: George Orwell, J.K. Rowling, Stephen King

### 🔍 Sample Queries:
Use the provided sample data for testing queries and relationships.
1. **Find all books by a specific author** (e.g., J.K. Rowling).
2. **Get customer order history** including total amount spent.
3. **Check inventory status** for books low in stock.

### 👥 Users and Privileges:
- **bookstore_admin**: Full privileges for management and maintenance.
- **bookstore_report**: Read-only access for reporting purposes.
- **bookstore_cs**: Limited access to manage customer and address data, place orders, and check order details.

### 🖼️ Entity Relationship Diagram (ERD):
 The ERD illustrates all key entities (book, author, customer, order) and their relationships. Please refer to the Draw.io file or ERD.png included in the repo.

## 🚀 Getting Started:
- Import the SQL script into MySQL Workbench.
- Run the database creation and data insertion script.
- Create users and assign roles.
- Execute test queries to explore the database.

## ✍️ Contributors
- SQL Design & Implementation: Francis Mujakachi
- ERD Design: Kebaabetswe Sennelo
- Documentation: Mercyline Tata  

---

## ✅ Final Notes
This project demonstrates best practices in database normalization, secure user management, and real-world query building for e-commerce-style operations. Suitable for academic, training, and prototype business systems.

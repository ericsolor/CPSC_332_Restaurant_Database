# Restaurant Database Management System
Cloud PostgreSQL restaurant ordering and reservation database group project
---

## Overview

This project is a restaurant database management system created using PostgreSQL and Supabase.

This database is designed to maintain and support restaurant operational purposes: customers, orders, reservations, menu items, payments, and guest tables in real time.

Concepts being used to demonstrate this database project:
- Primary Keys
- Foreign Keys
- Constraints
- Indexes
- Triggers
- Views
- CRUD Operations

---
## Project Files

### `001_init.sql`

This file is being used to creates the database structure.

Includes:
- Tables
- Primary Keys
- Foreign Keys
- Constraints
- Indexes

---
### `002_seed_data.sql`

This file inserts sample data into all tables.

Includes sample data for:
- Customers
- Orders
- Order Status
- Guest Tables
- Menu Items
- Menu Categories
- Reservations
- Reservation Status
- Payments

---
### `003_queries_examples.sql`

This file contains SQL examples used to test and demonstrate the database's manipulation.

Includes:
- Trigger
- View
- READ queries
- UPDATE queries
- DELETE queries

---
## Main Tables

- Customers
- Orders
- Order_Status
- Guest_Tables
- Menu_Items
- Menu_Categories
- Reservations
- Reservation_Status
- Order_Items
- Payments

---
## Database Features

### Relationships
The database uses foreign keys to connect all related tables.

For Examples:
- Orders connects to Customers and Order_Status
- Reservations connects to Customers, Guest_Tables, and Reservation_Status
- Order_Items connects Orders and Menu_Items
- Menu_Items connects to Menu_Categories

---
### Constraints
Constraints are used to maintain data integrity.

For Examples:
- Customers must have either email or phone number
- Menu item prices must be positive
- Payment amounts must be positive
- Party sizes must be positive
- Table status must be valid

---
### Indexes
Indexes are added on foreign key columns to improve JOIN query performance.

---
### Trigger
The database includes a trigger that prevents reservations where the party size is greater than the table capacity.

---
### View
The database includes a view called `Order_Details_View`.

This view combines:
- order information
- customer information
- payment information
- table information
- order status

into one simplified query.

---
## How to Run

Run the SQL files in this order:

```sql
001_init.sql
002_seed_data.sql
003_queries_examples.sql
```

---
## Contributors

- Eric Solorzano
- Hai Sieu Cao
- Eric Solorzano
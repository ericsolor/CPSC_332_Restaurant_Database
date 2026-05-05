/*
    Contains INSERT statements to seed your database.

    Minimum requirement:

    At least 5 rows per table (every table)
    Data needs to make sense

    Your sample data should be believable and allow queries to show meaningful results.
*/

-- Insert data into Menu_Items table
INSERT INTO "Menu_Items" ("name", "price") VALUES
(),
(),
(),
(),
();

-- Insert data into Customers table
INSERT INTO "Customers" ("name", "phone_number", "email") VALUES
("Fred Jones", "909-476-8104", NULL),
("Daphne Blake", "909-546-2352", "daphblake@gmail.com"),
("Shaggy Rogers", NULL, "shaggster505@hotmail.com"),
("Velma Dinkley", "909-326-7484", NULL),
("Scoobert Doo", NULL, "scoobydoobydoo@hotmail.com");

-- Insert data into Guest_Tables table
INSERT INTO "Guest_Tables" ("capacity", "table_status") VALUES
(),
(),
(),
(),
();

-- Insert data into Reservations table
INSERT INTO "Reservations" ("reservation_time", "party_size", "customer_id", "table_id")
(),
(),
(),
(),
();

-- Insert data into Orders table
INSERT INTO "Orders" ("order_date", "customer_id", "status_id", "order_type", "table_id") VALUES
(),
(),
(),
(),
();

-- Insert data into Order_Items table
INSERT INTO "Order_Items" ("order_id", "item_id", "quantity") VALUES
(),
(),
(),
(),
();

-- Insert data into Order_Status table
INSERT INTO "Order_Status" ("status_name") VALUES
("pending"),
("in-progress"),
("almost-ready"),
("completed"),
("canceled");

-- Insert data into Payments table
INSERT INTO "Payments" ("amount", "payment_date", "payment_method", "order_id") VALUES
(),
(),
(),
(),
();
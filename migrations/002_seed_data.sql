-- Insert data into Order_Status table
INSERT INTO "Order_Status" ("status_name") VALUES
('pending'),
('in-progress'),
('almost-ready'),
('completed'),
('canceled');

-- Insert data into Customers table
INSERT INTO "Customers" ("name", "phone_number", "email") VALUES
('Fred Jones', '909-476-8104', NULL),
('Daphne Blake', '909-546-2352', 'daphblake@gmail.com'),
('Shaggy Rogers', NULL, 'shaggster505@hotmail.com'),
('Velma Dinkley', '909-326-7484', NULL),
('Scoobert Doo', NULL, 'scoobydoobydoo@hotmail.com');

-- Insert data into Guest_Tables table
INSERT INTO "Guest_Tables" ("capacity", "table_status") VALUES
(2, 'available'),
(4, 'occupied'),
(6, 'reserved'),
(4, 'available'),
(8, 'occupied'),
(10, 'available');

-- Insert data into Menu_Items table
INSERT INTO "Menu_Items" ("name", "price") VALUES
('Cheeseburger', 12.99),
('Chicken Alfredo', 15.50),
('Caesar Salad', 9.25),
('Pepperoni Pizza', 18.75),
('Fish Tacos', 13.40),
('Garlic Bread', 5.99),
('Mozzarella Cheese Sticks', 7.99);

-- Insert data into Reservations table
INSERT INTO "Reservations" ("reservation_time", "party_size", "customer_id", "table_id") VALUES
('2026-05-08 18:00:00', 2, 1, 1),
('2026-05-08 19:30:00', 4, 2, 2),
('2026-05-09 17:00:00', 6, 3, 3),
('2026-05-09 20:00:00', 3, 4, 4),
('2026-05-10 18:45:00', 5, 5, 5);

-- Insert data into Orders table
INSERT INTO "Orders" ("order_date", "customer_id", "status_id", "order_type", "table_id") VALUES
('2026-05-07', 1, 1, 'online', NULL),
('2026-05-07', NULL, 2, 'in-house', 2),
('2026-05-08', 3, 3, 'online', NULL),
('2026-05-08', NULL, 4, 'in-house', 4),
('2026-05-09', 5, 5, 'online', NULL),
('2025-05-01', 1, 4, 'online', NULL),
('2024-05-02', 2, 4, 'online', NULL);

-- Insert data into Order_Items table
INSERT INTO "Order_Items" ("order_id", "item_id", "quantity") VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2);

-- Insert data into Payments table
INSERT INTO "Payments" ("amount", "payment_date", "payment_method", "order_id") VALUES
(25.98, '2026-05-07', 'credit', 1),
(15.50, '2026-05-07', 'cash', 2),
(27.75, '2026-05-08', 'debit', 3),
(18.75, '2026-05-08', 'credit', 4),
(26.80, '2026-05-09', 'cash', 5),
(22.24, '2025-05-01', 'credit', 6),
(31.49, '2024-05-02', 'cash', 7);

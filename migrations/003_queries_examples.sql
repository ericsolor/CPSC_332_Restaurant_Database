/*
    This file demonstrates your database operations.

Minimum requirement:

    Include TRIGGER: at least 1 trigger
    Include VIEW: at least 1 view
    Include READ (SELECT): at least 6 queries including JOINs
    Include UPDATE: at least 6 queries
    Include DELETE: at least 6 queries

Total minimum: 19 queries.

Each query must include a short comment describing what it does, for example:

    -- READ: Show all overdue payments with tenant + unit

    -- UPDATE: Update customer name

    -- DELETE: Remove a canceled reservation

Queries should use multiple tables when appropriate (joins) and reflect realistic business questions.
*/

-- TRIGGER: Prevent reservations where the party size is larger than the table capacity
CREATE OR REPLACE FUNCTION check_reservation_capacity()
RETURNS TRIGGER AS $$
DECLARE
    table_capacity INT;
BEGIN
    SELECT "capacity"
    INTO table_capacity
    FROM "Guest_Tables"
    WHERE "table_id" = NEW."table_id";

    IF NEW."party_size" > table_capacity THEN
        RAISE EXCEPTION 'Party size cannot be greater than table capacity';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reservation_capacity_trigger
BEFORE INSERT OR UPDATE ON "Reservations"
FOR EACH ROW
EXECUTE FUNCTION check_reservation_capacity();

-- VIEW: Show order details with customer, status, payment, and table information
CREATE OR REPLACE VIEW "Order_Details_View" AS
SELECT
    o."order_id",
    c."name" AS customer_name,
    o."order_date",
    os."status_name",
    o."order_type",
    gt."table_id",
    p."amount",
    p."payment_method"
FROM "Orders" o
JOIN "Customers" c ON o."customer_id" = c."customer_id"
JOIN "Order_Status" os ON o."status_id" = os."status_id"
LEFT JOIN "Guest_Tables" gt ON o."table_id" = gt."table_id"
LEFT JOIN "Payments" p ON o."order_id" = p."order_id";

-- READ 1: Show all customer orders with their order status
SELECT
    c."name",
    o."order_id",
    o."order_date",
    os."status_name",
    o."order_type"
FROM "Customers" c
JOIN "Orders" o ON c."customer_id" = o."customer_id"
JOIN "Order_Status" os ON o."status_id" = os."status_id";

-- READ 2: Show all menu items that are part of each order
SELECT
    o."order_id",
    mi."name" AS menu_item,
    oi."quantity",
    mi."price"
FROM "Orders" o
JOIN "Order_Items" oi ON o."order_id" = oi."order_id"
JOIN "Menu_Items" mi ON oi."item_id" = mi."item_id";

-- READ 3: Show payment information with customer names
SELECT
    c."name",
    p."payment_id",
    p."amount",
    p."payment_method",
    p."payment_date"
FROM "Payments" p
JOIN "Orders" o ON p."order_id" = o."order_id"
JOIN "Customers" c ON o."customer_id" = c."customer_id";

-- READ 4: Show all reservations with customer and table information
SELECT
    r."reservation_id",
    c."name",
    r."reservation_time",
    r."party_size",
    gt."table_id",
    gt."capacity"
FROM "Reservations" r
JOIN "Customers" c ON r."customer_id" = c."customer_id"
JOIN "Guest_Tables" gt ON r."table_id" = gt."table_id";

-- READ 5: Show total cost of each order using menu item price and quantity
SELECT
    o."order_id",
    c."name",
    SUM(mi."price" * oi."quantity") AS order_total
FROM "Orders" o
JOIN "Customers" c ON o."customer_id" = c."customer_id"
JOIN "Order_Items" oi ON o."order_id" = oi."order_id"
JOIN "Menu_Items" mi ON oi."item_id" = mi."item_id"
GROUP BY o."order_id", c."name";

-- READ 6: Show all records from the order details view
SELECT * FROM "Order_Details_View";


-- UPDATE 1: Change order's status from "pending" to "in progess"
UPDATE "Orders"
SET "status_id" = (SELECT "status_id" FROM "Order_Status" WHERE "status_name" = 'in-progress')
WHERE "order_id" = 1;

-- UPDATE 2: Update customer name 
UPDATE "Customers"
SET "name" = 'Freddie Jones'
WHERE "customer_id" = 1;

-- UPDATE 3: Increase the price of a specific menu item (Cheeseburger)
UPDATE "Menu_Items"
SET "price" = 14.99
WHERE "name" = 'Cheeseburger';

-- UPDATE 4: change party size for a reservation from 4 to 3
UPDATE "Reservations"
SET "party_size" = 3
WHERE "reservation_id" = 2;

-- UPDATE 5: Change a table's status from "available" to "occupied"
UPDATE "Guest_Tables"
SET "table_status" = 'occupied'
WHERE "table_id" = 1;

-- UPDATE 6: Update payment method
UPDATE "Payments"
SET "payment_method" = 'cash'
WHERE "payment_id" = 1;


-- DELETE 1: Remove a cancelled reservation
DELETE FROM "Reservations"
WHERE "reservation_id" = 4;

-- DELETE 2: Remove a menu item
DELETE FROM "Menu_Items"
WHERE "item_id" NOT IN (SELECT DISTINCT "item_id" FROM "Order_Items");

-- DELETE 3: Cancel an entire order (delete from subtables because FK constraints)
-- + Delete order items first
DELETE FROM "Order_Items" WHERE "order_id" = 3;
-- + Delete payment for that order
DELETE FROM "Payments" WHERE "order_id" = 3;
-- + Delete the order itself
DELETE FROM "Orders" WHERE "order_id" = 3;

-- DELETE 4: Remove old payment records older than 1 year (clean up)
DELETE FROM "Payments"
WHERE "payment_date" < (CURRENT_DATE - INTERVAL '1 year');

-- DELETE 5: Remove online orders that customers already picked up (status = "completed")
---- Delete order items first due to FK constraints
DELETE FROM "Order_Items" 
WHERE "order_id" IN (
    SELECT o."order_id" 
    FROM "Orders" o
    JOIN "Order_Status" os ON o."status_id" = os."status_id"
    WHERE os."status_name" = 'completed' AND o."order_type" = 'online'
);
---- Delete payments for those orders
DELETE FROM "Payments" 
WHERE "order_id" IN (
    SELECT o."order_id" 
    FROM "Orders" o
    JOIN "Order_Status" os ON o."status_id" = os."status_id"
    WHERE os."status_name" = 'completed' AND o."order_type" = 'online'
);
---- Delete the completed online orders
DELETE FROM "Orders"
WHERE "order_id" IN (
    SELECT o."order_id" 
    FROM "Orders" o
    JOIN "Order_Status" os ON o."status_id" = os."status_id"
    WHERE os."status_name" = 'completed' AND o."order_type" = 'online'
);

-- DELETE 6: Remove tables that are no longer used (no orders, no reservations)
DELETE FROM "Guest_Tables"
WHERE "table_id" NOT IN (SELECT DISTINCT "table_id" FROM "Orders" WHERE "table_id" IS NOT NULL)
  AND "table_id" NOT IN (SELECT DISTINCT "table_id" FROM "Reservations");


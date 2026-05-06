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

-- Use Database built from Tutorial_1.sql

-- Task 1: Practice 'AS' keyword
-- Use AS keyword in SELECT clause to construct SELECT SQL statements to solve the following problem and show the results.

--      Q1: Find invoice_number with (invoice_total – payment_total – credit_total) as need_pay and 
--          the calculated value is positive from the invoices table.
SELECT invoice_number, (invoice_total - payment_total - credit_total) AS need_pay
FROM invoices
WHERE (invoice_total - payment_total - credit_total) > 0;



-- Task 2: Practice Join and cross join
-- For you complete this practice, you may need insert more records into both tables by using inner joins SQL statements to solve the following.

-- 5 Sample records for the vendors table
INSERT INTO vendors (vendor_id, vendor_name, vendor_address, vendor_city, vendor_state, vendor_post)
VALUES
    (1, 'ABC Electronics', '123 Main Street', 'Anytown', 'CA', '12345'),
    (2, 'XYZ Supplies', '456 Elm Street', 'Othercity', 'NY', '54321'),
    (3, 'LMN Technologies', '789 Oak Avenue', 'Newville', 'TX', '98765'),
    (4, 'QRS Distributors', '101 Pine Road', 'Smalltown', 'WA', '11111'),
    (5, 'PQR Imports', '202 Maple Lane', 'Sometown', 'GA', '22222');
-- 5 Sample records for the invoices table
INSERT INTO invoices (invoice_id, vendor_id, invoice_number, invoice_date, invoice_total, payment_total, credit_total)
VALUES
    (1, 1, 'INV-20231001', '2023-10-01', 500.00, 250.00, 0.00),
    (2, 2, 'INV-20231002', '2023-10-02', 750.00, 500.00, 0.00),
    (3, 3, 'INV-20231003', '2023-10-03', 1200.00, 1000.00, 50.00),
    (4, 4, 'INV-20231004', '2023-10-04', 300.00, 300.00, 0.00),
    (5, 5, 'INV-20231005', '2023-10-05', 1000.00, 750.00, 100.00);



--      Q1: Find vendor_name and invoice_number where the invoice_total is positive and ensure the
--          outputs are in descending order of invoice_total.
SELECT Vendors.vendor_name, Invoices.invoice_number, Invoices.invoice_total
FROM Vendors
JOIN Invoices ON Vendors.vendor_id = Invoices.vendor_id
WHERE Invoices.invoice_total > 0
ORDER BY Invoices.invoice_total DESC;



--      Q2: Create tables Teacher and Students (refer to lecture notes), find a cross join between the
--          two tables.
-- Create both tables according to lecture notes
CREATE TABLE Teacher (
    t_id INT PRIMARY KEY,
    prof_name VARCHAR(40) 
);
CREATE TABLE Students (
    s_id INT PRIMARY KEY,
    student_name VARCHAR(40),
    prof_id INT
);
-- 5 Sample records for each table
INSERT INTO Teacher (t_id, prof_name)
VALUES
    (1, 'Mr. Smith'),
    (2, 'Mrs. Johnson'),
    (3, 'Dr. Davis'),
    (4, 'Ms. Brown'),
    (5, 'Professor White');
INSERT INTO Students (s_id, student_name, prof_id)
VALUES
    (101, 'Alice', 1),
    (102, 'Bob', 2),
    (103, 'Charlie', 3),
    (104, 'David', 1),
    (105, 'Emily', 4);

-- Perform an inner join between Students and Teachers using prof_id and teacher_id - this will give you students + their corresponding prof.
SELECT Students.student_name, Teacher.prof_name
FROM Students
JOIN Teacher ON Students.prof_id = Teacher.t_id;

-- Perform a cross join because I was asked to:
SELECT Teacher.prof_name, Students.student_name
FROM Teacher
CROSS JOIN Students;

-- Task 3: Practice Aggregate functions, join and having clause

--         Q1: Find a vendor_name that has the biggest invoice_total
SELECT vendor_name, invoice_total
FROM Vendors
JOIN Invoices ON Vendors.vendor_id = Invoices.vendor_id
WHERE Invoices.invoice_total = (SELECT MAX(invoice_total) FROM Invoices);


--         Q2: Find a vendor_name that has the smallest invoice_total
SELECT vendor_name, invoice_total
FROM Vendors
JOIN Invoices ON Vendors.vendor_id = Invoices.vendor_id
WHERE Invoices.invoice_total = (SELECT MIN(invoice_total) FROM Invoices);


--         Q3: Find all vendors’ names that have more than 100 payment dues such that invoice_total- payment_total > 100 
--             (using aggregate function and HAVING clause but not WHERE statement)
SELECT vendor_name, SUM(Invoices.invoice_total - Invoices.payment_total) AS Total_owed
FROM Vendors
JOIN Invoices ON Vendors.vendor_id = Invoices.vendor_id
GROUP BY vendor_name
HAVING SUM(Invoices.invoice_total - Invoices.payment_total) > 100;

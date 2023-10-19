-- Use Database built from Tutorial_1.sql

-- Task 1: Subqueries pt. 1
-- Please use subqueries with the key word “EXISTS” or “IN” to solve the following problem.

--         Q1: Find all vendor names that have invoice _total is bigger than 200.
SELECT vendor_name
FROM Vendors
WHERE Vendors.vendor_id IN (
    SELECT vendor_id
    FROM Invoices
    WHERE invoice_total > 200
);
--         Used to check answers
SELECT Vendors.vendor_name, Invoices.invoice_total
FROM Vendors
JOIN Invoices ON Vendors.vendor_id = Invoices.vendor_id
WHERE Invoices.invoice_total > 200;


-- Task 2: using WITH clause, subqueries pt. 2  
-- Use vendors and invoices tables and WITH clause to solve the following problem by using WITH clause  

--         Q1: Find all vendor names and their cities, and their invoice_total between 100 and 300.
-- Use WITH to create CTE (Common table expression)
WITH VendorInvoices AS (
    SELECT V.vendor_name, V.vendor_city, I.invoice_total
    FROM Vendors V
    JOIN Invoices I ON V.vendor_id = I.vendor_id
    WHERE I.invoice_total BETWEEN 100 AND 300
)
-- Access CTE
SELECT * FROM VendorInvoices;

--         Q2: Suppose that you have two tables Company ( cid , cname , city) and Product (pid , pname , price, cid). 
--             Please refer to file named “week-4-tables&data.txt” in myls.
--             "week-4-tables&data.txt" from myls:
create table company (
 cid int(10) NOT NULL AUTO_INCREMENT primary key,
 cname varchar(20) not null,
 city  varchar(30) not null);
create table product (
 p_ID int(10) NOT NULL AUTO_INCREMENT primary key,
 pname varchar(20) not null,
 price float not null,
 cid int not null,
 FOREIGN KEY (cid) REFERENCES company(cid)
 );
insert into company (cname, city) 
values ('Honda','tokyo'),
       ('Toyota','nagoya'),
	   ('NEC','tokyo'),
       ('HP','Los Angle'),
       ('IMB','Boston'),
	   ('Amazn','Huston');	   
insert into product (pname, price, cid ) 
values ('computer',1106.68,5),
       ('computer',1207.00,4),
	   ('router',1006.26,6),
       ('printer',2106.26,3),
       ('printer',2207.00,2),
	   ('router',2006.26,1);	   
insert into product (pname, price, cid ) 
values ('laptop',1006.68,5);

--             Find product name, the city name where the product has been produced, and the maximum price from the two tables.
-- Create CTE
WITH MaxPriceCTE AS (
    SELECT p.pname AS product_name, c.city AS production_city, MAX(p.price) AS max_price
    FROM product p
    JOIN company c ON p.cid = c.cid
    GROUP BY p.pname, c.city
)
-- Access CTE
SELECT * FROM MaxPriceCTE;

-- Task 3: Pattern Matching
-- Please use key word “LIKE” to solve the following problem.

--         Q1: Find all vendors that their names contain letter “e”.
SELECT vendor_name
FROM Vendors
WHERE vendor_name LIKE '%e%';

--         Q2: Find all vendors that their names start with letter “h”.
SELECT vendor_name
FROM Vendors
WHERE vendor_name LIKE 'h%';

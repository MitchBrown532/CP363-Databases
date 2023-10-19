-- Create tables first
CREATE TABLE Vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name CHAR(20) NOT NULL,
    vendor_address VARCHAR(40) NOT NULL,
    vendor_city VARCHAR(20),
    vendor_state VARCHAR(20),
    vendor_zip_code CHAR(10),
    invoice_id INT
);

CREATE TABLE Invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_number VARCHAR(20),
    invoice_date DATE NOT NULL,
    invoice_total FLOAT,
    payment_total FLOAT,
    credit_total FLOAT,
    vendor_id INT NOT NULL
);

-- Then, add foreign key constraints
ALTER TABLE Vendors 
    ADD FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id);
ALTER TABLE Invoices
     ADD FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id);

-- Add new attribute & change an attribute name
ALTER TABLE Vendors 
    ADD vendor_country VARCHAR(20);

ALTER TABLE Vendors 
    CHANGE vendor_zip_code vendor_post CHAR(10);


-- Insert 1 record
INSERT INTO Vendors
    VALUES (6, 'honda', '203 north street', 'Yokoda', 'Akida','203-112', NULL, 'Japan');
    
INSERT INTO Invoices (invoice_id, invoice_number, invoice_date, invoice_total, payment_total, credit_total, vendor_id)
    VALUES (110,'INV12345', '2023-09-29', 1000.00, 0.00, 0.00, 6);

-- Update the vendor's invoice_id
UPDATE Vendors
SET invoice_id = 110
WHERE vendor_id = 6;

-- Insert multiple records
INSERT INTO Vendors
    VALUES (7, 'Toyoda', '223 south street', 'Koda', 'Kana','100-112', NULL, 'Japan'),
    (9, 'Apple', '46 Apple Road', 'LA', 'Cali','456-001', NULL, 'USA'),
    (8, 'Facebook', '346 Future Road', 'LA', 'Cali','456-887', NULL, 'USA');
    
INSERT INTO Invoices (invoice_id, invoice_date, vendor_id)
    VALUES (120,'2023-09-29', 7),
    (200, '2023-09-29', 9),
    (210, '2023-09-29', 8);

--Update all vendors where foreign key is not yet updated
UPDATE Vendors
SET invoice_id = 120
WHERE vendor_id = 7;

UPDATE Vendors
SET invoice_id = 200
WHERE vendor_id = 9;

UPDATE Vendors
SET invoice_id = 210
WHERE vendor_id = 8;

-- Select records from vendors
SELECT * from Vendors;
SELECT * from Vendors WHERE vendor_country = 'USA';

-- Change FB's name to Meta & change an address
UPDATE Vendors
SET vendor_name = "Meta"
WHERE vendor_name = "Facebook";

UPDATE Vendors
SET vendor_address = "123 Changed Address St."
WHERE vendor_address = "46 Apple Road";
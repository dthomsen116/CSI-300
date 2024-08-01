CREATE DATABASE IF NOT EXISTS Parts;
USE Parts;

CREATE TABLE IF NOT EXISTS Part (
    part_id VARCHAR(10) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS PartHistory (
    part_id VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (part_id) REFERENCES Part(part_id)
);

CREATE TABLE IF NOT EXISTS PartInventory (
    part_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    min_quantity INT NOT NULL,
    FOREIGN KEY (part_id) REFERENCES Part(part_id)
);

CREATE TABLE IF NOT EXISTS PartProduct (
    part_id VARCHAR(10) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (part_id) REFERENCES Part(part_id)
);

CREATE TABLE IF NOT EXISTS PartVendor (
    vendor_id INT NOT NULL,
    part_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (part_id) REFERENCES Part(part_id)
);

CREATE DATABASE IF NOT EXISTS Products;
USE Products;

CREATE TABLE IF NOT EXISTS Product (
    pid INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS ProductInventory (
    pid INT NOT NULL,
    quantity INT NOT NULL,
    last_update DATE NOT NULL,
    min_quantity INT NOT NULL,
    FOREIGN KEY (pid) REFERENCES Product(pid)
);

CREATE TABLE IF NOT EXISTS ProductPriceHistory (
    pid INT NOT NULL,
    date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pid) REFERENCES Product(pid)
);

CREATE TABLE IF NOT EXISTS PartProduct (
    part_id VARCHAR(10) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(pid)
);

CREATE DATABASE IF NOT EXISTS Vendors;
USE Vendors;

CREATE TABLE IF NOT EXISTS Contact (
    vspcontactid INT PRIMARY KEY,
    contact_method VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Company (
    vcid INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Address (
    vcid INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    FOREIGN KEY (vcid) REFERENCES Company(vcid)
);

CREATE TABLE IF NOT EXISTS Salesperson (
    vspid INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    vcid INT NOT NULL,
    FOREIGN KEY (vcid) REFERENCES Company(vcid)
);

CREATE TABLE IF NOT EXISTS SalespersonContact (
    vspid INT NOT NULL,
    vspcontactid INT NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (vspid) REFERENCES Salesperson(vspid),
    FOREIGN KEY (vspcontactid) REFERENCES Contact(vspcontactid)
);

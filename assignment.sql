DROP DATABASE IF EXISTS SalesDB;
CREATE DATABASE SalesDB;
USE SalesDB;
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PRIMARY KEY (CustomerID)
);
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProductID)
);
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    PRIMARY KEY (SaleID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
-- Insert data into Customers
INSERT INTO Customers (FirstName, LastName, Email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Michael', 'Brown', 'michael.brown@example.com');
-- Insert data into Products
INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 300.00);
-- Insert data into Sales
INSERT INTO Sales (CustomerID, ProductID, SaleDate, Quantity) VALUES
(1, 1, '2024-05-01', 1),
(1, 2, '2024-05-03', 2),
(2, 1, '2024-05-04', 1),
(2, 3, '2024-05-05', 1),
(3, 2, '2024-05-06', 3),
(3, 3, '2024-05-07', 2);

SELECT  * FROM  Customers;
SELECT  * FROM  Products;
SELECT  * FROM  Sales;



-- Calculate the average quantity
SELECT AVG(quantity) as AVG_QUANTITY
from sales;

--  Calculate the number of sales made
SELECT SUM(quantity) as TOTAL_SALES
FROM Sales;

-- Calculate the maximum quantity sold
SELECT MAX(quantity) as MAX_QUANTITY
FROM Sales;

-- Calculate the minimum quantity sold
SELECT MIN(quantity) as MIN_QUANTITY
FROM Sales;

-- Calculate the total sales made
SELECT SUM(Total_sales) AS Total_sum
FROM(
SELECT Products.ProductID, Products.Price, SUM((Quantity * Price)) as Total_sales
FROM Products
JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY ProductID) AS Subquery;

-- Calculate the Total Sales Amount by Customer
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, SUM(Sales.Quantity * Products.Price) as Total_SalesCustomers
FROM Sales
JOIN Customers ON Sales.CustomerID = Customers.CustomerID
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY  Customers.CustomerID, Customers.FirstName, Customers.LastName; 

-- Calculate the Total Quantity Sold by Product
SELECT Products.ProductID, Products.ProductName, Products.Price, SUM(Quantity * Price) as Total_ProductQuantity
FROM Products
JOIN Sales ON Products.ProductID = Sales.ProductID
GROUP BY ProductID;

-- Calculate the Average Quantity Sold per Customer
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, AVG(Quantity) as Mean_QuantityCustomer
FROM Customers
JOIN Sales ON Customers.CustomerID = Sales.CustomerID
GROUP BY CustomerID;

-- Customers with Total Sales Amount Greater Than $1500

SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, SUM((Sales.Quantity * Products.Price)) as Total_SalesCustomers
FROM Sales
JOIN Customers ON Sales.CustomerID = Customers.CustomerID
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY  Customers.CustomerID, Customers.FirstName, Customers.LastName
HAVING SUM(Sales.Quantity * Products.Price) > 1500;
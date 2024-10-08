CREATE DATABASE subqueri_assnmnt; 
USE subqueri_assnmnt;
CREATE TABLE Country (Id INT PRIMARY KEY,Country_name VARCHAR(40),Population INT,Area DECIMAL(10, 2));

CREATE TABLE Persons (Id INT PRIMARY KEY,Fname VARCHAR(35),Lname VARCHAR(35),Population INT,
    Rating DECIMAL(3, 2),
    Country_Id INT,
    Country_name VARCHAR(40),
    FOREIGN KEY (Country_Id) REFERENCES Country(Id));
    
    INSERT INTO Country (Id, Country_name, Population, Area)
VALUES
(1, 'USA', 331000000, 9833520.00),
(2, 'Canada', 38000000, 9984670.00),
(3, 'India', 1393409038, 3287263.00),
(4, 'UK', 67886011, 243610.00),
(5, 'Australia', 25687041, 7692024.00),
(6, 'Germany', 83783942, 357022.00),
(7, 'France', 65273511, 551695.00),
(8, 'Japan', 126476461, 377975.00),
(9, 'China', 1444216107, 9596961.00),
(10, 'Brazil', 212559417, 8515767.00);

INSERT INTO Persons (Id, Fname, Lname, Population, Rating, Country_Id, Country_name)
VALUES
(1, 'John', 'devid', 500000, 4.5, 1, 'USA'),
(2, 'Jeena', 'Smith', 800000, 4.0, 2, 'Moroko'),
(3, 'sunil', 'chetri', 1200000, 4.8, 3, 'India'),
(4, 'Emily', 'Jones', 650000, 3.9, 4, 'UK'),
(5, 'anrian', 'loona', 1100000, 4.2, 5, 'Australia'),
(6, 'Hiro', 'Tanaka', 1000000, 4.6, 8, 'Englend'),
(7, 'kiliyan', 'embape', 600000, 3.5, 7, 'France'),
(8, 'Chen', 'Wei', 1500000, 4.9, 9, 'China'),
(9, 'tony', 'croos', 700000, 3.8, 6, 'Germany'),
(10, 'Neymar', 'jr', 950000, 4.1, 10, 'Brazil');

SELECT Country.Country_name, COUNT(Persons.Id) AS Number_of_Persons FROM Country
JOIN Persons ON Country.Id = Persons.Country_Id GROUP BY Country.Country_name;

SELECT Country.Country_name, COUNT(Persons.Id) AS Number_of_Persons FROM Country
JOIN Persons ON Country.Id = Persons.Country_Id
GROUP BY Country.Country_name ORDER BY Number_of_Persons DESC;

SELECT Country.Country_name, AVG(Persons.Rating) AS Avg_Rating FROM Country
JOIN Persons ON Country.Id = Persons.Country_Id
GROUP BY Country.Country_name HAVING AVG(Persons.Rating) > 3.0;

SELECT Country_name
FROM Country
WHERE Id IN (
    SELECT Country_Id
    FROM Persons
    WHERE Rating = (SELECT Rating FROM Persons WHERE Country_Id = 1) -- USA's Country_Id = 1
);

SELECT Country_name FROM Country
WHERE Population > (SELECT AVG(Population) FROM Country);

CREATE DATABASE Product;
USE Product;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,First_name VARCHAR(35),Last_name VARCHAR(35),Email VARCHAR(50),Phone_no VARCHAR(15),
    Address VARCHAR(200),City VARCHAR(60),State VARCHAR(60),Zip_code VARCHAR(10),Country VARCHAR(35));
    

CREATE VIEW customer_info AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email
FROM Customer;

-- SELECT operation for customer_info view
SELECT * FROM customer_info;


CREATE VIEW US_Customers AS SELECT * FROM Customer
WHERE Country = 'USA';

CREATE VIEW Customer_details AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email, Phone_no, State
FROM Customer;

UPDATE Customer SET Phone_no = 'NEW_PHONE_NUMBER' WHERE State = 'California';

SELECT State, COUNT(Customer_Id) AS Number_of_Customers
FROM Customer
GROUP BY State
HAVING COUNT(Customer_Id) > 5;

SELECT State, COUNT(Full_name) AS Number_of_Customers
FROM Customer_details
GROUP BY State;

SELECT * 
FROM Customer_details
ORDER BY State ASC;




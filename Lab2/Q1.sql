CREATE DATABASE OP_Movie
GO
USE OP_Movie
GO
CREATE TABLE Customers
(
	ID INT IDENTITY PRIMARY KEY,
	firstName NVARCHAR(50) ,
	lastName NVARCHAR(50) ,
	DoB DATE,
	phone VARCHAR(11),
	email NVARCHAR (100),
	gender NVARCHAR(10) ,
	[address] NVARCHAR(225)
)

CREATE TABLE Kinds
(
	ID INT IDENTITY PRIMARY KEY,
	[name] NVARCHAR(100) 
)

CREATE TABLE Machines
(
	ID INT IDENTITY PRIMARY KEY,
	kindID INT REFERENCES Kinds(ID),
	street NVARCHAR(100) ,
	district NVARCHAR(100) ,
	[state] NVARCHAR(100) ,
	country NVARCHAR(100) 
)

ALTER TABLE Machines
	ADD city NVARCHAR(100)

CREATE TABLE Categories
(
	ID INT IDENTITY PRIMARY KEY,
	[name] NVARCHAR(100) 
)

CREATE TABLE Producers
(
	ID INT IDENTITY PRIMARY KEY,
	[name] NVARCHAR(100)
)

CREATE TABLE Movies
(
	ID INT  IDENTITY PRIMARY KEY,
	title NVARCHAR(225) ,
	categoryID INT  REFERENCES Categories(ID),
	releaseYear INT ,
	duration NVARCHAR(20) ,
	ranking FLOAT ,
	producerID INT  REFERENCES Producers(ID),
	country NVARCHAR(100) ,
	price FLOAT 
)

CREATE TABLE DVDs
(
	barcode INT  IDENTITY PRIMARY KEY,
	movieID INT  REFERENCES Movies(ID),
	machineID INT  REFERENCES Machines(ID)
)

CREATE TABLE Receipts
(
	receiptNumber INT  IDENTITY PRIMARY KEY,
	machineID INT  REFERENCES Machines(ID),
	customerID INT  REFERENCES Customers(ID),
	returnDate DATE 
)

CREATE TABLE Rentals
(
	rentalNumber INT  IDENTITY PRIMARY KEY,
	customerID INT  REFERENCES Customers(ID),
	machineID INT  REFERENCES Machines(ID),
	rentalDate Date
)

CREATE TABLE RentalDetails
(
	rentalNumber INT  REFERENCES Rentals(rentalNumber),
	DVDbarcode INT  REFERENCES DVDs(barcode),
	rentalPrice FLOAT ,
	receiptNumber INT  REFERENCES Receipts(receiptNumber),
	amount FLOAT ,
	PRIMARY KEY (rentalNumber, DVDbarcode)
)

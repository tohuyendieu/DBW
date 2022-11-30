--DROP DATABASE OP_Movie
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

--sp_rename 'Customers.fistName', 'firstName', 'COLUMN'
--ALTER TABLE Customers
--	ALTER COLUMN lastName NVARCHAR(50)


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


--ALTER DATABASE SCOPED CONFIGURATION 
--  SET VERBOSE_TRUNCATION_WARNINGS = ON; 

INSERT INTO Customers( firstName, lastName, DoB, phone, gender, email, [address])
VALUES 
(N'Hoàng', N'Hiền', '2000-06-08', '0123456789', N'nữ', 'dieu@gmail,com',N'Hà Đông'),
(N'Nguyễn', N'Thương', '2000-04-01', '0987654321', N'nữ', 'thuong@gmail.com', N'Đông Anh'),
(N'Hoàng', N'Yến', '1999-09-05','0988776655', N'khác', 'yen@gmail.com', N'Đông Amh'),
(N'Tạ', N'Huyền', '2000-03-12', '0944332211', N'nữ', 'huyen@gmail.com', N'Hà Đông'),
(N'Nguyễn', N'Giang', '2000-08-24', '0918273654', N'nam', 'giang@gmail.com', N'Hà Nội')


INSERT INTO Kinds([name])
VALUES ('number 1'), ('number 2'),  ('number 3'),  ('number 4'),  ('number 5')

INSERT INTO Machines(kindID, street, district, city, [state], country)
VALUES
(1, N'Hai Bà Trưng', N'Hà Đông', N'Hà Nội', '', N'Việt Nam'),
(2, N'Bà Triệu', N'Hà Đông', N'Hà Nội', '', N'Việt Nam'),
(3, N'Đường số 48', N'Quận 4', N'Hồ Chí Minh', '', N'Việt Nam'),
(4, N'Lê Hồng Phong', N'Qui Nhơn', N'Bình Định','', N'Việt Nam'),
(5, N'Lê Trực', N'Phú Hậu', N'Huế', '', N'Việt Nam')

INSERT INTO Categories([name])
VALUES ('action'), ('animation'), ('comedy'), ('horror'), ('romance'), ('drama')

INSERT INTO Producers([name])
VALUES ('David O.Selznick'),('Nora Grossman'), ('Kevin Feige'), ('Okura Shunsuke'), ('Janet Healy')

INSERT INTO Movies(title, categoryID, releaseYear, duration, ranking, producerID, country, price)
VALUES
('Gone with the wind', 5, 1939, '3h 58m', 8.1, 1, 'America', 5),
('The imitation game', 5, 2014, '1h 54m', 8, 2, 'America', 5),
('Avengers: Infinity war', 1, 2018, '2h 29m', 8.4, 3, 'America', 5),
('Doraemon: Stand by me 2', 2, 2020, '35m', 7.9, 4, 'Janpan', 3),
('Sing', 2, 2016, '50m', 7.1, 5, 'America', 2)

INSERT INTO DVDs(movieID, machineID)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5)


INSERT INTO Rentals(customerID, machineID, rentalDate)
VALUES
(1, 1, '2020-01-01'),
(1, 2, '2021-01-08'),
(2, 3, '2021-02-14'),
(3, 4, '2021-09-18'),
(4, 1, '2020-01-03'),
(4, 2, '2021-08-06')

INSERT INTO Rentals(customerID, machineID, rentalDate)
VALUES
(1, 2, '2021-08-02'),
(1, 1, '2021-09-01'),
(1, 4, '2021-09-05'),
(2, 3, '2021-03-31')


INSERT INTO Receipts(machineID, customerID, returnDate)
VALUES
(3, 1, '2020-01-03'),
(2, 1, '2021-01-10'),
(2, 2, '2021-02-20'),
(4, 3, '2021-09-20'),
(4, 4, '2020-06-15'),
(5, 4, '2021-08-10')

INSERT INTO Receipts(machineID, customerID, returnDate)
VALUES
(5, 2, '2021-09-10'),
(4, 4, '2021-09-11')

INSERT INTO RentalDetails(rentalNumber, DVDbarcode, rentalPrice, receiptNumber)
VALUES
(1, 1, 5, 1),
(2, 2, 5, 2),
(2, 21, 3, 2),
(3, 25, 2, 3),
(4, 16, 3, 4),
(5, 6, 5, 5),
(6, 10, 5, 6)

INSERT INTO RentalDetails(rentalNumber, DVDbarcode, rentalPrice, receiptNumber)
VALUES
(7, 4, 3, 7),
(7, 5, 2, 8),
(8, 3, 5, 8),
(8, 2, 5, 8),
(9, 1, 5, 8),
(10, 22, 3, null),
(8, 23, 3, null) 

MERGE RentalDetails as r
USING (SELECT DVDbarcode, rentalDate, Rentals.rentalNumber, RentalDetails.receiptNumber,				
			(DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+ 1)* rentalPrice AS Amount
		FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
			 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			 JOIN Receipts ON RentalDetails.receiptNumber = Receipts.receiptNumber) AS T
ON r.rentalNumber = t.rentalNumber AND r.DVDbarcode = T.DVDbarcode
WHEN MATCHED THEN UPDATE SET r.amount = T.amount;

/*----------------Question 3-----------------------*/
/*receipt number as the input parameter
 rental number, the rental date,
Rented_Customer_Name, the return date, Returned_Customer_Name, the rented movie
title, the rented movie producer, DVD’s barcode, the unit price, the number of rented
days and the amount
*/

create procedure Question3 @receiptNumber INT
as
begin
    SELECT Rentals.rentalNumber, Rentals.rentalDate, 
	   Customers.firstName +' '+ Customers.lastName AS Rented_Customer_Name,
	   T.returnDate, T.Returned_Customer_Name, T.title, T.producer, T.DVDbarcode, T.rentalPrice,
	   DATEDIFF(day, rentalDate, returnDate)+1  AS Number_Of_Rental_Days,
	   (DATEDIFF(day, rentalDate, returnDate)+1)* T.rentalPrice AS Amount
	FROM
		(SELECT Receipts.returnDate , RentalDetails.rentalNumber,
				Customers.firstName +' '+ Customers.lastName AS Returned_Customer_Name ,
				Movies.title, Producers.[name] AS producer, DVDbarcode, rentalPrice
		FROM Receipts JOIN RentalDetails ON Receipts.receiptNumber = RentalDetails.receiptNumber		
			JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			JOIN Movies ON DVDs.movieID = Movies.ID
			JOIN Producers ON Movies.producerID = Producers.ID
			JOIN Customers ON Receipts.customerID = Customers.ID
		WHERE Receipts.receiptNumber = @receiptNumber) as T 
		JOIN Rentals ON T.rentalNumber = Rentals.rentalNumber
		JOIN Customers ON Rentals.customerID = Customers.ID
end

--exec Question3 8

/* ------------------ Question 4-----------------*/
/*rental number as an input parameter 
DVD’s barcode, rented movie title, rental date,
Rented_Customer_Name, return date, Returned_Customer_ Name, unit price, number
of rented days and the amount */
--drop procedure Question4

create procedure Question4 @rentalNumber INT
as
begin
	SELECT T.DVDbarcode, T.title, T.rentalDate, T.Rented_Customer_Name, Receipts.returnDate,
		   Customers.firstName +' '+ Customers.lastName AS Returned_Customer_Name,
		   T.rentalPrice, 
		   DATEDIFF(day, T.rentalDate, Receipts.returnDate)+ 1 AS Number_Of_Rental_Days,
		   (DATEDIFF(day, T.rentalDate, Receipts.returnDate)+ 1)* T.rentalPrice AS Amount
	FROM
		(SELECT DVDbarcode, title, rentalDate, Rentals.rentalNumber, RentalDetails.receiptNumber,
			   Customers.firstName +' '+ Customers.lastName AS Rented_Customer_Name,
			   rentalPrice
		FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
			 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			 JOIN Movies ON DVDs.movieID = Movies.ID
			 JOIN Customers ON Rentals.customerID = Customers.ID
		WHERE Rentals.rentalNumber = @rentalNumber) AS T
		JOIN Receipts ON T.receiptNumber = Receipts.receiptNumber
		JOIN Customers ON Receipts.customerID = Customers.ID
end

--exec Question4 8

/* ------------------------------------------------------------------------------------- Question 5-----------------------------------------*/
/* trigger for automatically update the current machine of the corresponding DVD
to null when inserting a DVD into a rental */

create trigger Question5
on RentalDetails
for INSERT
as
begin
    UPDATE DVDs
	SET machineID = null
	WHERE barcode in (
		SELECT inserted.DVDbarcode
		FROM inserted
	)
end

--INSERT INTO RentalDetails(rentalNumber, DVDbarcode, rentalPrice, receiptNumber)
--VALUES (10, 24, 3, null)

/* ------------------------------------------------------------------------------------- Question 6---------------------------------------------------------*/
/* a trigger for automatically calculate the Amount when returning a movie to a machine
                 updates also the current machine of the corresponding DVD to the current machine*/
		
create trigger Question6
on RentalDetails
after UPDATE, INSERT 
NOT FOR REPLICATION
as 
begin
-- begin Transaction
	UPDATE DVDs
	SET machineID = (Select machineID
					 From inserted join Receipts on inserted.receiptNumber = Receipts.receiptNumber)
	WHERE DVDs.barcode in (select inserted.DVDbarcode From inserted);	

	UPDATE RentalDetails
	SET Amount = (Select (DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+1)*inserted.rentalPrice
				  From inserted join Rentals on  inserted.rentalNumber = Rentals.rentalNumber
					   join Receipts on inserted.receiptNumber = Receipts.receiptNumber
				  )
	WHERE RentalDetails.DVDbarcode in (select inserted.DVDbarcode From inserted)
		AND RentalDetails.rentalNumber in (select inserted.rentalNumber From inserted);
 --COMMIT;
end


/*UPDATE RentalDetails
SET receiptNumber = 4
WHERE rentalNumber = 10 and DVDbarcode = 22 */

/*UPDATE RentalDetails
SET receiptNumber = null, amount = null
WHERE rentalNumber = 10 and DVDbarcode = 22
update DVDs set machineID = null where barcode =22*/

/* ------------------------------------------------------------------------------------- Question 7---------------------------------------------------------*/
-- tắt trigger Question6 để update toàn bộ amount đã có receiptNumber nhưng chưa tính amount khi insert dữ liệu từ đầu  
DISABLE TRIGGER Question6
ON RentalDetails

MERGE RentalDetails as r
USING (SELECT DVDbarcode, rentalDate, Rentals.rentalNumber, RentalDetails.receiptNumber,				
			(DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+ 1)* rentalPrice AS Amount
		FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
			 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			 JOIN Receipts ON RentalDetails.receiptNumber = Receipts.receiptNumber) AS T
ON r.rentalNumber = t.rentalNumber AND r.DVDbarcode = T.DVDbarcode
WHEN MATCHED THEN UPDATE SET r.amount = T.amount;

-- bật lại trigger Question6
ENABLE TRIGGER Question6
ON RentalDetails


/*Question7: create a function for calculating the total amount of a movie rented in a period where
   MovieID, fromTime and toTime are three input parameters of the function */

-- tắt trigger Question6 để update toàn bộ amount đã có receiptNumber nhưng chưa tính amount khi insert dữ liệu từ đầu  
DISABLE TRIGGER Question6
ON RentalDetails

MERGE RentalDetails as r
USING (SELECT DVDbarcode, rentalDate, Rentals.rentalNumber, RentalDetails.receiptNumber,				
			(DATEDIFF(day, Rentals.rentalDate, Receipts.returnDate)+ 1)* rentalPrice AS Amount
		FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
			 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
			 JOIN Receipts ON RentalDetails.receiptNumber = Receipts.receiptNumber) AS T
ON r.rentalNumber = t.rentalNumber AND r.DVDbarcode = T.DVDbarcode
WHEN MATCHED THEN UPDATE SET r.amount = T.amount;

-- bật lại trigger Question6
ENABLE TRIGGER Question6
ON RentalDetails

create function Question7(@MovieID INT, @fromTime DATE, @toTime DATE)
returns INT
as
begin
	declare @totalAmount int

	Select @totalAmount = sum(RentalDetails.amount)
	From Rentals join RentalDetails on Rentals.rentalNumber = RentalDetails.rentalNumber
		 join DVDs on RentalDetails.DVDbarcode = DVDs.barcode
	Where Rentals.rentalDate >= @fromTime and Rentals.rentalDate <= @toTime 
		And DVDs.movieID = @MovieID
	Group by DVDs.movieID

	return @totalAmount
end

--SELECT dbo.Question7(2, '2019-01-01', '2022-01-01')

/* ------------------------------------------------------------------------------------- Question 8---------------------------------------------------------*/
/* query :the total quantity of each category by customer gender*/

SELECT Customers.gender, Categories.[name], count(Categories.ID)
FROM Rentals JOIN Customers ON Rentals.customerID = Customers.ID
	 JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
	 JOIN Movies ON DVDs.movieID = Movies.ID
	 JOIN Categories ON Movies.categoryID = Categories.ID
GROUP BY Customers.gender, Categories.[name], Categories.ID

/* ------------------------------------------------------------------------------------- Question 9---------------------------------------------------------*/
/* the total amount of each movie by rental year*/

SELECT title, movieID, total_amount = sum(Amount), year(rentalDate) as [year]
FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
	 JOIN Movies ON DVDs.movieID = Movies.ID
GROUP BY  year(rentalDate), movieID, title


/* ------------------------------------------------------------------------------------- Question 10---------------------------------------------------------*/
/*the total quantity of rented DVDs in each machine*/

SELECT Rentals.machineID, count(Rentals.machineID) AS Quantity
FROM Rentals JOIN RentalDetails ON Rentals.rentalNumber = RentalDetails.rentalNumber
	 JOIN DVDs ON RentalDetails.DVDbarcode = DVDs.barcode
GROUP BY Rentals.machineID
/*--------------------------------------------------------------------*/
select* from RentalDetails
select*from dim_customer

create view Fact_op
as
with t as (select rentalDate, Customers.Gender,  

case  

when DATEDIFF(year,DoB,RentalDate) < 20 then 'Age < 20' 

when DATEDIFF(year,DoB,RentalDate) >= 20 and DATEDIFF(year,DoB,RentalDate) < 30 then '20 <= Age < 30' 

when DATEDIFF(year,DoB,RentalDate) >= 30 and DATEDIFF(year,DoB,RentalDate) < 40 then '30 <= Age < 40' 

when DATEDIFF(year,DoB,RentalDate) >= 40 and DATEDIFF(year,DoB,RentalDate) < 50 then '40 <= Age < 50' 

else 'Age >= 50' 

end as Age, RentalM.District as RentalDistrict, 

RentalM.City as RentalCity, RentalM.State as RentalState, RentalM.Country as RentalCountry, 

MovieID,  

case  

When RentalDetails.rentalPrice < 1 then '0 <= Price < 1' 

when RentalDetails.rentalPrice >= 1 and RentalDetails.rentalPrice <1.5 then '1 <= Price < 1.5' 

when RentalDetails.rentalPrice >= 1.5 and RentalDetails.rentalPrice < 2 then '1.5 <= Price < 2' 

else 'Price >= 2' 

end as Price, ReturnDate, 

ReturnMachine.District as ReturnDistrict, ReturnMachine.City as ReturnCity, 

ReturnMachine.State as returnState, ReturnMachine.Country as ReturnCountry, 

DATEDIFF(day,RentalDate,ReturnDate) as Duration 

from Rentals join Customers on Rentals.CustomerID = Customers.ID 

join Machines RentalM on Rentals.MachineID = RentalM.ID 

join RentalDetails on Rentals.RentalNumber = RentalDetails.RentalNumber 

join DVDs on RentalDetails.DVDbarcode = DVDs.barcode 

left join Receipts on RentalDetails.ReceiptNumber = Receipts.ReceiptNumber 

left join Machines ReturnMachine on ReturnMachine.ID = Receipts.MachineID) 

select t.RentalDate, t.ReturnDate, Gender, Age, MovieID, Price, 

RentalDistrict, RentalCity, RentalState, RentalCountry, 

ReturnDistrict, ReturnCity, returnState, ReturnCountry, avg(Duration) as Duration, count(*) as Quantity 

from t  

group by t.RentalDate, t.ReturnDate, Gender, Age, MovieID, Price, 

RentalDistrict, RentalCity, RentalState, RentalCountry, 

ReturnDistrict, ReturnCity, returnState, ReturnCountry 
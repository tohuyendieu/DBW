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
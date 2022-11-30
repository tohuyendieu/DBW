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
		LEFT JOIN Receipts ON T.receiptNumber = Receipts.receiptNumber
		LEFT JOIN Customers ON Receipts.customerID = Customers.ID
end

--exec Question4 8
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
